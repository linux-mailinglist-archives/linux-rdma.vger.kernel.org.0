Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B8F933EBE0
	for <lists+linux-rdma@lfdr.de>; Wed, 17 Mar 2021 09:55:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229490AbhCQIyf (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 17 Mar 2021 04:54:35 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:10794 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229505AbhCQIy1 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 17 Mar 2021 04:54:27 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 12H8Wavs082573
        for <linux-rdma@vger.kernel.org>; Wed, 17 Mar 2021 04:54:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=in-reply-to : from : to
 : cc : date : mime-version : references : content-transfer-encoding :
 content-type : message-id : subject; s=pp1;
 bh=ooaJBsWjjz8RZE3VRVf4DS/n2dOUkIfkw+3d0lzQEMc=;
 b=WaK0G5926lVdrlartdqozSy6d2pvoPhnXpXs8PPy9dFyoDMxsDvWkO8NRh7cKgP7PoDu
 WyA4iPzb8qujbCap99ISHgZta/W81WVjfILXMbrthP7qVfaEWUJECaTLXRdFCastwToM
 Es9psjBOXmoPJvPZTsWWzEgLum7/4me2WuGR/vYORzfBLUA38E569UbvMzbgmMp8OdJ1
 Cn9Hp0UV0kryZJE15ryv2BucjH+P5zdCj4EvX0iX0CcERnBO5aWHy25YgIT+K/mirE8x
 HMKKJ5lR3gvmCtzjDRpt6oQf4ALNBrjH1LynSizVAkncJhZcprXTEqRXDdmqYPYOiuBu kQ== 
Received: from smtp.notes.na.collabserv.com (smtp.notes.na.collabserv.com [158.85.210.109])
        by mx0a-001b2d01.pphosted.com with ESMTP id 37baj1wwcc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-rdma@vger.kernel.org>; Wed, 17 Mar 2021 04:54:26 -0400
Received: from localhost
        by smtp.notes.na.collabserv.com with smtp.notes.na.collabserv.com ESMTP
        for <linux-rdma@vger.kernel.org> from <BMT@zurich.ibm.com>;
        Wed, 17 Mar 2021 08:54:25 -0000
Received: from us1b3-smtp02.a3dr.sjc01.isc4sb.com (10.122.7.175)
        by smtp.notes.na.collabserv.com (10.122.47.48) with smtp.notes.na.collabserv.com ESMTP;
        Wed, 17 Mar 2021 08:54:24 -0000
Received: from us1b3-mail162.a3dr.sjc03.isc4sb.com ([10.160.174.187])
          by us1b3-smtp02.a3dr.sjc01.isc4sb.com
          with ESMTP id 2021031708542340-189647 ;
          Wed, 17 Mar 2021 08:54:23 +0000 
In-Reply-To: <73EEB368-3E02-4BDD-BE16-4AA9A87A3919@oracle.com>
From:   "Bernard Metzler" <BMT@zurich.ibm.com>
To:     "Chuck Lever III" <chuck.lever@oracle.com>
Cc:     "linux-rdma" <linux-rdma@vger.kernel.org>
Date:   Wed, 17 Mar 2021 08:54:23 +0000
MIME-Version: 1.0
Sensitivity: 
Importance: Normal
X-Priority: 3 (Normal)
References: <73EEB368-3E02-4BDD-BE16-4AA9A87A3919@oracle.com>
X-Mailer: IBM iNotes ($HaikuForm 1054.1) | IBM Domino Build
 SCN1812108_20180501T0841_FP130 January 13, 2021 at 14:04
X-KeepSent: EAF169BA:A8545B4F-0025869B:002EFC4D;
 type=4; name=$KeepSent
X-LLNOutbound: False
X-Disclaimed: 55455
X-TNEFEvaluated: 1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
x-cbid: 21031708-1429-0000-0000-00000383A167
X-IBM-SpamModules-Scores: BY=0; FL=0; FP=0; FZ=0; HX=0; KW=0; PH=0; SC=0;
 ST=0; TS=0; UL=0; ISC=; MB=0.000001
X-IBM-SpamModules-Versions: BY=3.00014881; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000296; SDB=6.01521490; UDB=6.00822281; IPR=6.01304004;
 MB=3.00036388; MTD=3.00000008; XFM=3.00000015; UTC=2021-03-17 08:54:24
X-IBM-AV-DETECTION: SAVI=unsuspicious REMOTE=unsuspicious XFE=unused
X-IBM-AV-VERSION: SAVI=2021-03-12 19:13:53 - 6.00012368
x-cbparentid: 21031708-1430-0000-0000-000039E6A509
Message-Id: <OFEAF169BA.A8545B4F-ON0025869B.002EFC4D-0025869B.0030ECF0@notes.na.collabserv.com>
Subject: Re:  FastLinQ: possible duplicate flush of FastReg and LocalInv
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-17_02:2021-03-17,2021-03-17 signatures=0
X-Proofpoint-Spam-Reason: orgsafe
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

-----"Chuck Lever III" <chuck.lever@oracle.com> wrote: -----

>To: "linux-rdma" <linux-rdma@vger.kernel.org>
>From: "Chuck Lever III" <chuck.lever@oracle.com>
>Date: 03/16/2021 08:59PM
>Subject: [EXTERNAL] FastLinQ: possible duplicate flush of FastReg and
>LocalInv
>
>Hi-
>
>I've been trying to track down some crashes when running NFS/RDMA
>tests over FastLinQ devices in iWARP mode. To make it stressful,
>I've enabled disconnect injection, where rpcrdma injects a
>connection disconnect every so often.
>
>As part of a disconnect event, the Receive and Send queues are
>drained. Sometimes I see a duplicate flush for one or more of
>memory registration ops. This is not a big deal for FastReq
>because its completion handler is basically a no-op.
>
>But for LocalInv this is a problem. On a flushed completion, the
>MR is destroyed. If the completion occurs again, of course, all
>kinds of badness happens because we're DMA-unmapping twice,
>touching memory that has already been freed, and deleting from a
>list=5Fhead that is poisonous.
>
>The last straw is that wc=5Flocalinv=5Fdone calls the generic RPC layer
>to indicate that an RPC Reply is ready. The duplicate flush
>dereferences one or more NULL pointers.
>
>Doesn't the verbs API contract stipulate that every posted WR gets
>exactly one completion? I don't see this behavior with other
>providers.
>
Indeed. Nothing else is defined and applications obviously
rely on correctness in that respect.

