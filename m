Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2ADC2874FF
	for <lists+linux-rdma@lfdr.de>; Thu,  8 Oct 2020 15:12:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726058AbgJHNMn (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 8 Oct 2020 09:12:43 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:51586 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725882AbgJHNMn (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 8 Oct 2020 09:12:43 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 098D2Txn003861
        for <linux-rdma@vger.kernel.org>; Thu, 8 Oct 2020 09:12:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=in-reply-to : subject :
 from : to : cc : date : mime-version : references :
 content-transfer-encoding : content-type : message-id; s=pp1;
 bh=zx1EpECxENEa4uH5f8XaFWYGhXVbDZTX0bThMklKsmM=;
 b=N3IvhAxjAHz/m4AxwnVbbdRBZfgOpGrR0EkHx3ma+xo/SbHmpiyLssn2hFUBP2OK14R4
 LBzf/cDuNxvdZxcWDQjOaFbot7++21gitS0pUDAjWtVf/1lyFHbb0baiXkp9hJrczXHE
 nYktnzUC9N706wBZGAOirVnqddC8Tjj7TnPwDQH8iUy9koRpxkk041qMZSdNYbnWqgwy
 yQYGcUKdEENJo4aOmzlHOqwVE2larxc9I9UdnRgc3Mvid7In9+ls2QTvEXXPfnsosutg
 fYl6MowPwv1sqNyC3i86rHV+H3YRVajLLqaIw4M5Nxry5eFAwpJnJ43PuW728nDRghrZ fg== 
Received: from smtp.notes.na.collabserv.com (smtp.notes.na.collabserv.com [192.155.248.75])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3421ebv7se-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-rdma@vger.kernel.org>; Thu, 08 Oct 2020 09:12:42 -0400
Received: from localhost
        by smtp.notes.na.collabserv.com with smtp.notes.na.collabserv.com ESMTP
        for <linux-rdma@vger.kernel.org> from <BMT@zurich.ibm.com>;
        Thu, 8 Oct 2020 13:12:41 -0000
Received: from us1a3-smtp01.a3.dal06.isc4sb.com (10.106.154.95)
        by smtp.notes.na.collabserv.com (10.106.227.123) with smtp.notes.na.collabserv.com ESMTP;
        Thu, 8 Oct 2020 13:12:40 -0000
Received: from us1a3-mail162.a3.dal06.isc4sb.com ([10.146.71.4])
          by us1a3-smtp01.a3.dal06.isc4sb.com
          with ESMTP id 2020100813124032-457522 ;
          Thu, 8 Oct 2020 13:12:40 +0000 
In-Reply-To: <20201007033619.GA11425@chelsio.com>
Subject: Re: Re: reduce iSERT Max IO size
From:   "Bernard Metzler" <BMT@zurich.ibm.com>
To:     "Krishnamraju Eraparaju" <krishna2@chelsio.com>
Cc:     "Max Gurtovoy" <mgurtovoy@nvidia.com>,
        "Sagi Grimberg" <sagi@grimberg.me>, linux-rdma@vger.kernel.org,
        "Potnuri Bharat Teja" <bharat@chelsio.com>,
        "Max Gurtovoy" <maxg@mellanox.com>
Date:   Thu, 8 Oct 2020 13:12:39 +0000
MIME-Version: 1.0
Sensitivity: 
Importance: Normal
X-Priority: 3 (Normal)
References: <20201007033619.GA11425@chelsio.com>,<20200922104424.GA18887@chelsio.com>
 <07e53835-8389-3e07-6976-505edbd94f2a@grimberg.me>
 <20201002171007.GA16636@chelsio.com>
 <4d0b1a3f-2980-c7ed-ef9a-0ed6a9c87a69@grimberg.me>
 <20201003033644.GA19516@chelsio.com>
 <4391e240-5d6d-fb59-e6fb-e7818d1d0bd2@nvidia.com>
X-Mailer: IBM iNotes ($HaikuForm 1054.1) | IBM Domino Build
 SCN1812108_20180501T0841_FP65 April 15, 2020 at 09:48
X-LLNOutbound: False
X-Disclaimed: 41895
X-TNEFEvaluated: 1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
x-cbid: 20100813-6875-0000-0000-000003B02148
X-IBM-SpamModules-Scores: BY=0.273053; FL=0; FP=0; FZ=0; HX=0; KW=0; PH=0;
 SC=0.40962; ST=0; TS=0; UL=0; ISC=; MB=0.126173
X-IBM-SpamModules-Versions: BY=3.00013973; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000295; SDB=6.01446149; UDB=6.00777387; IPR=6.01228847;
 MB=3.00034441; MTD=3.00000008; XFM=3.00000015; UTC=2020-10-08 13:12:41
X-IBM-AV-DETECTION: SAVI=unsuspicious REMOTE=unsuspicious XFE=unused
X-IBM-AV-VERSION: SAVI=2020-10-08 07:12:40 - 6.00011929
x-cbparentid: 20100813-6876-0000-0000-00002533219B
Message-Id: <OF798A0BBE.E84F1C4A-ON002585FB.00486CB1-002585FB.004891F2@notes.na.collabserv.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-10-08_08:2020-10-08,2020-10-08 signatures=0
X-Proofpoint-Spam-Reason: orgsafe
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

-----"Krishnamraju Eraparaju" <krishna2@chelsio.com> wrote: -----

>To: "Max Gurtovoy" <mgurtovoy@nvidia.com>
>From: "Krishnamraju Eraparaju" <krishna2@chelsio.com>
>Date: 10/07/2020 05:36AM
>Cc: "Sagi Grimberg" <sagi@grimberg.me>, linux-rdma@vger.kernel.org,
>"Potnuri Bharat Teja" <bharat@chelsio.com>, "Max Gurtovoy"
><maxg@mellanox.com>
>Subject: [EXTERNAL] Re: reduce iSERT Max IO size
>
>On Sunday, October 10/04/20, 2020 at 00:45:26 +0300, Max Gurtovoy
>wrote:
>>=20
>> On 10/3/2020 6:36 AM, Krishnamraju Eraparaju wrote:
>> >On Friday, October 10/02/20, 2020 at 13:29:30 -0700, Sagi Grimberg
>wrote:
>> >>>Hi Sagi & Max,
>> >>>
>> >>>Any update on this?
>> >>>Please change the max IO size to 1MiB(256 pages).
>> >>I think that the reason why this was changed to handle the worst
>case
>> >>was in case there are different capabilities on the initiator and
>the
>> >>target with respect to number of pages per MR. There is no
>handshake
>> >>that aligns expectations.
>> >But, the max pages per MR supported by most adapters is around 256
>pages
>> >only.
>> >And I think only those iSER initiators, whose max pages per MR is
>4096,
>> >could send 16MiB sized IOs, am I correct?
>>=20
>> If the initiator can send 16MiB, we must make sure the target is
>> capable to receive it.
>I think max IO size, at iSER initiator, depends on
>"max=5Ffast=5Freg=5Fpage=5Flist=5Flen".
>currently, below are the supported "max=5Ffast=5Freg=5Fpage=5Flist=5Flen" =
of
>various iwarp drivers:
>
>iw=5Fcxgb4: 128 pages
>Softiwarp: 256 pages
>i40iw: 512 pages
>qedr: couldn't find.
>

For siw, this limit is not determined by resource constraints.
We could bump it up to 512, or higher. What is a reasonable
maximum, from iSER view?


>For iwarp case, if 512 is the max pages supported by all iwarp
>drivers,
>then provisioning a gigantic MR pool at target(to accommodate never
>used
>16MiB IO) wouldn't be a overkill?
>>=20
>> >
>> >>If we revert that it would restore the issue that you reported in
>the
>> >>first place:
>> >>
>> >>--
>> >>IB/isert: allocate RW ctxs according to max IO size
>> >I don't see the reported issue after reducing the IO size to 256
>> >pages(keeping all other changes of this patch intact).
>> >That is, "attr.cap.max=5Frdma=5Fctxs" is now getting filled properly
>with
>> >"rdma=5Frw=5Fmr=5Ffactor()" related changes, I think.
>> >
>> >Before this change "attr.cap.max=5Frdma=5Fctxs" was hardcoded with
>> >128(ISCSI=5FDEF=5FXMIT=5FCMDS=5FMAX) pages, which is very low for single
>target
>> >and muli-luns case.
>> >
>> >So reverting only ISCSI=5FISER=5FMAX=5FSG=5FTABLESIZE macro to 256 does=
n't
>cause the
>> >reported issue.
>> >
>> >Thanks,
>> >Krishnam Raju.
>> >>Current iSER target code allocates MR pool budget based on queue
>size.
>> >>Since there is no handshake between iSER initiator and target on
>max IO
>> >>size, we'll set the iSER target to support upto 16MiB IO
>operations and
>> >>allocate the correct number of RDMA ctxs according to the factor
>of MR's
>> >>per IO operation. This would guaranty sufficient size of the MR
>pool for
>> >>the required IO queue depth and IO size.
>> >>
>> >>Reported-by: Krishnamraju Eraparaju <krishna2@chelsio.com>
>> >>Tested-by: Krishnamraju Eraparaju <krishna2@chelsio.com>
>> >>Signed-off-by: Max Gurtovoy <maxg@mellanox.com>
>> >>--
>> >>
>> >>>
>> >>>Thanks,
>> >>>Krishnam Raju.
>> >>>On Wednesday, September 09/23/20, 2020 at 01:57:47 -0700, Sagi
>Grimberg wrote:
>> >>>>>Hi,
>> >>>>>
>> >>>>>Please reduce the Max IO size to 1MiB(256 pages), at iSER
>Target.
>> >>>>>The PBL memory consumption has increased significantly after
>increasing
>> >>>>>the Max IO size to 16MiB(with commit:317000b926b07c).
>> >>>>>Due to the large MR pool, the max no.of iSER connections(On
>one variant
>> >>>>>of Chelsio cards) came down to 9, before it was 250.
>> >>>>>NVMe-RDMA target also uses 1MiB max IO size.
>> >>>>Max, remind me what was the point to support 16M? Did this
>resolve
>> >>>>an issue?
>

