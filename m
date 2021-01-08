Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C0462EF0E4
	for <lists+linux-rdma@lfdr.de>; Fri,  8 Jan 2021 11:52:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726795AbhAHKwK (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 8 Jan 2021 05:52:10 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:15052 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726752AbhAHKwJ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 8 Jan 2021 05:52:09 -0500
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 108AZO6u048046
        for <linux-rdma@vger.kernel.org>; Fri, 8 Jan 2021 05:51:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=in-reply-to : from : to
 : cc : date : mime-version : references : content-transfer-encoding :
 content-type : message-id : subject; s=pp1;
 bh=AnTn86ct4P6jYE5sNemxq4rSOcR9qLhTA+nAmJoSdQc=;
 b=ARF/zzhWlnnf9+ZbVJpMAESZEiYGzTmRrzorRWVkW7r0i3A9GDB6QwggOqvRBHb94J/P
 ocztelQU5CFYrb6eCSI0NQ3ohYN0pUe7xmHcNiv0PEwYhiMIU3Jff1vIMW5Plli5vOjj
 Zb7fyC350thGlR1wGVQ/SNVRkrodizHwy5OQ3g9hbZ+eubVeRn/PPfeL6D99Ng6jKSqu
 yih4/LPHTrJ9KNAz6BDHUZhxtpnRjGsps4p3wgZW3JO0euHQCFnJkdxcaXuD/MZ/nhPk
 U60gdRsPUCMK5qvnwWzBGJhy67YUOuP1x/eLvI/JI5l1WbxVPsGNniux61cC6iJK7Lsk Yw== 
Received: from smtp.notes.na.collabserv.com (smtp.notes.na.collabserv.com [192.155.248.67])
        by mx0a-001b2d01.pphosted.com with ESMTP id 35xnpxggdu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-rdma@vger.kernel.org>; Fri, 08 Jan 2021 05:51:28 -0500
Received: from localhost
        by smtp.notes.na.collabserv.com with smtp.notes.na.collabserv.com ESMTP
        for <linux-rdma@vger.kernel.org> from <BMT@zurich.ibm.com>;
        Fri, 8 Jan 2021 10:51:27 -0000
Received: from us1a3-smtp05.a3.dal06.isc4sb.com (10.146.71.159)
        by smtp.notes.na.collabserv.com (10.106.227.16) with smtp.notes.na.collabserv.com ESMTP;
        Fri, 8 Jan 2021 10:51:24 -0000
Received: from us1a3-mail162.a3.dal06.isc4sb.com ([10.146.71.4])
          by us1a3-smtp05.a3.dal06.isc4sb.com
          with ESMTP id 2021010810512342-244263 ;
          Fri, 8 Jan 2021 10:51:23 +0000 
In-Reply-To: <20210107193838.GA921419@nvidia.com>
From:   "Bernard Metzler" <BMT@zurich.ibm.com>
To:     "Jason Gunthorpe" <jgg@nvidia.com>
Cc:     <linux-rdma@vger.kernel.org>, <linux-nvme@lists.infradead.org>,
        <leon@kernel.org>, "Kamal Heib" <kamalheib1@gmail.com>,
        "Yi Zhang" <yi.zhang@redhat.com>,
        "kernel test robot" <lkp@intel.com>
Date:   Fri, 8 Jan 2021 10:51:23 +0000
MIME-Version: 1.0
Sensitivity: 
Importance: Normal
X-Priority: 3 (Normal)
References: <20210107193838.GA921419@nvidia.com>,<20201216110000.611-1-bmt@zurich.ibm.com>
X-Mailer: IBM iNotes ($HaikuForm 1054.1) | IBM Domino Build
 SCN1812108_20180501T0841_FP65 April 15, 2020 at 09:48
X-LLNOutbound: False
X-Disclaimed: 55511
X-TNEFEvaluated: 1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
x-cbid: 21010810-7279-0000-0000-0000046701B5
X-IBM-SpamModules-Scores: BY=0; FL=0; FP=0; FZ=0; HX=0; KW=0; PH=0;
 SC=0.40962; ST=0; TS=0; UL=0; ISC=; MB=0.000072
X-IBM-SpamModules-Versions: BY=3.00014517; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000295; SDB=6.01489919; UDB=6.00803418; IPR=6.01272489;
 MB=3.00035770; MTD=3.00000008; XFM=3.00000015; UTC=2021-01-08 10:51:25
X-IBM-AV-DETECTION: SAVI=unsuspicious REMOTE=unsuspicious XFE=unused
X-IBM-AV-VERSION: SAVI=2021-01-07 20:44:03 - 6.00012203
x-cbparentid: 21010810-7280-0000-0000-00009B8201AB
Message-Id: <OF12D28384.4EE6A087-ON00258657.003BA30F-00258657.003BA319@notes.na.collabserv.com>
Subject: RE: [PATCH v3] RDMA/siw: Fix handling of zero-sized Read and Receive
 Queues.
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2021-01-08_06:2021-01-07,2021-01-08 signatures=0
X-Proofpoint-Spam-Reason: orgsafe
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

-----"Jason Gunthorpe" <jgg@nvidia.com> wrote: -----

>To: "Bernard Metzler" <bmt@zurich.ibm.com>
>From: "Jason Gunthorpe" <jgg@nvidia.com>
>Date: 01/07/2021 08:40PM
>Cc: <linux-rdma@vger.kernel.org>, <linux-nvme@lists.infradead.org>,
><leon@kernel.org>, "Kamal Heib" <kamalheib1@gmail.com>, "Yi Zhang"
><yi.zhang@redhat.com>, "kernel test robot" <lkp@intel.com>
>Subject: [EXTERNAL] Re: [PATCH v3] RDMA/siw: Fix handling of
>zero-sized Read and Receive Queues.
>
>On Wed, Dec 16, 2020 at 12:00:00PM +0100, Bernard Metzler wrote:
>> @@ -933,6 +937,7 @@ int siw=5Factivate=5Ftx(struct siw=5Fqp *qp)
>> =20
>>  		goto out;
>>  	}
>> +no=5Firq:
>>  	sqe =3D sq=5Fget=5Fnext(qp);
>>  	if (sqe) {
>
>Can you please arrange this without the spaghetti goto's? goto is ok
>for error unwind at the tail of the function, but should not be used
>willy nilly. Move some of this into functions, use normal if
>statements, etc.
>
Okay. I tried to minimize changes but I now think
you are right - it's time to cleanup before it
gets too burlesque.

Will send a v4.

Thanks
Bernard.

