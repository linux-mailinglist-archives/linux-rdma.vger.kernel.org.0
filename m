Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DEE031CA86
	for <lists+linux-rdma@lfdr.de>; Tue, 16 Feb 2021 13:28:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229761AbhBPM2U (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 16 Feb 2021 07:28:20 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:55648 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229742AbhBPM2T (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 16 Feb 2021 07:28:19 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 11GC1kgo068782
        for <linux-rdma@vger.kernel.org>; Tue, 16 Feb 2021 07:27:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=in-reply-to : subject :
 from : to : cc : date : mime-version : references :
 content-transfer-encoding : content-type : message-id; s=pp1;
 bh=xKCqcttj1FC3Xs5w20HYn2NKCjJ4xwAPAlu3un4Pczw=;
 b=L/dexIcIX1NYziZd3t3A2rCoYFX4/wZ49eGMqsGxXUILPXuKdHiVAjzklAWFoNsZ1CaW
 Pm8j2s2npPVSPNjbEc4SXakxubEPR8Xn3TPHDLbJ3sX5/QzatV6Tv5ASMuFXJ0DpsYuU
 rRUVm7rZJI/nqFyUUt/wuuHifQO3loM9Wg/y1eXf/+YlhTbbOwFD2++5Ikx0EYXm4oYI
 WDAEj7ZT3X1zB928FU4Q1hba98FWbcngZ2QeWOQEN0Snx4sJVIKFmqdioOCWY/wdVm6e
 mVYH+Q98b5vc+w7/Vz7xVMy/RrzYLiLwBK/SvQu+lKr6PORpjZLzEVffihEal7Njf8mh Ng== 
Received: from smtp.notes.na.collabserv.com (smtp.notes.na.collabserv.com [192.155.248.67])
        by mx0b-001b2d01.pphosted.com with ESMTP id 36rdey1cpy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-rdma@vger.kernel.org>; Tue, 16 Feb 2021 07:27:38 -0500
Received: from localhost
        by smtp.notes.na.collabserv.com with smtp.notes.na.collabserv.com ESMTP
        for <linux-rdma@vger.kernel.org> from <BMT@zurich.ibm.com>;
        Tue, 16 Feb 2021 12:27:37 -0000
Received: from us1a3-smtp06.a3.dal06.isc4sb.com (10.146.103.243)
        by smtp.notes.na.collabserv.com (10.106.227.16) with smtp.notes.na.collabserv.com ESMTP;
        Tue, 16 Feb 2021 12:27:36 -0000
Received: from us1a3-mail162.a3.dal06.isc4sb.com ([10.146.71.4])
          by us1a3-smtp06.a3.dal06.isc4sb.com
          with ESMTP id 2021021612273521-343854 ;
          Tue, 16 Feb 2021 12:27:35 +0000 
In-Reply-To: <61EFD7EA-FA16-4AA1-B92F-0B0D4CC697AB@oracle.com>
Subject: Re: directing soft iWARP traffic through a secure tunnel
From:   "Bernard Metzler" <BMT@zurich.ibm.com>
To:     "Chuck Lever" <chuck.lever@oracle.com>
Cc:     "linux-rdma" <linux-rdma@vger.kernel.org>,
        "Benjamin Coddington" <bcodding@redhat.com>
Date:   Tue, 16 Feb 2021 12:27:33 +0000
MIME-Version: 1.0
Sensitivity: 
Importance: Normal
X-Priority: 3 (Normal)
References: <61EFD7EA-FA16-4AA1-B92F-0B0D4CC697AB@oracle.com>
X-Mailer: IBM iNotes ($HaikuForm 1054.1) | IBM Domino Build
 SCN1812108_20180501T0841_FP130 January 13, 2021 at 14:04
X-LLNOutbound: False
X-Disclaimed: 29067
X-TNEFEvaluated: 1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
x-cbid: 21021612-7279-0000-0000-000004A2174A
X-IBM-SpamModules-Scores: BY=0.057761; FL=0; FP=0; FZ=0; HX=0; KW=0; PH=0;
 SC=0.40962; ST=0; TS=0; UL=0; ISC=; MB=0.045141
X-IBM-SpamModules-Versions: BY=3.00014751; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000295; SDB=6.01508613; UDB=6.00814582; IPR=6.01291137;
 MB=3.00036150; MTD=3.00000008; XFM=3.00000015; UTC=2021-02-16 12:27:36
X-IBM-AV-DETECTION: SAVI=unsuspicious REMOTE=unsuspicious XFE=unused
X-IBM-AV-VERSION: SAVI=2021-02-16 07:42:21 - 6.00012306
x-cbparentid: 21021612-7280-0000-0000-00009BF617A0
Message-Id: <OFA2194C43.CE483827-ON0025867E.004018CA-0025867E.004470FA@notes.na.collabserv.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-02-16_01:2021-02-16,2021-02-15 signatures=0
X-Proofpoint-Spam-Reason: orgsafe
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

-----"Chuck Lever" <chuck.lever@oracle.com> wrote: -----

>To: "linux-rdma" <linux-rdma@vger.kernel.org>
>From: "Chuck Lever" <chuck.lever@oracle.com>
>Date: 02/11/2021 08:38PM
>Cc: "Benjamin Coddington" <bcodding@redhat.com>
>Subject: [EXTERNAL] directing soft iWARP traffic through a secure
>tunnel
>
>Hi-
>
>This might sound crazy, but bear with me.
>
>The NFS community is starting to hold virtual interoperability
>testing
>events to replace our in-person events that are not feasible due to
>pandemic-related travel restrictions. I'm told other communities have
>started doing the same.
>
>The virtual event is being held on a private network that is set up
>using OpenVPN across a large geographical area. I attach my test
>systems to the VPN to access test systems run by others at other
>companies.
>
>We'd like to continue to include NFS/RDMA testing at these events.
>This means either RoCEv2 or iWARP, since obviously we can't create
>an ad hoc wide-area InfiniBand infrastructure.
>
>Because the VPN is operating over long distances, we've decided to
>start with iWARP. However, we are stumbling when it comes to
>directing
>the siw driver's traffic onto the tun0 device:
>
>[root@oracle-100 ~]# rdma link add siw0 type siw netdev tun0
>error: Invalid argument
>[root@oracle-100 ~]#
>
>Has anyone else tried to do this, and what was the approach? Or does
>siw not yet have this capability?
>
>Thanks in advance.
>
>

After some very little ad-hoc patching of siw and RDMA core,
we get RDMA connectivity over the VPN. For siw, all what is
needed is to enable attaching to other netdev's than type
ARPHRD=5FETHER, in particular allowing ARPHRD=5FNONE. It is
questionable, if software RDMA drivers need any such limitation,
if running on top of TCP or UDP.

The RDMA core currently does not accept a zero gid, which would
be the result of attaching to a tunnel w/o hardware address. I
tentatively disabled that code for tunnel devices (simply by
allowing a zero gid for device names starting with 'tun'), but
a serious solution would be different.

I think enabling software RDMA over TUN/TAP devices makes a lot
of sense, as exemplified by enabling this virtual NFS/RDMA test
event. If we agree on that, next step would be to come up with
the right way to do it. Would it make sense to start from the
rdma=5Flink=5Flayer enum, which already knows type
IB=5FLINK=5FLAYER=5FUNSPECIFIED ? RDMA drivers can report the link
type via device->ops.get=5Flink=5Flayer - see
rdma=5Fport=5Fget=5Flink=5Flayer(). Asking the RDMA core experts -
would a gid of zero have any side effects or bad implications,
since that ID is by no means unique?

Many thanks,
Bernard.

