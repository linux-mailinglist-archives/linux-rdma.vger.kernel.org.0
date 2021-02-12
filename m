Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69733319FB2
	for <lists+linux-rdma@lfdr.de>; Fri, 12 Feb 2021 14:21:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230228AbhBLNT4 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 12 Feb 2021 08:19:56 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:2168 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S230489AbhBLNTy (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 12 Feb 2021 08:19:54 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 11CD1qeu172164
        for <linux-rdma@vger.kernel.org>; Fri, 12 Feb 2021 08:19:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=in-reply-to : subject :
 from : to : cc : date : mime-version : references :
 content-transfer-encoding : content-type : message-id; s=pp1;
 bh=qo/75+X3eGgseOqyZ1QryOmxdkT0lpRp0QqvYkFocaI=;
 b=Yehp1pBDNv92WQTgW63OvCfBq8WaKdguBTB4VElsKaOLLFNYcnbnmRVWVdC2Plh3LkaL
 LjF6a79CdWnBkmUkEysc3YpaglqoUPcDtdFrOT/hq+PT3BdONZ6X3BkU8YqHrXF5hhiS
 /TeBRU/2xXbr9Z5l/nvb4OcFThHDnYiALpfCHqlGrqUApeuCT2+6VYTn4B98ZNFUMvQr
 xF/5sacVCOC628sCbPb7ZsTYGF3u5rRUqRTVMIXyAJUZFPSKhBR0mVkjkp2e7TrNThp+
 lXrGpMf/ybhlnFtofLg+vpKPJm73T1Um38epIaxr2JEeYq3Aj/DgpPdU2tgQOoTUxtID Xw== 
Received: from smtp.notes.na.collabserv.com (smtp.notes.na.collabserv.com [192.155.248.73])
        by mx0b-001b2d01.pphosted.com with ESMTP id 36nt6s0s94-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-rdma@vger.kernel.org>; Fri, 12 Feb 2021 08:19:12 -0500
Received: from localhost
        by smtp.notes.na.collabserv.com with smtp.notes.na.collabserv.com ESMTP
        for <linux-rdma@vger.kernel.org> from <BMT@zurich.ibm.com>;
        Fri, 12 Feb 2021 13:19:11 -0000
Received: from us1a3-smtp06.a3.dal06.isc4sb.com (10.146.103.243)
        by smtp.notes.na.collabserv.com (10.106.227.90) with smtp.notes.na.collabserv.com ESMTP;
        Fri, 12 Feb 2021 13:19:09 -0000
Received: from us1a3-mail162.a3.dal06.isc4sb.com ([10.146.71.4])
          by us1a3-smtp06.a3.dal06.isc4sb.com
          with ESMTP id 2021021213190949-289270 ;
          Fri, 12 Feb 2021 13:19:09 +0000 
In-Reply-To: <4B1D8641-3971-409C-B730-012EDE4D3AEB@oracle.com>
Subject: Re: Re: directing soft iWARP traffic through a secure tunnel
From:   "Bernard Metzler" <BMT@zurich.ibm.com>
To:     "Chuck Lever" <chuck.lever@oracle.com>
Cc:     "linux-rdma" <linux-rdma@vger.kernel.org>,
        "Benjamin Coddington" <bcodding@redhat.com>
Date:   Fri, 12 Feb 2021 13:19:08 +0000
MIME-Version: 1.0
Sensitivity: 
Importance: Normal
X-Priority: 3 (Normal)
References: <4B1D8641-3971-409C-B730-012EDE4D3AEB@oracle.com>,<61EFD7EA-FA16-4AA1-B92F-0B0D4CC697AB@oracle.com>
 <OFE25AAD0A.3B8CE2E0-ON0025867A.0043F201-0025867A.00455111@notes.na.collabserv.com>
X-Mailer: IBM iNotes ($HaikuForm 1054.1) | IBM Domino Build
 SCN1812108_20180501T0841_FP130 January 13, 2021 at 14:04
X-LLNOutbound: False
X-Disclaimed: 34607
X-TNEFEvaluated: 1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
x-cbid: 21021213-8877-0000-0000-00000577231C
X-IBM-SpamModules-Scores: BY=0.05725; FL=0; FP=0; FZ=0; HX=0; KW=0; PH=0;
 SC=0.421684; ST=0; TS=0; UL=0; ISC=; MB=0.207974
X-IBM-SpamModules-Versions: BY=3.00014728; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000295; SDB=6.01506714; UDB=6.00813454; IPR=6.01289257;
 MB=3.00036113; MTD=3.00000008; XFM=3.00000015; UTC=2021-02-12 13:19:10
X-IBM-AV-DETECTION: SAVI=unsuspicious REMOTE=unsuspicious XFE=unused
X-IBM-AV-VERSION: SAVI=2021-02-12 06:52:53 - 6.00012296
x-cbparentid: 21021213-8878-0000-0000-0000F52F9033
Message-Id: <OFCA489C99.24705C66-ON0025867A.004929F2-0025867A.004929F9@notes.na.collabserv.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.737
 definitions=2021-02-12_04:2021-02-12,2021-02-12 signatures=0
X-Proofpoint-Spam-Reason: orgsafe
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

-----"Chuck Lever" <chuck.lever@oracle.com> wrote: -----

>To: "Bernard Metzler" <bmt@zurich.ibm.com>
>From: "Chuck Lever" <chuck.lever@oracle.com>
>Date: 02/12/2021 02:04PM
>Cc: "linux-rdma" <linux-rdma@vger.kernel.org>, "Benjamin Coddington"
><bcodding@redhat.com>
>Subject: [EXTERNAL] Re: directing soft iWARP traffic through a secure
>tunnel
>
>
>> On Feb 12, 2021, at 7:37 AM, Bernard Metzler <bmt@zurich.ibm.com>
>wrote:
>>=20
>> -----"Chuck Lever" <chuck.lever@oracle.com> wrote: -----
>>=20
>>> To: "linux-rdma" <linux-rdma@vger.kernel.org>
>>> From: "Chuck Lever" <chuck.lever@oracle.com>
>>> Date: 02/11/2021 08:38PM
>>> Cc: "Benjamin Coddington" <bcodding@redhat.com>
>>> Subject: [EXTERNAL] directing soft iWARP traffic through a secure
>>> tunnel
>>>=20
>>> Hi-
>>>=20
>>> This might sound crazy, but bear with me.
>>>=20
>>> The NFS community is starting to hold virtual interoperability
>>> testing
>>> events to replace our in-person events that are not feasible due
>to
>>> pandemic-related travel restrictions. I'm told other communities
>have
>>> started doing the same.
>>>=20
>>> The virtual event is being held on a private network that is set
>up
>>> using OpenVPN across a large geographical area. I attach my test
>>> systems to the VPN to access test systems run by others at other
>>> companies.
>>>=20
>>> We'd like to continue to include NFS/RDMA testing at these events.
>>> This means either RoCEv2 or iWARP, since obviously we can't create
>>> an ad hoc wide-area InfiniBand infrastructure.
>>>=20
>>> Because the VPN is operating over long distances, we've decided to
>>> start with iWARP. However, we are stumbling when it comes to
>>> directing
>>> the siw driver's traffic onto the tun0 device:
>>>=20
>>> [root@oracle-100 ~]# rdma link add siw0 type siw netdev tun0
>>> error: Invalid argument
>>> [root@oracle-100 ~]#
>>>=20
>>> Has anyone else tried to do this, and what was the approach? Or
>does
>>> siw not yet have this capability?
>>>=20
>>=20
>> Hi Chuck
>>=20
>> right. Attaching siw is currently restricted to some physical
>> device types. This now appears a useless limitation, since
>> it prevents its usage in the given setup, where it would
>> be just useful...
>> Relaxing that limitation is a rather simple code change in siw
>> - but that would not help you asap?
>>=20
>> In any case I'd be happy to help with a fix, but participants
>> would have to rebuild the siw module...probably no option?
>
>Participants bring code and build infrastructure. A patch now
>would be great, and we can provide you with Tested-by: !
>
>
How does this tunnel device look like? What does
ifconfig or ip show? Probably NOARP and no
HW address?

Or should I better setup a VPN client to your network
to see what is needed?

Best,
Bernard.

