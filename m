Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FF67394443
	for <lists+linux-rdma@lfdr.de>; Fri, 28 May 2021 16:35:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236064AbhE1Ogp (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 28 May 2021 10:36:45 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:27808 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S235940AbhE1Ogo (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 28 May 2021 10:36:44 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 14SEYSkJ006920
        for <linux-rdma@vger.kernel.org>; Fri, 28 May 2021 10:35:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=in-reply-to : subject :
 from : to : cc : date : references : content-type : message-id :
 content-transfer-encoding : mime-version; s=pp1;
 bh=DW5mBKpkUgFiPSP91P2mSiY2zI3d1i3W6MiUcpe3+Bo=;
 b=Xt1kRFlGVFnyNAZhZQroYeE+jJTpsW/ZaaR3tEaFzvHM5rc7aYnKXE+5/Fa7i9vpsetI
 irtFdSssOol24JOArjT4jh4s+oFW6iAHZVYyuoeokLLR6NR+aeUhKEORdNpWXLtMSZ1T
 etGoxCUw4S06nzUWJE2PwuKV5Wf7DxMsSFWxBWze7m8x21X8o7l/mPzEuS4CW0xj3qr4
 y2X0MfYgaTG+I+5GAUeUR4/TMfsbrpoJLPc59BAcdV8P1haEATwAjHEsi4KSDqWxj8dC
 jcCP1JGVlRqAWEEm6cBOoYaa0V9Cq3wL3M9rvSqQHLsgsYi73oOeO3mtx3N1MB9p/WrJ 7g== 
Received: from smtp.notes.na.collabserv.com (smtp.notes.na.collabserv.com [192.155.248.66])
        by mx0b-001b2d01.pphosted.com with ESMTP id 38u2bsr3xr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-rdma@vger.kernel.org>; Fri, 28 May 2021 10:35:09 -0400
Received: from localhost
        by smtp.notes.na.collabserv.com with smtp.notes.na.collabserv.com ESMTP
        for <linux-rdma@vger.kernel.org> from <BMT@zurich.ibm.com>;
        Fri, 28 May 2021 14:35:08 -0000
Received: from us1a3-smtp08.a3.dal06.isc4sb.com (10.146.103.57)
        by smtp.notes.na.collabserv.com (10.106.227.127) with smtp.notes.na.collabserv.com ESMTP;
        Fri, 28 May 2021 14:35:07 -0000
Received: from us1a3-mail162.a3.dal06.isc4sb.com ([10.146.71.4])
          by us1a3-smtp08.a3.dal06.isc4sb.com
          with ESMTP id 2021052814350700-371770 ;
          Fri, 28 May 2021 14:35:07 +0000 
In-Reply-To: <731bc8e0-4bbc-7006-23ef-2e0008f5e415@samba.org>
Subject: Re: Re: [PATCH 00/31] rdma/siw: fix a lot of deadlocks and use after free
 bugs
From:   "Bernard Metzler" <BMT@zurich.ibm.com>
To:     "Stefan Metzmacher" <metze@samba.org>
Cc:     "linux-rdma" <linux-rdma@vger.kernel.org>
Date:   Fri, 28 May 2021 14:35:07 +0000
Sensitivity: 
Importance: Normal
X-Priority: 3 (Normal)
References: <731bc8e0-4bbc-7006-23ef-2e0008f5e415@samba.org>,<cover.1620343860.git.metze@samba.org>
 <OF63068FA7.7F9E2E59-ON002586CE.0041A961-002586CE.0042BDA1@notes.na.collabserv.com>
X-Mailer: IBM iNotes ($HaikuForm 1054.1) | IBM Domino Build
 SCN1812108_20180501T0841_FP130 January 13, 2021 at 14:04
X-LLNOutbound: False
X-Disclaimed: 60523
X-TNEFEvaluated: 1
Content-Type: text/plain; charset=UTF-8
x-cbid: 21052814-4409-0000-0000-00000530F3B3
X-IBM-SpamModules-Scores: BY=0; FL=0; FP=0; FZ=0; HX=0; KW=0; PH=0; SC=0;
 ST=0; TS=0; UL=0; ISC=; MB=0.000356
X-IBM-SpamModules-Versions: BY=3.00015193; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000296; SDB=6.01548293; UDB=6.00841538; IPR=6.01330255;
 MB=3.00036958; MTD=3.00000008; XFM=3.00000015; UTC=2021-05-28 14:35:08
X-IBM-AV-DETECTION: SAVI=unsuspicious REMOTE=unsuspicious XFE=unused
X-IBM-AV-VERSION: SAVI=2021-03-25 10:49:15 - 6.00012377
x-cbparentid: 21052814-4410-0000-0000-0000A820F783
Message-Id: <OF3E623A7B.5CEABB75-ON002586E3.004D659D-002586E3.00501E8D@notes.na.collabserv.com>
X-Proofpoint-GUID: H86999tpL_U2X1LKR1u3V9Sn0laPVH51
X-Proofpoint-ORIG-GUID: H86999tpL_U2X1LKR1u3V9Sn0laPVH51
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-05-28_05:2021-05-27,2021-05-28 signatures=0
X-Proofpoint-Spam-Reason: orgsafe
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

-----"Stefan Metzmacher" <metze@samba.org> wrote: -----

>To: "Bernard Metzler" <BMT@zurich.ibm.com>
>From: "Stefan Metzmacher" <metze@samba.org>
>Date: 05/26/2021 05:44PM
>Cc: "linux-rdma" <linux-rdma@vger.kernel.org>
>Subject: [EXTERNAL] Re: [PATCH 00/31] rdma/siw: fix a lot of
>deadlocks and use after free bugs
>
>Hi Bernard,
>
>> Much appreciated!
>> These are quite some patches, and I will need some time
>> to go through. Would bee nice if those would be broken
>> down into smaller bundles (introduce non-blocking connect,
>> _siw_cep_close() subroutine, fixing cep reference counting,
>> smp_mb() after STag invalidation, ..).=20
>
>They mostly fall out naturally getting one step further
>with each commit. So most of them depend on each other.
>I'll see if I can reorder some of them, but I'm not sure it's really
>worth the effort.

Why not having just a few patches - one fixing the obvious
object management bug(s), one on a more concise error handling,
one on using exported kernel functions instead of calling
socket method directly, one introducing asynchronous connect..?

I understand you collected problems over time and fixed those,
but it would be much easier to digest if separated logically.

>
>> Anyway, many thanks for the effort,
>
>Thanks a lot for the review.
>
>> it will improve the driver!
>
>Yes!
>
>On top I have some code to support MPA rev1 in peer_to_peer mode
>in order to interoperate with a Chelcio T404-BT card running
>under Windows.
>
>In preparation I've code that moves the currently hardcoded values
>(which where module params before) into a per device structure,
>some like 'sdev->options.crc_strict'. With that we only need to
>find a good way to pass these parameters from userspace to the
>device. I guess that should be done somehow via the 'rdma link add'
>command, or via files similar to /proc/sys/net/ipv4/conf/*.
>
yes with dropping the module parameters we lost that flexibility...

I'd prefer protocol specific extensions to the rdma tools.

In fact, we could allow different CRC and MPA settings per
QP (which would make sense if we have connections from a
local siw device to multiple remote devices with different
capabilities etc.). But we do not have endpoint/QP object
specific settings in rdma netlink currently.=20
Having link specific settings might be sufficient though.


>Here's my branch with all (partly incomplete) siw changes:
>INVALID URI REMOVED
>Fp-3Dmetze_linux_wip.git-3Ba-3Dshortlog-3Bh-3Drefs_heads_rdma-2Dnext-
>2Dsiw&d=3DDwIDaQ&c=3Djf_iaSHvJObTbx-siA1ZOg&r=3D2TaYXQ0T-r8ZO1PP1alNwU_QJcR
>RLfmYTAgd3QCvqSc&m=3DbcCk65hNAmUVFgsBxIE9Y6S1cnxdE1otmHllxAlO-Ko&s=3DRgu7
>GuEAeI9MyUx7m03KEMLH2qA7Y3065X8LCBo3EBY&e=3D=20
>

Thanks, I'll have a look.

>> First comments:
>>=20
>> A non blocking connect does really makes sense as you
>> are pointing out. I hope it doesn't complicate the CM
>> code even further.
>>=20
>> I think we agreed upon not using BUG() and BUG_ON(),
>> so please don't introduce it.
>
>Ok.
>
>> 'I hit a lot of bugs' is not very helpful, but just
>> a statement.
>
>More details are in the individual commit messages,
>should I double them in the cover letter next time?
>
>Currently I'm quite busy with other stuff...
>I hope to find some time in the next weeks to
>comment more detailed and post a new revision.
>
>metze
>
Thanks again!
Bernard.

