Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 41C8634F13
	for <lists+linux-rdma@lfdr.de>; Tue,  4 Jun 2019 19:37:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726211AbfFDRhW convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-rdma@lfdr.de>); Tue, 4 Jun 2019 13:37:22 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:55160 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725929AbfFDRhW (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 4 Jun 2019 13:37:22 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x54HWqLe133162
        for <linux-rdma@vger.kernel.org>; Tue, 4 Jun 2019 13:37:21 -0400
Received: from smtp.notes.na.collabserv.com (smtp.notes.na.collabserv.com [192.155.248.74])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2swub0netx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-rdma@vger.kernel.org>; Tue, 04 Jun 2019 13:37:21 -0400
Received: from localhost
        by smtp.notes.na.collabserv.com with smtp.notes.na.collabserv.com ESMTP
        for <linux-rdma@vger.kernel.org> from <BMT@zurich.ibm.com>;
        Tue, 4 Jun 2019 17:37:20 -0000
Received: from us1a3-smtp03.a3.dal06.isc4sb.com (10.106.154.98)
        by smtp.notes.na.collabserv.com (10.106.227.92) with smtp.notes.na.collabserv.com ESMTP;
        Tue, 4 Jun 2019 17:37:16 -0000
Received: from us1a3-mail162.a3.dal06.isc4sb.com ([10.146.71.4])
          by us1a3-smtp03.a3.dal06.isc4sb.com
          with ESMTP id 2019060417371526-832553 ;
          Tue, 4 Jun 2019 17:37:15 +0000 
In-Reply-To: <20190603174948.GA13214@ziepe.ca>
Subject: Re: [PATCH for-next v1 00/12] SIW: Software iWarp RDMA (siw) driver
From:   "Bernard Metzler" <BMT@zurich.ibm.com>
To:     "Jason Gunthorpe" <jgg@ziepe.ca>
Cc:     linux-rdma@vger.kernel.org
Date:   Tue, 4 Jun 2019 17:37:15 +0000
MIME-Version: 1.0
Sensitivity: 
Importance: Normal
X-Priority: 3 (Normal)
References: <20190603174948.GA13214@ziepe.ca>,<20190526114156.6827-1-bmt@zurich.ibm.com>
X-Mailer: IBM iNotes ($HaikuForm 1054) | IBM Domino Build
 SCN1812108_20180501T0841_FP55 May 22, 2019 at 11:09
X-LLNOutbound: False
X-Disclaimed: 8723
X-TNEFEvaluated: 1
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset=UTF-8
x-cbid: 19060417-7581-0000-0000-00000C6A21F1
X-IBM-SpamModules-Scores: BY=0.076928; FL=0; FP=0; FZ=0; HX=0; KW=0; PH=0;
 SC=0.40962; ST=0; TS=0; UL=0; ISC=; MB=0.008108
X-IBM-SpamModules-Versions: BY=3.00011215; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000286; SDB=6.01213204; UDB=6.00637628; IPR=6.00994272;
 BA=6.00006326; NDR=6.00000001; ZLA=6.00000005; ZF=6.00000009; ZB=6.00000000;
 ZP=6.00000000; ZH=6.00000000; ZU=6.00000002; MB=3.00027182; XFM=3.00000015;
 UTC=2019-06-04 17:37:18
X-IBM-AV-DETECTION: SAVI=unsuspicious REMOTE=unsuspicious XFE=unused
X-IBM-AV-VERSION: SAVI=2019-06-04 17:31:03 - 6.00010007
x-cbparentid: 19060417-7582-0000-0000-000073FD4572
Message-Id: <OF2964C589.75C558D3-ON0025840F.004421F3-0025840F.0060CBAD@notes.na.collabserv.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-04_11:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

-----"Jason Gunthorpe" <jgg@ziepe.ca> wrote: -----

>To: "Bernard Metzler" <bmt@zurich.ibm.com>
>From: "Jason Gunthorpe" <jgg@ziepe.ca>
>Date: 06/03/2019 07:50PM
>Cc: linux-rdma@vger.kernel.org
>Subject: [EXTERNAL] Re: [PATCH for-next v1 00/12] SIW: Software iWarp
>RDMA (siw) driver
>
>On Sun, May 26, 2019 at 01:41:44PM +0200, Bernard Metzler wrote:
>> This patch set contributes the SoftiWarp driver rebased for
>> Kernel 5.2-rc1. SoftiWarp (siw) implements the iWarp RDMA
>> protocol over kernel TCP sockets. The driver integrates with
>> the linux-rdma framework.
>> 
>> With this new driver version, the following things where
>> changed, compared to the v8 RFC of siw:
>> 
>> o Rebased to 5.2-rc1
>> 
>> o All IDR code got removed.
>> 
>> o Both MR and QP deallocation verbs now synchronously
>>   free the resources referenced by the RDMA mid-layer.
>> 
>> o IPv6 support was added.
>> 
>> o For compatibility with Chelsio iWarp hardware, the RX
>>   path was slightly reworked. It now allows packet intersection
>>   between tagged and untagged RDMAP operations. While not
>>   a defined behavior as of IETF RFC 5040/5041, some RDMA hardware
>>   may intersect an ongoing outbound (large) tagged message, such
>>   as an multisegment RDMA Read Response with sending an untagged
>>   message, such as an RDMA Send frame. This behavior was only
>>   detected in an NVMeF setup, where siw was used at target side,
>>   and RDMA hardware at client side (during file write). siw now
>>   implements two input paths for tagged and untagged messages each,
>>   and allows the intersected placement of both messages.
>> 
>> o The siw kernel abi file got renamed from siw_user.h to siw-abi.h.
>> 
>> Many thanks for reviewing and testing the driver, especially to
>> Steve, Leon, Jason, Doug, Olga, Dennis, Gal. You all helped to
>> significantly improve the siw driver over the last year. It is
>> very much appreciated.
>
>You need to open a PR for rdma-core before this can be merged with
>the
>userspace part.
>
>Jason
>
>

OK I created PR #536, which adds the siw user library to
rdma-core. Unfortunately, when uploading, travis brought
up many issues with atomics etc. Is there a good way to
have the very same strict checking locally, since local build
was always successful...

In any case, sorry for abusing the PR procedure for code cleanup
(amending commits and force push cycles)!

Many thanks,
Bernard.



