Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDAE631FB03
	for <lists+linux-rdma@lfdr.de>; Fri, 19 Feb 2021 15:37:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231250AbhBSOgd (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 19 Feb 2021 09:36:33 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:32554 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231186AbhBSOfG (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 19 Feb 2021 09:35:06 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 11JEW14s067784
        for <linux-rdma@vger.kernel.org>; Fri, 19 Feb 2021 09:34:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=in-reply-to : subject :
 from : to : cc : date : mime-version : references :
 content-transfer-encoding : content-type : message-id; s=pp1;
 bh=mvmmHTqoQrELtK67aiJ/sLPy/6SLDOzl0nf4NbfK9TA=;
 b=RZ8bSRn1UKI6CZMxm4rkCI5ty8uuMWuIF4WeySHP7NWWmrCCAkyJcFogzhDK46YLWJGA
 0KVeCaD+8Cvzo8GvpWammfIKER3mH5JaNvLhMeRiIjrhw5AqhTCiGSpCC1KmPnwxz67U
 Lu5HbHFxhkXFYbi9UyZ7m50kz6f42QdtQDUftsenBUbBnPWgPMdZF23wqodPIGFLO1UP
 xqXR8+QFtLXThSkXZcnEh3/4d2gA1KXaC3xdWxMa5aWjHjvcgG/H9TebN7lqv3m4ID9b
 tRtPB4kXcdwrUObLAHNyu4JG3PFRO2gvm7imN3qNQCg7xEoQUdvCnsV+KrgyeMfydrhk Yw== 
Received: from smtp.notes.na.collabserv.com (smtp.notes.na.collabserv.com [192.155.248.93])
        by mx0a-001b2d01.pphosted.com with ESMTP id 36tenqhcrb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-rdma@vger.kernel.org>; Fri, 19 Feb 2021 09:34:25 -0500
Received: from localhost
        by smtp.notes.na.collabserv.com with smtp.notes.na.collabserv.com ESMTP
        for <linux-rdma@vger.kernel.org> from <BMT@zurich.ibm.com>;
        Fri, 19 Feb 2021 14:34:25 -0000
Received: from us1a3-smtp05.a3.dal06.isc4sb.com (10.146.71.159)
        by smtp.notes.na.collabserv.com (10.106.227.39) with smtp.notes.na.collabserv.com ESMTP;
        Fri, 19 Feb 2021 14:34:23 -0000
Received: from us1a3-mail162.a3.dal06.isc4sb.com ([10.146.71.4])
          by us1a3-smtp05.a3.dal06.isc4sb.com
          with ESMTP id 2021021914342320-412503 ;
          Fri, 19 Feb 2021 14:34:23 +0000 
In-Reply-To: <bf7a73c3-ba50-a836-8e01-87c4183f003e@talpey.com>
Subject: Re: Re: directing soft iWARP traffic through a secure tunnel
From:   "Bernard Metzler" <BMT@zurich.ibm.com>
To:     "Tom Talpey" <tom@talpey.com>
Cc:     "Jason Gunthorpe" <jgg@ziepe.ca>,
        "Chuck Lever" <chuck.lever@oracle.com>,
        "linux-rdma" <linux-rdma@vger.kernel.org>,
        "Benjamin Coddington" <bcodding@redhat.com>
Date:   Fri, 19 Feb 2021 14:34:22 +0000
MIME-Version: 1.0
Sensitivity: 
Importance: Normal
X-Priority: 3 (Normal)
References: <bf7a73c3-ba50-a836-8e01-87c4183f003e@talpey.com>,<20210216180946.GV4718@ziepe.ca>
 <61EFD7EA-FA16-4AA1-B92F-0B0D4CC697AB@oracle.com>
 <OFA2194C43.CE483827-ON0025867E.004018CA-0025867E.004470FA@notes.na.collabserv.com>
 <OF3B04E71D.E72E1A4D-ON00258681.004164EA-00258681.00480051@notes.na.collabserv.com>
 <20210219135728.GD2643399@ziepe.ca>
X-Mailer: IBM iNotes ($HaikuForm 1054.1) | IBM Domino Build
 SCN1812108_20180501T0841_FP130 January 13, 2021 at 14:04
X-LLNOutbound: False
X-Disclaimed: 8507
X-TNEFEvaluated: 1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
x-cbid: 21021914-8889-0000-0000-0000049C3383
X-IBM-SpamModules-Scores: BY=0.059465; FL=0; FP=0; FZ=0; HX=0; KW=0; PH=0;
 SC=0.40962; ST=0; TS=0; UL=0; ISC=; MB=0.271308
X-IBM-SpamModules-Versions: BY=3.00014759; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000295; SDB=6.01510090; UDB=6.00815469; IPR=6.01292614;
 MB=3.00036183; MTD=3.00000008; XFM=3.00000015; UTC=2021-02-19 14:34:24
X-IBM-AV-DETECTION: SAVI=unsuspicious REMOTE=unsuspicious XFE=unused
X-IBM-AV-VERSION: SAVI=2021-02-19 11:06:01 - 6.00012314
x-cbparentid: 21021914-8890-0000-0000-0000AEFD3F75
Message-Id: <OF54DF919C.5715D846-ON00258681.004F4160-00258681.00500D35@notes.na.collabserv.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-02-19_05:2021-02-18,2021-02-19 signatures=0
X-Proofpoint-Spam-Reason: orgsafe
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

-----"Tom Talpey" <tom@talpey.com> wrote: -----

>To: "Jason Gunthorpe" <jgg@ziepe.ca>, "Bernard Metzler"
><BMT@zurich.ibm.com>
>From: "Tom Talpey" <tom@talpey.com>
>Date: 02/19/2021 03:15PM
>Cc: "Chuck Lever" <chuck.lever@oracle.com>, "linux-rdma"
><linux-rdma@vger.kernel.org>, "Benjamin Coddington"
><bcodding@redhat.com>
>Subject: [EXTERNAL] Re: directing soft iWARP traffic through a secure
>tunnel
>
>On 2/19/2021 8:57 AM, Jason Gunthorpe wrote:
>> On Fri, Feb 19, 2021 at 01:06:26PM +0000, Bernard Metzler wrote:
>>=20
>>> Actually, all this GID and GUID and friends for iWARP
>>> CM looks more like squeezing things into InfiniBand terms,
>>> where we could just rely on plain ARP and IP
>>> (ARP resolve interface, see if there is an RDMA device
>>> bound to, done)... or do I miss something?
>>=20
>> I don't know how iWarp cM works very well, it would not be
>surprising
>> if the gid table code has gained general rocee behaviors that are
>not
>> applicable to iwarp modes.
>
>iWarp doesn't really need a CM, it is capable of peer-to-peer without
>any need to assign connection and queuepair ID's. The CM
>infrastructure
>basically just implements a state machine to allow upper layers to
>have
>a consistent connection API.

Well hardware iWarp need someone to organize taking away ports
from kernel TCP which are bound to RNIC's.

>
>I'm with Bernard here, forcing iWarp to use CM is a fairly unnatural
>act. Assigning a GID/GUID is unnecessary from a protocol perspective.
>
>
>> With Steve gone I don't think there is really anyone left that even
>> really knows how the iWarp stuff works??
>>=20

Cleaning up the iWarp path of it might be a complex undertaking.
I don't think going down that path solves the issue soon enough
for NFS/RDMA folks. But I will spend some time trying to wrap
my head around it...

Best,
Bernard.

