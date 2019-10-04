Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 964AFCBC2D
	for <lists+linux-rdma@lfdr.de>; Fri,  4 Oct 2019 15:48:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388897AbfJDNsN convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-rdma@lfdr.de>); Fri, 4 Oct 2019 09:48:13 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:39908 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2388149AbfJDNsN (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 4 Oct 2019 09:48:13 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x94DgZYH138359
        for <linux-rdma@vger.kernel.org>; Fri, 4 Oct 2019 09:48:11 -0400
Received: from smtp.notes.na.collabserv.com (smtp.notes.na.collabserv.com [192.155.248.74])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2ve5s5mgkk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-rdma@vger.kernel.org>; Fri, 04 Oct 2019 09:48:11 -0400
Received: from localhost
        by smtp.notes.na.collabserv.com with smtp.notes.na.collabserv.com ESMTP
        for <linux-rdma@vger.kernel.org> from <BMT@zurich.ibm.com>;
        Fri, 4 Oct 2019 13:48:10 -0000
Received: from us1a3-smtp05.a3.dal06.isc4sb.com (10.146.71.159)
        by smtp.notes.na.collabserv.com (10.106.227.92) with smtp.notes.na.collabserv.com ESMTP;
        Fri, 4 Oct 2019 13:47:45 -0000
Received: from us1a3-mail162.a3.dal06.isc4sb.com ([10.146.71.4])
          by us1a3-smtp05.a3.dal06.isc4sb.com
          with ESMTP id 2019100413474442-521400 ;
          Fri, 4 Oct 2019 13:47:44 +0000 
In-Reply-To: <20191004045718.GA29290@chelsio.com>
Subject: Re: Re: Re: Re: Re: [PATCH for-next] RDMA/siw: fix SQ/RQ drain logic to
 support ib_drain_qp
From:   "Bernard Metzler" <BMT@zurich.ibm.com>
To:     "Krishnamraju Eraparaju" <krishna2@chelsio.com>
Cc:     "jgg@ziepe.ca" <jgg@ziepe.ca>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "Potnuri Bharat Teja" <bharat@chelsio.com>,
        "Nirranjan Kirubaharan" <nirranjan@chelsio.com>
Date:   Fri, 4 Oct 2019 13:47:44 +0000
MIME-Version: 1.0
Sensitivity: 
Importance: Normal
X-Priority: 3 (Normal)
References: <20191004045718.GA29290@chelsio.com>,<20191003105112.GA20688@chelsio.com>
 <20191001174502.GB31728@chelsio.com> <20191001095224.GA5448@chelsio.com>
 <20190927221545.5944-1-krishna2@chelsio.com>
 <OFFA5BB431.AD96EB3F-ON00258485.0054053B-00258485.0055D206@notes.na.collabserv.com>
 <OF8E75AE75.02E5B443-ON00258486.00578402-00258486.00579818@notes.na.collabserv.com>
 <OFB95A41D1.52157F37-ON00258487.003EF8B5-00258487.003EF8F6@notes.na.collabserv.com>
 <OF2EDF2738.25C83B56-ON00258488.003E6ADE-00258488.004D3019@notes.na.collabserv.com>
X-Mailer: IBM iNotes ($HaikuForm 1054) | IBM Domino Build
 SCN1812108_20180501T0841_FP57 August 05, 2019 at 12:42
X-LLNOutbound: False
X-Disclaimed: 48287
X-TNEFEvaluated: 1
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset=UTF-8
x-cbid: 19100413-3165-0000-0000-0000013B7E88
X-IBM-SpamModules-Scores: BY=0; FL=0; FP=0; FZ=0; HX=0; KW=0; PH=0;
 SC=0.40962; ST=0; TS=0; UL=0; ISC=; MB=0.118653
X-IBM-SpamModules-Versions: BY=3.00011888; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000292; SDB=6.01270599; UDB=6.00672568; IPR=6.01052648;
 MB=3.00028942; MTD=3.00000008; XFM=3.00000015; UTC=2019-10-04 13:48:08
X-IBM-AV-DETECTION: SAVI=unsuspicious REMOTE=unsuspicious XFE=unused
X-IBM-AV-VERSION: SAVI=2019-10-04 10:06:07 - 6.00010485
x-cbparentid: 19100413-3166-0000-0000-000047198A8D
Message-Id: <OFBE05CE37.CBF33C8C-ON00258489.004868EE-00258489.004BC858@notes.na.collabserv.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-10-04_06:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

-----"Krishnamraju Eraparaju" <krishna2@chelsio.com> wrote: -----

>To: "Bernard Metzler" <BMT@zurich.ibm.com>
>From: "Krishnamraju Eraparaju" <krishna2@chelsio.com>
>Date: 10/04/2019 06:57AM
>Cc: "jgg@ziepe.ca" <jgg@ziepe.ca>, "linux-rdma@vger.kernel.org"
><linux-rdma@vger.kernel.org>, "Potnuri Bharat Teja"
><bharat@chelsio.com>, "Nirranjan Kirubaharan" <nirranjan@chelsio.com>
>Subject: [EXTERNAL] Re: Re: Re: Re: [PATCH for-next] RDMA/siw: fix
>SQ/RQ drain logic to support ib_drain_qp
>
>On Thursday, October 10/03/19, 2019 at 14:03:05 +0000, Bernard
>Metzler wrote:
>> There are other reasons why the generic
>> __ib_drain_sq() may fail. A CQ overflow is one
>> such candidate. Failures are not handled by the ULP,
>> since calling a void function.
>The function description of ib_drain_qp() says:
> * The caller must:
> *
> * ensure there is room in the CQ(s), SQ, and RQ for drain work
>requests
> * and completions.
> *
> * allocate the CQs using ib_alloc_cq().
> *
> * ensure that there are no other contexts that are posting WRs
> * concurrently.
> * Otherwise the drain is not guaranteed.
> */
>
Yes, I know. Imho, this guarantee falls into the same category
as assuming a sane ULP which will not try to change the QP state
at the same time while calling for sq_drain. A CQ overflow  would
be a miscalculation of its size by the ULP. A drain_sq in parallel
with a modify_qp call just another misbehaving..? Anyway, I think
you are right, let's handle explicitly all cases we can handle.

>
>So, it looks like ULP has to check for available CQs before calling
>ib_drain_xx(). 
>> 
>> At the other hand, we know that if we have reached
>> ERROR state, the QP will never escape back to become
>> full functional; ERROR is the QP's final state.
>> 
>> So we could do an extra check if we cannot get
>> the state lock - if we are already in ERROR. And
>> if yes, complete immediately there as well.
>> 
>> I can change the patch accordingly. Makes sense?
>Yes, I think addressing this would make the fix complete.
>
sent.

I'll be away whole next week from tonight on.

Thanks
Bernard.

>Thanks,
>Krishna.
>
>

