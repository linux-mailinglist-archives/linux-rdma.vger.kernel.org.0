Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25E7F31EC20
	for <lists+linux-rdma@lfdr.de>; Thu, 18 Feb 2021 17:17:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232852AbhBRQQr (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 18 Feb 2021 11:16:47 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:56374 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233104AbhBRMjx (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 18 Feb 2021 07:39:53 -0500
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 11IC31vM147447
        for <linux-rdma@vger.kernel.org>; Thu, 18 Feb 2021 07:38:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=in-reply-to : subject :
 from : to : cc : date : mime-version : references :
 content-transfer-encoding : content-type : message-id; s=pp1;
 bh=l+uaZt5xszN3MOPHvyrvmrZX4i/kTfZ20q/0RqrlYBc=;
 b=o5OA+pF/dLB/0YupRsUcYsSthvSxejiCIYjNddUId5GWd9158Xoikvw4zizs4qlSk7gg
 smZQawcmPgCOEHajJA6mTw5y5wM1bXTXRFd60nLjI4u6uAdlW8FP7RebPZroTAmGyMyq
 DhlHZTM/adgPRohkQfSVKPncg90oLkBlXfzxjSoeh0w9bPJJ/ousWIhvHqlz0+wz9M7M
 r2OISAwFr+zEcXeApPuO9DR1vfkVwT3JRLEP6NlGy4PlyJ/rbzKxu1RZoaC6a9vQEQcl
 uXrWTJs5I4NtIbHyM/Z3Ri5lWr+xppTZz04A1+5II5u8Pnvu+tqCVqXvj2zmI/8oSSmO bQ== 
Received: from smtp.notes.na.collabserv.com (smtp.notes.na.collabserv.com [158.85.210.113])
        by mx0a-001b2d01.pphosted.com with ESMTP id 36sqpf1gbw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-rdma@vger.kernel.org>; Thu, 18 Feb 2021 07:38:26 -0500
Received: from localhost
        by smtp.notes.na.collabserv.com with smtp.notes.na.collabserv.com ESMTP
        for <linux-rdma@vger.kernel.org> from <BMT@zurich.ibm.com>;
        Thu, 18 Feb 2021 12:38:26 -0000
Received: from us1b3-smtp05.a3dr.sjc01.isc4sb.com (10.122.203.183)
        by smtp.notes.na.collabserv.com (10.122.47.56) with smtp.notes.na.collabserv.com ESMTP;
        Thu, 18 Feb 2021 12:38:24 -0000
Received: from us1b3-mail162.a3dr.sjc03.isc4sb.com ([10.160.174.187])
          by us1b3-smtp05.a3dr.sjc01.isc4sb.com
          with ESMTP id 2021021812382425-318739 ;
          Thu, 18 Feb 2021 12:38:24 +0000 
In-Reply-To: <bd5deec5-8fc6-ccd6-927a-898f6d9ab35b@amazon.com>
Subject: Re: ibv_req_notify_cq clarification
From:   "Bernard Metzler" <BMT@zurich.ibm.com>
To:     "Gal Pressman" <galpress@amazon.com>
Cc:     "RDMA mailing list" <linux-rdma@vger.kernel.org>
Date:   Thu, 18 Feb 2021 12:38:23 +0000
MIME-Version: 1.0
Sensitivity: 
Importance: Normal
X-Priority: 3 (Normal)
References: <bd5deec5-8fc6-ccd6-927a-898f6d9ab35b@amazon.com>
X-Mailer: IBM iNotes ($HaikuForm 1054.1) | IBM Domino Build
 SCN1812108_20180501T0841_FP130 January 13, 2021 at 14:04
X-KeepSent: 8421F948:8385A3FA-00258680:00454F8A;
 type=4; name=$KeepSent
X-LLNOutbound: False
X-Disclaimed: 10111
X-TNEFEvaluated: 1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
x-cbid: 21021812-7691-0000-0000-00000E6F0A54
X-IBM-SpamModules-Scores: BY=0; FL=0; FP=0; FZ=0; HX=0; KW=0; PH=0;
 SC=0.399202; ST=0; TS=0; UL=0; ISC=; MB=0.033418
X-IBM-SpamModules-Versions: BY=3.00014755; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000295; SDB=6.01509572; UDB=6.00815158; IPR=6.01292095;
 MB=3.00036174; MTD=3.00000008; XFM=3.00000015; UTC=2021-02-18 12:38:25
X-IBM-AV-DETECTION: SAVI=unsuspicious REMOTE=unsuspicious XFE=unused
X-IBM-AV-VERSION: SAVI=2021-02-18 03:19:26 - 6.00012309
x-cbparentid: 21021812-7692-0000-0000-00002F620BF8
Message-Id: <OF8421F948.8385A3FA-ON00258680.00454F8A-00258680.00456EC9@notes.na.collabserv.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-02-18_05:2021-02-18,2021-02-18 signatures=0
X-Proofpoint-Spam-Reason: orgsafe
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

-----"Gal Pressman" <galpress@amazon.com> wrote: -----

>To: "RDMA mailing list" <linux-rdma@vger.kernel.org>
>From: "Gal Pressman" <galpress@amazon.com>
>Date: 02/18/2021 11:26AM
>Subject: [EXTERNAL] ibv=5Freq=5Fnotify=5Fcq clarification
>
>I'm a bit confused about the meaning of the ibv=5Freq=5Fnotify=5Fcq() verb:
>"Upon the addition of a new CQ entry (CQE) to cq, a completion event
>will be
>added to the completion channel associated with the CQ."
>
>What is considered a new CQE in this case?
>The next CQE from the user's perspective, i.e. any new CQE that
>wasn't consumed
>by the user's poll cq?
>Or any new CQE from the device's perspective?
>
>For example, if at the time of ibv=5Freq=5Fnotify=5Fcq() call the CQ has
>received 100
>completions, but the user hasn't polled his CQ yet, when should he be
>notified?
>On the 101 completion or immediately (since there are completions
>waiting on the
>CQ)?

It is from drivers perspective. So notification when 101
became available and CQ is marked for notification.
Applications tend to poll the CQ after requesting
notification, since there might be a race
from appl perspective...



