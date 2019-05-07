Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 40022164AB
	for <lists+linux-rdma@lfdr.de>; Tue,  7 May 2019 15:38:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726435AbfEGNhX convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-rdma@lfdr.de>); Tue, 7 May 2019 09:37:23 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:58580 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726428AbfEGNhX (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 7 May 2019 09:37:23 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x47DQpRo001739
        for <linux-rdma@vger.kernel.org>; Tue, 7 May 2019 09:37:22 -0400
Received: from smtp.notes.na.collabserv.com (smtp.notes.na.collabserv.com [158.85.210.109])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2sba8atqp6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-rdma@vger.kernel.org>; Tue, 07 May 2019 09:37:21 -0400
Received: from localhost
        by smtp.notes.na.collabserv.com with smtp.notes.na.collabserv.com ESMTP
        for <linux-rdma@vger.kernel.org> from <BMT@zurich.ibm.com>;
        Tue, 7 May 2019 13:37:21 -0000
Received: from us1b3-smtp06.a3dr.sjc01.isc4sb.com (10.122.203.184)
        by smtp.notes.na.collabserv.com (10.122.47.48) with smtp.notes.na.collabserv.com ESMTP;
        Tue, 7 May 2019 13:37:16 -0000
Received: from us1b3-mail162.a3dr.sjc03.isc4sb.com ([10.160.174.187])
          by us1b3-smtp06.a3dr.sjc01.isc4sb.com
          with ESMTP id 2019050713371563-531333 ;
          Tue, 7 May 2019 13:37:15 +0000 
In-Reply-To: <49b807221e5af3fab8813a9ce769694cb536072a.camel@redhat.com>
Subject: Re: iWARP and soft-iWARP interop testing
From:   "Bernard Metzler" <BMT@zurich.ibm.com>
To:     "Doug Ledford" <dledford@redhat.com>
Cc:     "linux-rdma" <linux-rdma@vger.kernel.org>,
        "Gunthorpe, Jason" <jgg@ziepe.ca>
Date:   Tue, 7 May 2019 13:37:16 +0000
MIME-Version: 1.0
Sensitivity: 
Importance: Normal
X-Priority: 3 (Normal)
References: <49b807221e5af3fab8813a9ce769694cb536072a.camel@redhat.com>
X-Mailer: IBM iNotes ($HaikuForm 1048) | IBM Domino Build
 SCN1812108_20180501T0841_FP38 April 10, 2019 at 11:56
X-KeepSent: E1E7EE12:36A09436-002583F3:00346573;
 type=4; name=$KeepSent
X-LLNOutbound: False
X-Disclaimed: 52227
X-TNEFEvaluated: 1
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset=UTF-8
x-cbid: 19050713-3721-0000-0000-00000674530E
X-IBM-SpamModules-Scores: BY=0; FL=0; FP=0; FZ=0; HX=0; KW=0; PH=0;
 SC=0.399202; ST=0; TS=0; UL=0; ISC=; MB=0.337069
X-IBM-SpamModules-Versions: BY=3.00011065; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000285; SDB=6.01199890; UDB=6.00629533; IPR=6.00980772;
 BA=6.00006300; NDR=6.00000001; ZLA=6.00000005; ZF=6.00000009; ZB=6.00000000;
 ZP=6.00000000; ZH=6.00000000; ZU=6.00000002; MB=3.00026768; XFM=3.00000015;
 UTC=2019-05-07 13:37:19
X-IBM-AV-DETECTION: SAVI=unsuspicious REMOTE=unsuspicious XFE=unused
X-IBM-AV-VERSION: SAVI=2019-05-07 06:18:24 - 6.00009895
x-cbparentid: 19050713-3722-0000-0000-0000FDD75D34
Message-Id: <OFE1E7EE12.36A09436-ON002583F3.00346573-002583F3.004AD2B1@notes.na.collabserv.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-07_07:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi Doug,

many thanks for taking the time and effort...! 
I'd love to have all that HW around here.

Some comments inline

Thanks very much!
Bernard.

-----"Doug Ledford" <dledford@redhat.com> wrote: -----

>To: "linux-rdma" <linux-rdma@vger.kernel.org>
>From: "Doug Ledford" <dledford@redhat.com>
>Date: 05/06/2019 10:38PM
>Cc: "Gunthorpe, Jason" <jgg@ziepe.ca>, "Bernard Metzler"
><BMT@zurich.ibm.com>
>Subject: iWARP and soft-iWARP interop testing
>
>So, Jason and I were discussing the soft-iWARP driver submission, and
>he
>thought it would be good to know if it even works with the various
>iWARP
>hardware devices.  I happen to have most of them on hand in one form
>or
>another, so I set down to test it.  In the process, I ran across some
>issues just with the hardware versions themselves, let alone with
>soft-
>iWARP.  So, here's the results of my matrix of tests.  These aren't
>performance tests, just basic "does it work" smoke tests...
>
>Hardware:
>i40iw = Intel x722
>qed1 = QLogic FastLinQ QL45000
>qed2 = QLogic FastLinQ QL41000
>cxgb4 = Chelsio T520-CR
>
>
>
>Test 1:
>rping -s -S 40 -C 20 -a $local
>rping -c -S 40 -C 20 -I $local -a $remote
>
>                    Server Side
>	i40iw		qed1		qed2		cxgb4		siw
>i40iw	FAIL[1]		FAIL[1]		FAIL[1]		FAIL[1]		FAIL[1]
>qed1	FAIL[1]		FAIL[1]		FAIL[1]		FAIL[1]		FAIL[1]
>qed2	FAIL[1]		FAIL[1]		FAIL[1]		FAIL[1]		FAIL[1]
>cxgb4	FAIL[1]		FAIL[1]		FAIL[1]		FAIL[1]		FAIL[1]
>siw	FAIL[2]		FAIL[1]		FAIL[1]		FAIL[1]		Untested
>
>Failure 1:
>Client side shows:
>client DISCONNECT EVENT...
>Server side shows:
>server DISCONNECT EVENT...
>wait for RDMA_READ_ADV state 10
>

I see the same behavior between two siw instances. In my tests, these events
are created only towards the end of the rping test. Using the -v flag on
client and server, I see the right amount of data being exchanged before
('-C 2' to save space here):

Server:
[bmt@rims ~]$ rping -s -S 40 -C 2 -a 10.0.0.1 -v
server ping data: rdma-ping-0: ABCDEFGHIJKLMNOPQRSTUVWXYZ
server ping data: rdma-ping-1: BCDEFGHIJKLMNOPQRSTUVWXYZ[
server DISCONNECT EVENT...
wait for RDMA_READ_ADV state 10
[bmt@rims ~]$ 

Client:
[bmt@spoke ~]$ rping -c -S 40 -C 2 -I 10.0.0.2 -a 10.0.0.1 -v
ping data: rdma-ping-0: ABCDEFGHIJKLMNOPQRSTUVWXYZ
ping data: rdma-ping-1: BCDEFGHIJKLMNOPQRSTUVWXYZ[
client DISCONNECT EVENT...
[bmt@spoke ~]$ 

I am not sure if that DISCONNECT EVENT thing is a failure
though, or just the regular end of the test.


>Failure 2:
>Client side shows:
>cma event RDMA_CM_EVENT_REJECTED, error -104
>wait for CONNECTED state 4
>connect error -1
>Server side show:
>Nothing, server didn't indicate anything had happened
>

Looks like an MPA reject - maybe this is due to i40iw being
unwilling to switch of CRC, if it is not turned on at siw
side? Or any other MPA reject reason...for fixing, we could
take that issue into a private conversation thread. Turning
on siw debugging will likely show the reason.


>Obviously, rping appears to be busted on iWARP (which surprises me to
>be
>honest...it's part of the rdmacm-utils and should be using the rdmacm
>connection manager, which is what's required to work on iWARP, but
>maybe
>it just has some simple bug that needs fixed).
>

As said above, its maybe just the awkward end of the test run,
which should not display the DISCONNECT event.

>Test 2:
>ib_read_bw -d $device -R
>ib_read_bw -d $device -R $remote
>
>                    Server Side
>	i40iw		qed1		qed2		cxgb4		siw
>i40iw	PASS		PASS		PASS		PASS		PASS
>qed1	PASS		PASS		PASS		PASS		PASS[1]
>qed2	PASS		PASS		PASS		PASS		PASS[1]
>cxgb4	PASS		PASS		PASS		PASS		PASS
>siw	FAIL[1]		PASS		PASS		PASS		untested
>
>Pass 1:
>These tests passed, but show pretty much worst case performance
>behavior.  While I got 600MB/sec on one test, and 175MB/sec on
>another,
>the two that I marked were only at the 1 or 2MB/sec level.  I thought
>they has hung initially.

Compared to plain TCP, performance suffers from not using
segmentation offloading.  Also, always good to set MTU size to max. 
With all that, on a 40Gbs link, line speed should be possible.
But, yes, performance is not our main focus currently.

>
>Test 3:
>qperf
>qperf -cm1 -v $remote rc_bw
>
>                    Server Side
>	i40iw		qed1		qed2		cxgb4		siw
>i40iw	PASS[1]		PASS		PASS[1]		PASS[1]		PASS
>qed1	PASS[1]		PASS		PASS[1]		PASS[1]		PASS
>qed2	PASS[1]		PASS		PASS[1]		PASS		PASS
>cxgb4	FAIL[2]		FAIL[2]		FAIL[2]		FAIL[2]		FAIL[2]
>siw	FAIL[3]		PASS		PASS		PASS		untested
>
>Pass 1:
>These passed, but only with some help.  After each client ran, the
>qperf
>server had to be restarted or else the client would show this error:
>rc_bw:
>failed to receive RDMA CM TCP IPv4 server port: timed out
>
>Fail 2:
>Whenever cxgb4 was the client side, the test would appear to run
>(including there was a delay appropriate for the test to run), but
>when
>it should have printed out results, it printed this instead:
>rc_bw:
>rdma_disconnect failed: Invalid argument
>
>Fail 3:
>Server side showed no output
>Client side showed:
>rc_bw:
>rdma_connect failed
>
>So, there you go, it looks like siw actually does a reasonable job of
>working, at least at the functionality level, and in some cases even
>has
>modestly decent performance.  I'm impressed.  Well done Bernard.
>
>-- 
>Doug Ledford <dledford@redhat.com>
>    GPG KeyID: B826A3330E572FDD
>    Key fingerprint = AE6B 1BDA 122B 23B4 265B  1274 B826 A333 0E57
>2FDD
>
[attachment "signature.asc" removed by Bernard Metzler/Zurich/IBM]

