Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BD46319E9D
	for <lists+linux-rdma@lfdr.de>; Fri, 12 Feb 2021 13:42:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231591AbhBLMjE (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 12 Feb 2021 07:39:04 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:26678 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231391AbhBLMh6 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 12 Feb 2021 07:37:58 -0500
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 11CCVqUG073017
        for <linux-rdma@vger.kernel.org>; Fri, 12 Feb 2021 07:37:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=in-reply-to : from : to
 : cc : date : mime-version : references : content-transfer-encoding :
 content-type : message-id : subject; s=pp1;
 bh=Q5c4f+PwF7Kw17ximCNFiTlgFkofeRztMSaSiBm7YqY=;
 b=tU6gVdCz5HPz8hcrloXMtl7gy1tGmtFTLLeWQTuJ9+XM9gVwSuAylNUPlutW4YthvJU2
 M8KUelHc4wfcoNEhPnWbC1B+XWlJufNGroCb/IbW/UOaTph95R6uBWtCTDs2/rGc/UFJ
 96CO+KcnZIYnUHVnu2CZQMkkFC9SLcEhRtwFtAJzolNifs0Ybsp665+6c9r1lbvvfgIy
 FJxoJx+7IneACikIbbY1dy7AAJv5EqTZpcWD0jDkIk1Bi7zEeCTKqhjjmXjCDa7OCabm
 EWl1aBWbDVXTU2o/VsUg7/Y5sDuTEgBNg/l7NyEIsltZ7Zoe1K2fn55AgEkNbAc8rAtS Ww== 
Received: from smtp.notes.na.collabserv.com (smtp.notes.na.collabserv.com [192.155.248.93])
        by mx0a-001b2d01.pphosted.com with ESMTP id 36nsfngtp9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-rdma@vger.kernel.org>; Fri, 12 Feb 2021 07:37:16 -0500
Received: from localhost
        by smtp.notes.na.collabserv.com with smtp.notes.na.collabserv.com ESMTP
        for <linux-rdma@vger.kernel.org> from <BMT@zurich.ibm.com>;
        Fri, 12 Feb 2021 12:37:09 -0000
Received: from us1a3-smtp08.a3.dal06.isc4sb.com (10.146.103.57)
        by smtp.notes.na.collabserv.com (10.106.227.39) with smtp.notes.na.collabserv.com ESMTP;
        Fri, 12 Feb 2021 12:37:08 -0000
Received: from us1a3-mail162.a3.dal06.isc4sb.com ([10.146.71.4])
          by us1a3-smtp08.a3.dal06.isc4sb.com
          with ESMTP id 2021021212370788-249269 ;
          Fri, 12 Feb 2021 12:37:07 +0000 
In-Reply-To: <61EFD7EA-FA16-4AA1-B92F-0B0D4CC697AB@oracle.com>
From:   "Bernard Metzler" <BMT@zurich.ibm.com>
To:     "Chuck Lever" <chuck.lever@oracle.com>
Cc:     "linux-rdma" <linux-rdma@vger.kernel.org>,
        "Benjamin Coddington" <bcodding@redhat.com>
Date:   Fri, 12 Feb 2021 12:37:07 +0000
MIME-Version: 1.0
Sensitivity: 
Importance: Normal
X-Priority: 3 (Normal)
References: <61EFD7EA-FA16-4AA1-B92F-0B0D4CC697AB@oracle.com>
X-Mailer: IBM iNotes ($HaikuForm 1054.1) | IBM Domino Build
 SCN1812108_20180501T0841_FP130 January 13, 2021 at 14:04
X-LLNOutbound: False
X-Disclaimed: 41667
X-TNEFEvaluated: 1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
x-cbid: 21021212-8889-0000-0000-000004911145
X-IBM-SpamModules-Scores: BY=0.058223; FL=0; FP=0; FZ=0; HX=0; KW=0; PH=0;
 SC=0.40962; ST=0; TS=0; UL=0; ISC=; MB=0.155913
X-IBM-SpamModules-Versions: BY=3.00014727; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000295; SDB=6.01506700; UDB=6.00813446; IPR=6.01289243;
 MB=3.00036113; MTD=3.00000008; XFM=3.00000015; UTC=2021-02-12 12:37:08
X-IBM-AV-DETECTION: SAVI=unsuspicious REMOTE=unsuspicious XFE=unused
X-IBM-AV-VERSION: SAVI=2021-02-12 07:06:22 - 6.00012296
x-cbparentid: 21021212-8890-0000-0000-0000AEE74B20
Message-Id: <OFE25AAD0A.3B8CE2E0-ON0025867A.0043F201-0025867A.00455111@notes.na.collabserv.com>
Subject: Re:  directing soft iWARP traffic through a secure tunnel
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.737
 definitions=2021-02-12_04:2021-02-12,2021-02-12 signatures=0
X-Proofpoint-Spam-Reason: orgsafe
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

-----"Chuck Lever" <chuck.lever@oracle.com> wrote: -----

>To: "linux-rdma" <linux-rdma@vger.kernel.org>
>From: "Chuck Lever" <chuck.lever@oracle.com>
>Date: 02/11/2021 08:38PM
>Cc: "Benjamin Coddington" <bcodding@redhat.com>
>Subject: [EXTERNAL] directing soft iWARP traffic through a secure
>tunnel
>
>Hi-
>
>This might sound crazy, but bear with me.
>
>The NFS community is starting to hold virtual interoperability
>testing
>events to replace our in-person events that are not feasible due to
>pandemic-related travel restrictions. I'm told other communities have
>started doing the same.
>
>The virtual event is being held on a private network that is set up
>using OpenVPN across a large geographical area. I attach my test
>systems to the VPN to access test systems run by others at other
>companies.
>
>We'd like to continue to include NFS/RDMA testing at these events.
>This means either RoCEv2 or iWARP, since obviously we can't create
>an ad hoc wide-area InfiniBand infrastructure.
>
>Because the VPN is operating over long distances, we've decided to
>start with iWARP. However, we are stumbling when it comes to
>directing
>the siw driver's traffic onto the tun0 device:
>
>[root@oracle-100 ~]# rdma link add siw0 type siw netdev tun0
>error: Invalid argument
>[root@oracle-100 ~]#
>
>Has anyone else tried to do this, and what was the approach? Or does
>siw not yet have this capability?
>

Hi Chuck

right. Attaching siw is currently restricted to some physical
device types. This now appears a useless limitation, since
it prevents its usage in the given setup, where it would
be just useful...
Relaxing that limitation is a rather simple code change in siw
- but that would not help you asap?

In any case I'd be happy to help with a fix, but participants
would have to rebuild the siw module...probably no option?

Best,
Bernard.

