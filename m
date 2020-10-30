Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FC882A05C7
	for <lists+linux-rdma@lfdr.de>; Fri, 30 Oct 2020 13:50:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726226AbgJ3MuF (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 30 Oct 2020 08:50:05 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:42644 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726096AbgJ3MuE (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 30 Oct 2020 08:50:04 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 09UCWGnu041560
        for <linux-rdma@vger.kernel.org>; Fri, 30 Oct 2020 08:50:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=in-reply-to : subject :
 from : to : cc : date : mime-version : references :
 content-transfer-encoding : content-type : message-id; s=pp1;
 bh=4M6MKq50mvrySbRd9qhzZIjkM0W741sOCQxJEdtBlR4=;
 b=UlMB3dgOpQxlTN6K2Hbwivao3XFKoxBjIL17f01NE711Y7n5uta/uJUgwLGI8g/SiZpD
 fHUxsetFs4v2OKpBOoqc99Cn5wfsjXhMr2Y7w1xlK3/4ewwAHI7oDyu+7L9Oatgd7o20
 4W/qjcl8c3nfjszrkdEvkNbLMooNmIK6Jg4UnazSnBbsX1B4GPZ0Vt9s5iHQIf7PYhgF
 AS33z/xYeva7VOyLbmGHQyT7JLkM1h1ScbJC9ScFo1n2H3e9+ARgEpBRLd0BixjG+iy1
 uZIl07WpJJ978OeJe0Tl0G+HR5gB5MIqZv9UyJNJP6dE8B7lElH759FTo/bMLJVy6tPg oQ== 
Received: from smtp.notes.na.collabserv.com (smtp.notes.na.collabserv.com [158.85.210.114])
        by mx0b-001b2d01.pphosted.com with ESMTP id 34gfp4e6us-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-rdma@vger.kernel.org>; Fri, 30 Oct 2020 08:50:03 -0400
Received: from localhost
        by smtp.notes.na.collabserv.com with smtp.notes.na.collabserv.com ESMTP
        for <linux-rdma@vger.kernel.org> from <BMT@zurich.ibm.com>;
        Fri, 30 Oct 2020 12:50:02 -0000
Received: from us1b3-smtp02.a3dr.sjc01.isc4sb.com (10.122.7.175)
        by smtp.notes.na.collabserv.com (10.122.47.58) with smtp.notes.na.collabserv.com ESMTP;
        Fri, 30 Oct 2020 12:50:01 -0000
Received: from us1b3-mail162.a3dr.sjc03.isc4sb.com ([10.160.174.187])
          by us1b3-smtp02.a3dr.sjc01.isc4sb.com
          with ESMTP id 2020103012500112-362801 ;
          Fri, 30 Oct 2020 12:50:01 +0000 
In-Reply-To: <20201030114732.GC2620339@nvidia.com>
Subject: Re: Re: another change breaks rxe
From:   "Bernard Metzler" <BMT@zurich.ibm.com>
To:     "Jason Gunthorpe" <jgg@nvidia.com>
Cc:     "Bob Pearson" <rpearsonhpe@gmail.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Date:   Fri, 30 Oct 2020 12:50:01 +0000
MIME-Version: 1.0
Sensitivity: 
Importance: Normal
X-Priority: 3 (Normal)
References: <20201030114732.GC2620339@nvidia.com>,<32fa9c9f-5816-7474-b821-ccccd4cb5af0@gmail.com>
X-Mailer: IBM iNotes ($HaikuForm 1054.1) | IBM Domino Build
 SCN1812108_20180501T0841_FP65 April 15, 2020 at 09:48
X-KeepSent: AB5249F6:49569DF7-00258611:0045601D;
 type=4; name=$KeepSent
X-LLNOutbound: False
X-Disclaimed: 5871
X-TNEFEvaluated: 1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
x-cbid: 20103012-1639-0000-0000-000002F312BF
X-IBM-SpamModules-Scores: BY=0; FL=0; FP=0; FZ=0; HX=0; KW=0; PH=0;
 SC=0.411265; ST=0; TS=0; UL=0; ISC=; MB=0.000007
X-IBM-SpamModules-Versions: BY=3.00014105; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000295; SDB=6.01456644; UDB=6.00783623; IPR=6.01239324;
 MB=3.00034776; MTD=3.00000008; XFM=3.00000015; UTC=2020-10-30 12:50:01
X-IBM-AV-DETECTION: SAVI=unsuspicious REMOTE=unsuspicious XFE=unused
X-IBM-AV-VERSION: SAVI=2020-10-30 11:33:38 - 6.00012014
x-cbparentid: 20103012-1640-0000-0000-0000C7B213E4
Message-Id: <OFAB5249F6.49569DF7-ON00258611.0045601D-00258611.00467F48@notes.na.collabserv.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-10-30_04:2020-10-30,2020-10-30 signatures=0
X-Proofpoint-Spam-Reason: orgsafe
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

-----"Jason Gunthorpe" <jgg@nvidia.com> wrote: -----

>To: "Bob Pearson" <rpearsonhpe@gmail.com>
>From: "Jason Gunthorpe" <jgg@nvidia.com>
>Date: 10/30/2020 12:47PM
>Cc: "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
>Subject: [EXTERNAL] Re: another change breaks rxe
>
>On Fri, Oct 30, 2020 at 12:41:12AM -0500, Bob Pearson wrote:
>
>> breaks rxe because it does use IB=5FUSER=5FVERBS=5FCMD=5FPOST=5FSEND. rxe
>> posts wqes to a work queue in shared memory and then calls
>> ibv=5Fpost=5Fsend with zero wqes as a doorbell to the kernel which uses
>> this as a hint to go read the shared memory.
>
>Gah, siw and rxe are open coding this stuff (wrongly!) in rdma-core
>
>This would be a lot better to use an eventfd
>
>Jason
>
Yes, siw does it the same.

I see the hfi and ipath drivers similarly using ibv=5Fcmd=5Fpost=5Fsend
to push the wqe's (while not having them in shared mem). Do they
brake as well?
Do we have an example of decent eventfd usage where I could learn
from how to use it? Though I think having another fd open per context
might become a scaling issue.

Thanks and best regards,
Bernard.

