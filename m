Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC7D731EC26
	for <lists+linux-rdma@lfdr.de>; Thu, 18 Feb 2021 17:20:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233376AbhBRQR7 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 18 Feb 2021 11:17:59 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:10608 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S231640AbhBROAT (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 18 Feb 2021 09:00:19 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 11IDUkkl075272
        for <linux-rdma@vger.kernel.org>; Thu, 18 Feb 2021 08:59:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=in-reply-to : subject :
 from : to : cc : date : mime-version : references :
 content-transfer-encoding : content-type : message-id; s=pp1;
 bh=Q7rYE/Q0ODn15Gxpt0hhNvXM+ok4+wTc4/qMx5vOeTA=;
 b=UjbF/hQLTJ3siYrV89WKgVqdXunzXyiej1tIkMrgF/iM30wG6cLAHP0ctsMekm1Cu8yf
 rgzPc+c3Mc4i24OyX+6BOTu3mQzbfFARUKfoRa4v11cm/TKjDqhLrEcFtRWQJVVYbYlW
 1PQkwtCkY+/BfmdeA9tHLUHu4klIYtjKtBAe5L8BxXtHosfnHRlxuJxk/FJz/d/gWMWk
 ssupUTsFvZz4nJNXWyc8iZxOe5LNKC/Zt/gwljFppxr+dm2FOiRntzsyv2IDTsKJIIhh
 NgSMGUhLT0ATYF3esbUrjkQdRbZrU14j91boIan2EFHK3TGkfc9AknvTtecdosC0kFZo tg== 
Received: from smtp.notes.na.collabserv.com (smtp.notes.na.collabserv.com [192.155.248.93])
        by mx0b-001b2d01.pphosted.com with ESMTP id 36sqd1cmdn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-rdma@vger.kernel.org>; Thu, 18 Feb 2021 08:59:37 -0500
Received: from localhost
        by smtp.notes.na.collabserv.com with smtp.notes.na.collabserv.com ESMTP
        for <linux-rdma@vger.kernel.org> from <BMT@zurich.ibm.com>;
        Thu, 18 Feb 2021 13:59:37 -0000
Received: from us1a3-smtp05.a3.dal06.isc4sb.com (10.146.71.159)
        by smtp.notes.na.collabserv.com (10.106.227.39) with smtp.notes.na.collabserv.com ESMTP;
        Thu, 18 Feb 2021 13:59:36 -0000
Received: from us1a3-mail162.a3.dal06.isc4sb.com ([10.146.71.4])
          by us1a3-smtp05.a3.dal06.isc4sb.com
          with ESMTP id 2021021813593602-386771 ;
          Thu, 18 Feb 2021 13:59:36 +0000 
In-Reply-To: <2f01b2b4-f024-d469-7176-aaaca3af9e96@amazon.com>
Subject: Re: Re: ibv_req_notify_cq clarification
From:   "Bernard Metzler" <BMT@zurich.ibm.com>
To:     "Gal Pressman" <galpress@amazon.com>
Cc:     "RDMA mailing list" <linux-rdma@vger.kernel.org>
Date:   Thu, 18 Feb 2021 13:59:35 +0000
MIME-Version: 1.0
Sensitivity: 
Importance: Normal
X-Priority: 3 (Normal)
References: <2f01b2b4-f024-d469-7176-aaaca3af9e96@amazon.com>,<bd5deec5-8fc6-ccd6-927a-898f6d9ab35b@amazon.com>
 <OF8421F948.8385A3FA-ON00258680.00454F8A-00258680.00456EC9@notes.na.collabserv.com>
X-Mailer: IBM iNotes ($HaikuForm 1054.1) | IBM Domino Build
 SCN1812108_20180501T0841_FP130 January 13, 2021 at 14:04
X-LLNOutbound: False
X-Disclaimed: 39995
X-TNEFEvaluated: 1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
x-cbid: 21021813-8889-0000-0000-0000049A2A34
X-IBM-SpamModules-Scores: BY=0; FL=0; FP=0; FZ=0; HX=0; KW=0; PH=0;
 SC=0.40962; ST=0; TS=0; UL=0; ISC=; MB=0.033196
X-IBM-SpamModules-Versions: BY=3.00014755; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000295; SDB=6.01509599; UDB=6.00815175; IPR=6.01292123;
 MB=3.00036174; MTD=3.00000008; XFM=3.00000015; UTC=2021-02-18 13:59:36
X-IBM-AV-DETECTION: SAVI=unsuspicious REMOTE=unsuspicious XFE=unused
X-IBM-AV-VERSION: SAVI=2021-02-18 03:41:58 - 6.00012309
x-cbparentid: 21021813-8890-0000-0000-0000AEFA2DD5
Message-Id: <OFC3C0A907.C449E5C5-ON00258680.004AAFCE-00258680.004CDDF7@notes.na.collabserv.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-02-18_05:2021-02-18,2021-02-18 signatures=0
X-Proofpoint-Spam-Reason: orgsafe
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

-----"Gal Pressman" <galpress@amazon.com> wrote: -----

>To: "Bernard Metzler" <BMT@zurich.ibm.com>
>From: "Gal Pressman" <galpress@amazon.com>
>Date: 02/18/2021 01:47PM
>Cc: "RDMA mailing list" <linux-rdma@vger.kernel.org>
>Subject: [EXTERNAL] Re: ibv=5Freq=5Fnotify=5Fcq clarification
>
>On 18/02/2021 14:38, Bernard Metzler wrote:
>> -----"Gal Pressman" <galpress@amazon.com> wrote: -----
>>=20
>>> To: "RDMA mailing list" <linux-rdma@vger.kernel.org>
>>> From: "Gal Pressman" <galpress@amazon.com>
>>> Date: 02/18/2021 11:26AM
>>> Subject: [EXTERNAL] ibv=5Freq=5Fnotify=5Fcq clarification
>>>
>>> I'm a bit confused about the meaning of the ibv=5Freq=5Fnotify=5Fcq()
>verb:
>>> "Upon the addition of a new CQ entry (CQE) to cq, a completion
>event
>>> will be
>>> added to the completion channel associated with the CQ."
>>>
>>> What is considered a new CQE in this case?
>>> The next CQE from the user's perspective, i.e. any new CQE that
>>> wasn't consumed
>>> by the user's poll cq?
>>> Or any new CQE from the device's perspective?
>>>
>>> For example, if at the time of ibv=5Freq=5Fnotify=5Fcq() call the CQ has
>>> received 100
>>> completions, but the user hasn't polled his CQ yet, when should he
>be
>>> notified?
>>> On the 101 completion or immediately (since there are completions
>>> waiting on the
>>> CQ)?
>>=20
>> It is from drivers perspective. So notification when 101
>> became available and CQ is marked for notification.
>> Applications tend to poll the CQ after requesting
>> notification, since there might be a race
>> from appl perspective...
>
>Thanks Bernard,
>
>Looking at the implementation of rdma-core providers, most of them
>pass the CQ
>consumer index as part of the arm doorbell which made me think it
>arms the CQ to
>notify on a completion newer than what the app polled, not on a
>completion newer
>than the producer index.
>Any idea why the consumer index is needed if that's not the case?
>
...maybe to do what you suggest - just kicking the completion
handler if it appears the application has missed CQE's when the
CQ was not armed? That would be in the gray zone of having
a provider which wants to be smarter than the application,
since this feature is not part of the verbs specification.
I'd suggest applications better to rely on the
IB=5FCQ=5FREPORT=5FMISSED=5FEVENTS flag if it doesn't want to
pull unconditionally.

