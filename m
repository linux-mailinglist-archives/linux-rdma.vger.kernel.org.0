Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C09FBB4A01
	for <lists+linux-rdma@lfdr.de>; Tue, 17 Sep 2019 11:04:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726271AbfIQJEe convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-rdma@lfdr.de>); Tue, 17 Sep 2019 05:04:34 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:34470 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726084AbfIQJEd (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 17 Sep 2019 05:04:33 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x8H93rVD070955
        for <linux-rdma@vger.kernel.org>; Tue, 17 Sep 2019 05:04:32 -0400
Received: from smtp.notes.na.collabserv.com (smtp.notes.na.collabserv.com [192.155.248.81])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2v2set6n9m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-rdma@vger.kernel.org>; Tue, 17 Sep 2019 05:04:32 -0400
Received: from localhost
        by smtp.notes.na.collabserv.com with smtp.notes.na.collabserv.com ESMTP
        for <linux-rdma@vger.kernel.org> from <BMT@zurich.ibm.com>;
        Tue, 17 Sep 2019 09:04:31 -0000
Received: from us1a3-smtp06.a3.dal06.isc4sb.com (10.146.103.243)
        by smtp.notes.na.collabserv.com (10.106.227.88) with smtp.notes.na.collabserv.com ESMTP;
        Tue, 17 Sep 2019 09:04:24 -0000
Received: from us1a3-mail162.a3.dal06.isc4sb.com ([10.146.71.4])
          by us1a3-smtp06.a3.dal06.isc4sb.com
          with ESMTP id 2019091709042470-261544 ;
          Tue, 17 Sep 2019 09:04:24 +0000 
In-Reply-To: <20190916162829.GA22329@ziepe.ca>
Subject: Re: Re: Re: [PATCH v3] iwcm: don't hold the irq disabled lock on iw_rem_ref
From:   "Bernard Metzler" <BMT@zurich.ibm.com>
To:     "Jason Gunthorpe" <jgg@ziepe.ca>
Cc:     "Krishnamraju Eraparaju" <krishna2@chelsio.com>,
        "Steve Wise" <larrystevenwise@gmail.com>,
        "Sagi Grimberg" <sagi@grimberg.me>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Date:   Tue, 17 Sep 2019 09:04:24 +0000
MIME-Version: 1.0
Sensitivity: 
Importance: Normal
X-Priority: 3 (Normal)
References: <20190916162829.GA22329@ziepe.ca>,<20190904212531.6488-1-sagi@grimberg.me>
 <20190910111759.GA5472@chelsio.com>
 <5cc42f23-bf60-ca8d-f40c-cbd8875f5756@grimberg.me>
 <20190910192157.GA5954@chelsio.com>
 <OF00E4DFD9.0EEF58A6-ON00258472.0032F9AC-00258472.0034FEAA@notes.na.collabserv.com>
 <CADmRdJcCENJx==LaaJQYU_kMv5rSgD69Z6s+ubCKWjprZmPQpA@mail.gmail.com>
 <20190911155814.GA12639@chelsio.com>
X-Mailer: IBM iNotes ($HaikuForm 1054) | IBM Domino Build
 SCN1812108_20180501T0841_FP57 August 05, 2019 at 12:42
X-LLNOutbound: False
X-Disclaimed: 14559
X-TNEFEvaluated: 1
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset=UTF-8
x-cbid: 19091709-3067-0000-0000-000000BA8E63
X-IBM-SpamModules-Scores: BY=0; FL=0; FP=0; FZ=0; HX=0; KW=0; PH=0;
 SC=0.40962; ST=0; TS=0; UL=0; ISC=; MB=0.000006
X-IBM-SpamModules-Versions: BY=3.00011789; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000291; SDB=6.01262554; UDB=6.00667638; IPR=6.01044414;
 MB=3.00028662; MTD=3.00000008; XFM=3.00000015; UTC=2019-09-17 09:04:30
X-IBM-AV-DETECTION: SAVI=unsuspicious REMOTE=unsuspicious XFE=unused
X-IBM-AV-VERSION: SAVI=2019-09-17 02:42:02 - 6.00010416
x-cbparentid: 19091709-3068-0000-0000-000011D5E6F7
Message-Id: <OFAEAC1AA7.9611AF4F-ON00258478.002E162F-00258478.0031D798@notes.na.collabserv.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-09-17_05:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

-----"Jason Gunthorpe" <jgg@ziepe.ca> wrote: -----

>To: "Krishnamraju Eraparaju" <krishna2@chelsio.com>
>From: "Jason Gunthorpe" <jgg@ziepe.ca>
>Date: 09/16/2019 06:28PM
>Cc: "Steve Wise" <larrystevenwise@gmail.com>, "Bernard Metzler"
><BMT@zurich.ibm.com>, "Sagi Grimberg" <sagi@grimberg.me>,
>"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
>Subject: [EXTERNAL] Re: Re: [PATCH v3] iwcm: don't hold the irq
>disabled lock on iw_rem_ref
>
>On Wed, Sep 11, 2019 at 09:28:16PM +0530, Krishnamraju Eraparaju
>wrote:
>> Hi Steve & Bernard,
>> 
>> Thanks for the review comments.
>> I will do those formating changes.
>
>I don't see anything in patchworks, but the consensus is to drop
>Sagi's patch pending this future patch?
>
>Jason
>
This is my impression as well. But consensus should be
explicit...Sagi, what do you think?

Best regards,
Bernard.

