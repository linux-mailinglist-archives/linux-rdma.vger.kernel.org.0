Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D21D6100793
	for <lists+linux-rdma@lfdr.de>; Mon, 18 Nov 2019 15:42:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727121AbfKROmA (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 18 Nov 2019 09:42:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:54690 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726668AbfKROl7 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 18 Nov 2019 09:41:59 -0500
Received: from localhost (unknown [5.29.147.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E7A0F206B6;
        Mon, 18 Nov 2019 14:41:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574088118;
        bh=z+TGrQ61Yn+JYGlppRs/r4rrQ2uTvjw3A/AQ6OmLFKY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=e8rZCMFpEfGzIBTEKjyEhSxcK8HLT/F2lyNhkz97L3TKjdRVEsRXm4coreOVfszRQ
         WWnNHpYt/2mHOUk+jfcpi396vJHzjVmHJjr6noMa1NbAc+855GhLhlwmFVhU4U15k/
         gij+i+tv9kn7ExlNfMFzJkI7u329aG29O572CixA=
Date:   Mon, 18 Nov 2019 16:41:55 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     wangqi <3100102071@zju.edu.cn>
Cc:     linux-rdma@vger.kernel.org
Subject: Re: [question]Why our soft-RoCE throughput is quite low compared
 with TCP
Message-ID: <20191118144155.GE52766@unreal>
References: <f97b72b6-4def-2970-c9f6-f11b97d5378e@zju.edu.cn>
 <20191115160707.GG6763@unreal>
 <df9fb9b8-4b1f-2cf7-2498-648627556006@zju.edu.cn>
 <20191118094924.GA52766@unreal>
 <0bb80672-3980-04e7-5cf1-846b517ad53e@zju.edu.cn>
 <20191118122803.GC52766@unreal>
 <b522945c-6995-06de-b22c-9285fbe65d66@zju.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b522945c-6995-06de-b22c-9285fbe65d66@zju.edu.cn>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Nov 18, 2019 at 08:56:35PM +0800, wangqi wrote:
>
> On 2019/11/18 下午8:28, Leon Romanovsky wrote:
> > On Mon, Nov 18, 2019 at 06:13:07PM +0800, wangqi wrote:
> >> On 2019/11/18 下午5:49, Leon Romanovsky wrote:
> >>> On Mon, Nov 18, 2019 at 02:38:19PM +0800, wangqi wrote:
> >>>> On 2019/11/16 上午12:07, Leon Romanovsky wrote:
> >>>>
> >>>>> On Fri, Nov 15, 2019 at 09:26:41PM +0800, QWang wrote:
> >>>>>> Dear experts on RDMA,
> >>>>>>       We are sorry to disturb you. Because of a project, we need to
> >>>>>> integrate soft-RoCE in our system. However ,we are very confused by our
> >>>>>> soft-RoCE throughput results, which are quite low compared with TCP
> >>>>>> throughput. The throughput of soft-RoCE in our tests measured by ib_send_bw
> >>>>>> and ib_read_bw is only 2 Gbps (the net link bandwidth is 100 Gbps and the
> >>>>>> two Xeon E5 servers with Mellanox ConnectX-4 cards are connected via
> >>>>>> back-to-back, the OS is ubuntu16.04 with kernel 4.15.0-041500-generic). The
> >>>>>> throughput of hard-RoCE and TCP are normal, which are 100 Gbps and 20 Gbps,
> >>>>>> respectively. But in the figure 6 in the attached paper "A Performance
> >>>>>> Comparison of Container Networking Alternatives", the throughput of
> >>>>>> soft-RoCE can be up to 23 Gbps.  In our tests, we get the open-source
> >>>>>> soft-RoCE from github in https://github.com/linux-rdma. Do you know how can
> >>>>>> we get such high bandwidth? Do we need to configure some OS system settings?
> >>>>>>       We find that in 2017, someone finds the same problem and he posts all
> >>>>>> his detailed results on https://bugzilla.kernel.org/show_bug.cgi?id=190951  
> >>>>>> . But it remains unsolved. His results are nearly the same with our's. For
> >>>>>> simplicity,  we do not post our results in this email. You can get very
> >>>>>> detailed information in the web page listed above.
> >>>>>>       We are very confused by our results. We will very appreciate it if we
> >>>>>> can receive your early reply. Best wishes,
> >>>>>> Wang Qi
> >>>>> Can you please fix your email client?
> >>>>> The email text looks like one big sentence.
> >>>>>
> >>>>> From the perf report attached to this bugzilla, looks like RXE does a
> >>>>> lot of CRC32 calculations and it is consistent with what Matan said
> >>>>> a long time ago, RXE "stuck" in ICRC calculations required by spec.
> >>>>>
> >>>>> I'm curios what are your CONFIG_CRYPTO_* configs?
> >>>>>
> >>>>> ThanksCONFIG_CRYPTO_* configs
> >>>>>
> >>>>>
> >>>> I'm sorry for the editor problem in my last email. Now I use another editor.
> >>> Now your email has extra line between lines.
> >>>
> >>>> We get our rdma-core and perftest from
> >>>>
> >>>> https://github.com/linux-rdma/rdma-core/archive/v25.0.tar.gz
> >>>> and https://github.com/linux-rdma/perftest/archive/4.4-0.8.tar.gz, respectively.
> >>>>
> >>>> We attach five files to clarify our problem.
> >>>>
> >>>> * The first file "server_tcp_vs_softroce_performance.txt" is the results of TCP
> >>>>
> >>>> and softroce throughput in our two servers (connected via back to back).
> >>>>
> >>>> * The second file "server_CONFIG_CRYPTO_result.txt" is the
> >>>>
> >>>> CONFIG_CRYPTO_* config results in the two servers..
> >>>>
> >>>> * The third file "server_perf.txt" is the "ib_send_bw - n 10000 192.168.0.20
> >>>>
> >>>> & perf record -ags sleep 10 & wait" results in our two servers (we use
> >>>>
> >>>> "perf report --header >perf" to make the file).
> >>>>
> >>>> * The fourth file "vm_tcp_vs_softroce_performance.txt" is the results of TCP
> >>>>
> >>>> and softroce throughput in two virtual machines with the latest linux kernel
> >>>>
> >>>> 5.4.0-rc7
> >>>>
> >>>> (we get the kernel from https://github.com/torvalds/linux/archive/v5.4-rc7.zip).
> >>>>
> >>>> * The fifth  file "vm_CONFIG_CRYPTO_result.txt" is the result in two virtual
> >>>>
> >>>> machines.
> >>>>
> >>>> * The sixth file "vm_perf.txt" is the "ib_send_bw - n 10000 192.168.122.228
> >>>>
> >>>> & perf record -ags sleep 10 & wait " result in the two virtual machines.
> >>>>
> >>>> On the other side, we tried to use the rxe command "rxe_cfg crc disable"
> >>> I don't see any parsing of "crc disable" in upstream variant of rxe_cfg
> >>> and there is no such module parameter in the kernel.
> >>>
> >>> Thanks
> >>
> >> We get the command "rxe_cfg crc disable" from the following webpages:
> >>
> >> https://www.systutorials.com/docs/linux/man/8-rxe_cfg/
> >>
> >> https://www.reflectionsofthevoid.com/2011/08/
> >>
> >> It may be removed in the present soft-roce edition.
> > It was never existed in upstream variant and in the kernel you are testing.
> >
> >> Can you figure out why our softroce throughput is so low from the six
> > According to the logs, it is ICRC.
> >
> >> files in our last email? We hope to get a much higher softroce throughput,
> >>
> >> like 20 Gbps in our systems (now it's only 2 Gbps, and hard-roce can be
> >>
> >> up to 100 Gbps in our system).
> >>
> >> Qi
> >>
> >>
> We try to use "rxe_cfg icrc disable" and "rxe_cfg ICRC disable", but it
>
> seems that the performance doesn't change at all.

Why are you continuing to try "disable" if your kernel and rdma-core don't support it?

Thanks

>
> Qi
>
>
>
