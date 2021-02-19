Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B21E531F9A8
	for <lists+linux-rdma@lfdr.de>; Fri, 19 Feb 2021 14:07:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230091AbhBSNHM (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 19 Feb 2021 08:07:12 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:29654 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230014AbhBSNHL (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 19 Feb 2021 08:07:11 -0500
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 11JD3AD7135166
        for <linux-rdma@vger.kernel.org>; Fri, 19 Feb 2021 08:06:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=in-reply-to : subject :
 from : to : cc : date : mime-version : references :
 content-transfer-encoding : content-type : message-id; s=pp1;
 bh=HuymBwLHmgjD8nM5e+2JKrKAHVqU/Bf6q03RQkesjFg=;
 b=CsXGcOAX84ph+Vn0OuNgyEno20k9MP3s+11YvngUuWM4xWZft15egG1ag3IhlBwrOs7v
 4tNbD7eY+jo9aJosbuLlwS5wbSal9jg9vIZjAUbkerzJYXJO7x6UCCJ/VTQClYeqv1KZ
 54pHLNZQE43DdXlYMgklX0GAIlfffI92NOgWIg/Mx/SZTzsSHlco0LpnSTljtlt+8H/8
 /EVrwsoQpozQu0BO9cXErlDCfXaIfQmB9Sf6YmImQDW861SFGBM27C6zTpG8J/kjTEfp
 xhf3j0RQQpbuJM/gYzMvuo2/1yPFe2SVomwDrVS+30z7Fy1EhUSuQwMRP1qfvoKXUUcH 4w== 
Received: from smtp.notes.na.collabserv.com (smtp.notes.na.collabserv.com [192.155.248.73])
        by mx0a-001b2d01.pphosted.com with ESMTP id 36tbe54uhq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-rdma@vger.kernel.org>; Fri, 19 Feb 2021 08:06:30 -0500
Received: from localhost
        by smtp.notes.na.collabserv.com with smtp.notes.na.collabserv.com ESMTP
        for <linux-rdma@vger.kernel.org> from <BMT@zurich.ibm.com>;
        Fri, 19 Feb 2021 13:06:28 -0000
Received: from us1a3-smtp05.a3.dal06.isc4sb.com (10.146.71.159)
        by smtp.notes.na.collabserv.com (10.106.227.90) with smtp.notes.na.collabserv.com ESMTP;
        Fri, 19 Feb 2021 13:06:26 -0000
Received: from us1a3-mail162.a3.dal06.isc4sb.com ([10.146.71.4])
          by us1a3-smtp05.a3.dal06.isc4sb.com
          with ESMTP id 2021021913062672-343973 ;
          Fri, 19 Feb 2021 13:06:26 +0000 
In-Reply-To: <20210216180946.GV4718@ziepe.ca>
Subject: Re: Re: directing soft iWARP traffic through a secure tunnel
From:   "Bernard Metzler" <BMT@zurich.ibm.com>
To:     "Jason Gunthorpe" <jgg@ziepe.ca>
Cc:     "Chuck Lever" <chuck.lever@oracle.com>,
        "linux-rdma" <linux-rdma@vger.kernel.org>,
        "Benjamin Coddington" <bcodding@redhat.com>
Date:   Fri, 19 Feb 2021 13:06:26 +0000
MIME-Version: 1.0
Sensitivity: 
Importance: Normal
X-Priority: 3 (Normal)
References: <20210216180946.GV4718@ziepe.ca>,<61EFD7EA-FA16-4AA1-B92F-0B0D4CC697AB@oracle.com>
 <OFA2194C43.CE483827-ON0025867E.004018CA-0025867E.004470FA@notes.na.collabserv.com>
X-Mailer: IBM iNotes ($HaikuForm 1054.1) | IBM Domino Build
 SCN1812108_20180501T0841_FP130 January 13, 2021 at 14:04
X-LLNOutbound: False
X-Disclaimed: 16163
X-TNEFEvaluated: 1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
x-cbid: 21021913-8877-0000-0000-000005822720
X-IBM-SpamModules-Scores: BY=0.058808; FL=0; FP=0; FZ=0; HX=0; KW=0; PH=0;
 SC=0.40962; ST=0; TS=0; UL=0; ISC=; MB=0.000008
X-IBM-SpamModules-Versions: BY=3.00014759; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000295; SDB=6.01510061; UDB=6.00815452; IPR=6.01292585;
 MB=3.00036182; MTD=3.00000008; XFM=3.00000015; UTC=2021-02-19 13:06:27
X-IBM-AV-DETECTION: SAVI=unsuspicious REMOTE=unsuspicious XFE=unused
X-IBM-AV-VERSION: SAVI=2021-02-19 11:21:51 - 6.00012314
x-cbparentid: 21021913-8878-0000-0000-0000F5462B0B
Message-Id: <OF3B04E71D.E72E1A4D-ON00258681.004164EA-00258681.00480051@notes.na.collabserv.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-02-19_05:2021-02-18,2021-02-19 signatures=0
X-Proofpoint-Spam-Reason: orgsafe
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

-----"Jason Gunthorpe" <jgg@ziepe.ca> wrote: -----

>To: "Bernard Metzler" <BMT@zurich.ibm.com>
>From: "Jason Gunthorpe" <jgg@ziepe.ca>
>Date: 02/16/2021 07:12PM
>Cc: "Chuck Lever" <chuck.lever@oracle.com>, "linux-rdma"
><linux-rdma@vger.kernel.org>, "Benjamin Coddington"
><bcodding@redhat.com>
>Subject: [EXTERNAL] Re: directing soft iWARP traffic through a secure
>tunnel
>
>On Tue, Feb 16, 2021 at 12:27:33PM +0000, Bernard Metzler wrote:
>
>> rdma=5Fport=5Fget=5Flink=5Flayer(). Asking the RDMA core experts -
>> would a gid of zero have any side effects or bad implications,
>> since that ID is by no means unique?
>
>Yeah, it is clearly not ok. Generate a random private GUID?
>
Right. But that's unfortunately not sufficient to get
devices w/o hardware addresses handled by the CM code.
The net=5Fdevice remains w/o HW address, and that is where
CM gets the source HW address from (rdma=5Fcopy=5Fsrc=5Fl2=5Faddr()
etc.). I don't have a good idea yet how to get it working.

Actually, all this GID and GUID and friends for iWARP
CM looks more like squeezing things into InfiniBand terms,
where we could just rely on plain ARP and IP=20
(ARP resolve interface, see if there is an RDMA device
bound to, done)... or do I miss something?


On another related topic - the RDMA CM should let
the provider know if an IPv6 address is to be bound
AFONLY. This becomes needed in the current NFS/RDMA
over iWarp case, where NFS listeners bind to both IPv4
and IPv6 address with same port number. The code
correctly calls rdma=5Fset=5Fafonly() on the cmid, but
there is no mechanic to pass that information down
to the provider. So the second bind fails.
I'll send a small patch which enables that for
iwcm and siw, hoping for acceptance.

Many thanks,
Bernard.


