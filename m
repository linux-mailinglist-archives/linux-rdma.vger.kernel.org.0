Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3F1DCE0398
	for <lists+linux-rdma@lfdr.de>; Tue, 22 Oct 2019 14:08:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388954AbfJVMId (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 22 Oct 2019 08:08:33 -0400
Received: from mga11.intel.com ([192.55.52.93]:16238 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388106AbfJVMId (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 22 Oct 2019 08:08:33 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 Oct 2019 05:08:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,327,1566889200"; 
   d="scan'208";a="398994993"
Received: from jerryopenix.sh.intel.com (HELO jerryopenix) ([10.239.158.171])
  by fmsmga006.fm.intel.com with ESMTP; 22 Oct 2019 05:08:31 -0700
Date:   Tue, 22 Oct 2019 20:05:56 +0800
From:   "Liu, Changcheng" <changcheng.liu@intel.com>
To:     Doug Ledford <dledford@redhat.com>
Cc:     linux-rdma@vger.kernel.org
Subject: Re: rdma performance verification
Message-ID: <20191022120556.GA830170@jerryopenix>
References: <20190916094234.GA11772@jerryopenix>
 <4f01d52616a4a8f767b95bda7fd68e62d8c1f8ae.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4f01d52616a4a8f767b95bda7fd68e62d8c1f8ae.camel@redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 16:30 Mon 21 Oct, Doug Ledford wrote:
> On Mon, 2019-09-16 at 17:42 +0800, Liu, Changcheng wrote:
> > Hi all,
> >    I'm working on using rdma to improve message transaction
> qperf is nice because it will do both the tcp and rdma testing, so the
> same set of options will make it behave the same way under both tests.
@Doug Ledford:
   I'll check how to use it to compare RDMA & TCP.
> 
> I think you are mis-reading the instructions on ib_send_bw.  First of
> all, IB RC queue pairs are, when used in send/recv mode, message passing
> devices, not a stream device.  When you specified the -s parameter of

@Doug Ledford:
   What's the difference between "message passing device" and "stream
   device"?

> 1GB, you were telling it to use messages of 1GB in size, not to pass a
> total of 1GB of messages.  And the default number of messages to pass is
> 1,000 iterations (the -n or --iters options), so you were actually
@Doug Ledford:
   Thanks for your information. It helps me a lot.
> testing a 1,000GB transfer.  You would be better off to use a smaller
> message size and then set the iters to the proper value.  This is what I
> got with 1000 iters and 1GB message size:
> 
>  #bytes     #iterations    BW peak[MB/sec]    BW average[MB/sec]   MsgRate[Mpps]
>  1073741824    1000             6159.64            6159.46		   0.000006
> ---------------------------------------------------------------------------------------
> 
> real	3m3.101s
> user	3m2.430s
> sys	0m0.450s
> 
> I tried dropping it to 1 iteration to make a comparison, but that's not
> even allowed by ib_send_bw, it wants a minimum of 5 iterations.  So I
> did 8 iterations at 1/8th GB in size and this is what I got:
> 
>  #bytes     #iterations    BW peak[MB/sec]    BW average[MB/sec]   MsgRate[Mpps]
>  134217728    8                6157.54            6157.54		   0.000048
> ---------------------------------------------------------------------------------------
> 
> real	0m2.506s
> user	0m2.411s
> sys	0m0.059s
> 
> When I adjust that down to 1MB and 1024 iters, I get:
> 
>  #bytes     #iterations    BW peak[MB/sec]    BW average[MB/sec]   MsgRate[Mpps]
>  1048576    1024             6157.74            6157.74		   0.006158
> ---------------------------------------------------------------------------------------
> 
> real	0m0.427s
> user	0m0.408s
> sys	0m0.002s
> 
> The large difference in time between these last two tests, given that
> the measured bandwidth is so close to identical, explains the problem
> you are seeing below.
> 
> The ib_send_bw test is a simple test.  It sets up a buffer by
> registering its memory, then just slams that buffer over the wire.  With
> a 128MB buffer, you pay a heavily memory registration penalty.  That's
> factored into the 2s time difference between the two runs.  When you use
> a 1GB buffer, the delay is noticeable to the human eye.  There is a very
> visible pause as the server and client start their memory registrations.
@Doug Ledford:
   Do you mean that every RDMA-SGE(Scatter/Gather element) will use
   seperate MR(Memory Region)?
   If all the RDMA-SGE use only one pre-allocated MR-1GB, the two tests
   shouldn't have so much time consuming difference.

> 
> >    In Ceph, the result shows that rdma performance (RC transaction
> > type,
> >    SEDN operation) is worse or not much better than TCP implemented
> > performance.
> >    Test A:
> >       1 client thread send 20GB data to 1 server thread (marked as
> > 1C:1S)
> >    Result:
> >       1) implementation based on RDMA
> >          Take 171.921294s to finish send 20GB data.
> >       2) implementation based on TCP
> >          Take 62.444163s to finish send 20GB data.
> > 
> >    Test B:
> >       16 client threads send 16x20GB data to 1 server thread (marked
> > as 16C:1S)
> >    Result:
> >       1) implementation base on RDMA
> >          Take 261.285612s to finish send 16x20GB data.
> >       2) implementation based on TCP
> >          Take 318.949126 to finish send 16x20GB data.
> 
> I suspect your performance problems here are memory registrations.  As
> noted by Chuck Lever in some of his recent postings, memory
> registrations can end up killing performance for small messages, and the
> tests I've shown here indicate, they're also a killer for huge memory
> blocks if they are repeatedly registered/deregistered.  TCP has no

I think we could pre-registered 1GB MR and then all the SGE share with the
same MR, then it could mitigate the penalty in register/deregister.

> memory registration overhead, so in the single client case, it is
> outperforming the RDMA case.  But in the parallel case with lots of
> clients, the memory registration overhead is spread out among many
> clients, so we are able to perform better overall.

In Ceph implementation, all the threads in the same process share with
the same pre-registered 1GB MR. The MR is divided into lots of chunks to
be used as SGE.
In this way, how to explain the test result between Test-A & Test-B?

> 
> In a nutshell, it sounds like the Ceph transfer engine over RDMA is not
> optimized at all, and is hitting problems with memory registration
> overhead.
Ceph/RDMA seems not widely used and some implementation need to be
optimized. I'm going to work on it in future.
> 
> -- 
> Doug Ledford <dledford@redhat.com>
>     GPG KeyID: B826A3330E572FDD
>     Fingerprint = AE6B 1BDA 122B 23B4 265B  1274 B826 A333 0E57 2FDD
