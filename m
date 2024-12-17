Return-Path: <linux-rdma+bounces-6604-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBAB79F4E01
	for <lists+linux-rdma@lfdr.de>; Tue, 17 Dec 2024 15:40:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 04A4116757E
	for <lists+linux-rdma@lfdr.de>; Tue, 17 Dec 2024 14:40:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E23FC1F6664;
	Tue, 17 Dec 2024 14:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="L6Ki56XG";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="xpjAIck+"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B2731F239E;
	Tue, 17 Dec 2024 14:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734446420; cv=fail; b=uNCeSNrZz4mqNVA+mmM7AkvZsW8klkAnysomHEpZ65fERdFyIZm7s8p0yPYTUGBjww7l0V+Ta7vpAFuDdktngKMmaRVNuhtVzpQ5+qGTXAKgW+SEnBGZbdjtVIK1JfBWFPLWHpE9j5+7U3bKTjMK2c6eCKwBQUU3x8TXeoDuvaw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734446420; c=relaxed/simple;
	bh=AlqSc70vwAHSMQ80I9HqfpHwDncA1V85xvmRZWrfs44=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=TbaIP8mJmZJpg9ytN/52DAND6wj+3I4kYk+XCjvH/DImAgtAgVvAijOo39VkPxpSikWwtKtQmNDgmkTIDTdw91yCX29MoY1NmEEUr3GtLRvQr0u9YZ0xr7IZb5/0lPUBFnmp34FhWuHUme3PUGrlk9GKeN8uw3eVuU5X834Xr6I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=L6Ki56XG; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=xpjAIck+; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BHCu2iV031355;
	Tue, 17 Dec 2024 14:38:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=2cYHeZlceoT9qSzUq1vdCtGU+iZMM6uz47bls4Seu6U=; b=
	L6Ki56XGYJSuvASykZY0wiRqd63wYkeMXhCLmYOuth6Xmaikb1uP8pVQ0t/CWYpE
	1zrpfkvx82gaE5tPNH3XVuRrvfLrWeX7B+Q80mSvjcoCWmD5FHKAsg4JkoslKv2B
	pcVtXIk22mN9Gw5MuoD80LFRpGESf5UcE749OMz9vIaTLtbm36srVTf7IHmUsz6r
	EjbMg/rkhH4ZOEszuqeZeEECaCVE+756CrxzeLLrltAF0fv92PVfold6lwh3P2wp
	8UEFJpktKLsdPMdWTsPvsS8OHq2llpGGJxWH28up3sQ3p39FKhKDH4phYT6oJfm2
	3DxZz7DvN+Ulf5a2azf7ug==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43h0t2e75t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 17 Dec 2024 14:38:57 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4BHEaPvE032638;
	Tue, 17 Dec 2024 14:38:56 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2041.outbound.protection.outlook.com [104.47.70.41])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 43h0ferwkt-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 17 Dec 2024 14:38:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CYcWsir/qmY1ElLGAbIRPEuLWbMGzqaenzuIsk3GTr2LpRmoFsBx6v4mALLQ4nF+fvSOSFWpEgYmicO5AU9MXH7CmmaKYUs/ivY0gbMnlJXM52gyZGMAauIGNDSS6GI27psYydcXCKer23VCI3TZhoGK/MmTKqoi6RthI0swjv7TZqEkoFwT6hcx+VUMcVlIWmTXB4louDdGegZ4QTPnotJ7LK9Eo/wcXXdee7yAIHjDeeQ3tn2eN7B6LpJo4P84dpZEUT7piNSBHOqj5vg3fpP6AyCsEDcDSgrwe6v5pksl8tSf01eUffTOe/jqmgdg2g1LNGXnKklLNgugL36bDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2cYHeZlceoT9qSzUq1vdCtGU+iZMM6uz47bls4Seu6U=;
 b=ZtQpksYICaTXNv/HFeYP5uovhY+4mwKjhDWzEN/9JUV0fon0BUu0T6jE0RfoeNV1eXneCiXtxf8efx7gbgl0v7rnCoVBoJXrTSdMbOQ5E/zD2gGconnfLwIWgoertIYoZ+GYG1wKBbFkCQ3APFPv1qsCDub+uCi4Z5PogAE3KS3cghH2+6m0swVqP0wMlA2T3Cl4mlgSkGIBwPDT9ZGi8dzjT8zpVKLdIpScFdLjlENXk3xBcyUKRWf1GXBd+JrNYHF2/J2HdaOuQeL7cjNjLjq2yqQ+quGYgsxhS7ziMwKTss/z5i9erz38Z1wUdbhA/NNNN/plZJLHXixV0/5pOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2cYHeZlceoT9qSzUq1vdCtGU+iZMM6uz47bls4Seu6U=;
 b=xpjAIck+7WgrhC5BaXtjWYpBdL+sTLHXiVh1TlSu2eK1WdEO0/98gL8EZrYGoL/3cq0VejfsrtPG3f7RSFkDKvi20Ldh/pHWVMjcmez6GksvnYx3MSsZb6j+Jv4q+CdI1lzgg5MXUpAD1l5H0ApvH9tDDhwxCjOTo7apoJZZfuw=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by PH7PR10MB5830.namprd10.prod.outlook.com (2603:10b6:510:127::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.21; Tue, 17 Dec
 2024 14:38:50 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%7]) with mapi id 15.20.8272.005; Tue, 17 Dec 2024
 14:38:50 +0000
Message-ID: <c9d012bb-a411-4f39-b5ce-d39c7f19fa6b@oracle.com>
Date: Tue, 17 Dec 2024 09:38:40 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: Convert proto_ops::getname to sockaddr_storage
To: Kees Cook <kees@kernel.org>, Jakub Kicinski <kuba@kernel.org>
Cc: Cheng Xu <chengyou@linux.alibaba.com>,
        Kai Shen <kaishen@linux.alibaba.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>,
        Christian Benvenuti <benve@cisco.com>,
        Nelson Escobar <neescoba@cisco.com>,
        Bernard Metzler <bmt@zurich.ibm.com>,
        Karsten Keil <isdn@linux-pingi.de>,
        Michal Ostrowski
 <mostrows@earthlink.net>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
        Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
        Chaitanya Kulkarni <kch@nvidia.com>, Lee Duncan <lduncan@suse.com>,
        Chris Leech <cleech@redhat.com>,
        Mike Christie <michael.christie@oracle.com>,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Alexander Aring
 <aahringo@redhat.com>,
        David Teigland <teigland@redhat.com>,
        Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>,
        Mark Fasheh <mark@fasheh.com>, Joel Becker <jlbec@evilplan.org>,
        Joseph Qi <joseph.qi@linux.alibaba.com>,
        Namjae Jeon
 <linkinjeon@kernel.org>, Steve French <sfrench@samba.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Tom Talpey <tom@talpey.com>, Simon Horman <horms@kernel.org>,
        Jeff Layton <jlayton@kernel.org>, Neil Brown <neilb@suse.de>,
        Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>,
        David Ahern <dsahern@kernel.org>, Joerg Reuter <jreuter@yaina.de>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Oliver Hartkopp <socketcan@hartkopp.net>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Robin van der Gracht <robin@protonic.nl>,
        Oleksij Rempel <o.rempel@pengutronix.de>,
        Alexandra Winter <wintera@linux.ibm.com>,
        Thorsten Winkler <twinkler@linux.ibm.com>,
        James Chapman <jchapman@katalix.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        Remi Denis-Courmont <courmisch@gmail.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Allison Henderson <allison.henderson@oracle.com>,
        Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
        Xin Long <lucien.xin@gmail.com>, Wenjia Zhang <wenjia@linux.ibm.com>,
        Jan Karcher <jaka@linux.ibm.com>,
        "D. Wythe" <alibuda@linux.alibaba.com>,
        Tony Lu <tonylu@linux.alibaba.com>, Wen Gu <guwen@linux.alibaba.com>,
        Jon Maloy <jmaloy@redhat.com>, Ying Xue <ying.xue@windriver.com>,
        Stefano Garzarella <sgarzare@redhat.com>,
        Martin Schiller <ms@dev.tdt.de>,
        Kentaro Takeda <takedakn@nttdata.co.jp>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Guillaume Nault <gnault@redhat.com>,
        =?UTF-8?Q?Ahelenia_Ziemia=C5=84ska?= <nabijaczleweli@nabijaczleweli.xyz>,
        Andrew Morton <akpm@linux-foundation.org>,
        Wu Yunchuan <yunchuan@nfschina.com>,
        Max Gurtovoy <mgurtovoy@nvidia.com>,
        Maurizio Lombardi <mlombard@redhat.com>,
        David Howells
 <dhowells@redhat.com>,
        =?UTF-8?Q?Atte_Heikkil=C3=A4?=
 <atteh.mailbox@gmail.com>,
        Vincent Duvert <vincent.ldev@duvert.net>,
        Denis Kirjanov <kirjanov@gmail.com>,
        Lukas Bulwahn
 <lukas.bulwahn@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, Thomas Huth <thuth@redhat.com>,
        Andrew Waterman
 <waterman@eecs.berkeley.edu>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Andrej Shadura <andrew.shadura@collabora.co.uk>,
        Ying Hsu <yinghsu@chromium.org>, Kuniyuki Iwashima <kuniyu@amazon.com>,
        Tom Parkin <tparkin@katalix.com>, Jason Xing <kernelxing@tencent.com>,
        Dan Carpenter <error27@gmail.com>, Hyunwoo Kim <v4bel@theori.io>,
        Bernard Pidoux <f6bvp@free.fr>, Sangsoo Lee <constant.lee@samsung.com>,
        Doug Brown <doug@schmorgal.com>,
        Ignat Korchagin <ignat@cloudflare.com>, Gou Hao <gouhao@uniontech.com>,
        Mina Almasry <almasrymina@google.com>,
        Abhishek Chauhan <quic_abchauha@quicinc.com>,
        Yajun Deng <yajun.deng@linux.dev>, Michal Luczaj <mhal@rbox.co>,
        Jiri Pirko <jiri@resnulli.us>, syzbot <syzkaller@googlegroups.com>,
        linux-kernel@vger.kernel.org, kernel@pengutronix.de,
        linux-rdma@vger.kernel.org, netdev@vger.kernel.org,
        linux-nvme@lists.infradead.org, open-iscsi@googlegroups.com,
        linux-scsi@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        target-devel@vger.kernel.org, gfs2@lists.linux.dev,
        linux-nfs@vger.kernel.org, ocfs2-devel@lists.linux.dev,
        linux-cifs@vger.kernel.org, linux-hams@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, linux-can@vger.kernel.org,
        linux-s390@vger.kernel.org, rds-devel@oss.oracle.com,
        linux-sctp@vger.kernel.org, tipc-discussion@lists.sourceforge.net,
        virtualization@lists.linux.dev, linux-x25@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        syzbot+d7ce59b06b3eb14fd218@syzkaller.appspotmail.com,
        linux-hardening@vger.kernel.org
References: <20241217023417.work.145-kees@kernel.org>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20241217023417.work.145-kees@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0392.namprd03.prod.outlook.com
 (2603:10b6:610:11b::31) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|PH7PR10MB5830:EE_
X-MS-Office365-Filtering-Correlation-Id: 5fed875f-0eda-452d-188f-08dd1ea8859a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|1800799024|7053199007|41080700001;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?alNYS2JUNEhPdllGaGdaWXN2bHo0ekFjd0VpcUU5b29GczNEK0s2aU5FQkFq?=
 =?utf-8?B?a2ZUMGgzWnJRYllXTldBazdFeWsyMDRRSCtHR0hCN3lpSGJlUFFlZVJnNmFm?=
 =?utf-8?B?OEh2U1loWlEyZzVUZC9rQWdRZ1VRTm9DK25oVXRKcFdpSk9KRnZMZ3VNRm80?=
 =?utf-8?B?UmkwYy9mQjZldXU5ZmlLRGQycmJ4emk5NWthVUlrL1pYamF0a0IvVHhTazli?=
 =?utf-8?B?b1hYZEFES3JIblpYSVdmY1plNTdJZEtGUHRSeHZsaHRocXF2RURjSUJSZmNJ?=
 =?utf-8?B?R2JHUUMvdDJpeFRzYmRUMkdtaUtuNUkzMFVsdHQwMnk1ZTdDV1lWR054T3Zm?=
 =?utf-8?B?M0dkeFNCZXJmZS9zYkFNUEpWNXNMdEd0bXZZTGdlQS81NWxkK3ZnQTlUcmtv?=
 =?utf-8?B?amVuaTh5Y0FHR0dUWlFkM3pyaGFkbHN1SEhPTXEwbExhVFN5cE13bGoyZ1hC?=
 =?utf-8?B?aGVyR1AxZjVBcy9wUzI2SWdXWmlnV1VJWTJ1cENicHluTDd6dUY1N3dTZzZq?=
 =?utf-8?B?UTBEeWJGc3Z5RG1CbUlrdUJnRHpONmlqcWhiZ0dCTnh6bFlSbDRuWWZLZ3ZB?=
 =?utf-8?B?azRVUGZJdDJKMHpVWlVKMGpYeUdTTTVmMWdLVC9laGFBSXRkMkU2aGtUbVM4?=
 =?utf-8?B?eml0RGtWaUV0eC9WK25QMWx6T0JoRHBoZVVIeFVZTG9EaXY0ZnRhYXFtdkUy?=
 =?utf-8?B?VmpabGhBK1RGc2dycnBUU1dpVzVMamNMdUYrREFDQVg0Qm0vWThoT2pPcUxs?=
 =?utf-8?B?bThIT0ZtczFtcmVLeVFpSUM4d2FnQkpaSUloTlZXc1FGTXNqaHF5OWliRmIy?=
 =?utf-8?B?dzlpKzcxek1pd3Z5RmVCMjRFUkJHSG9HdytjWFpxYWVzbFM2Z3hxTTFOSzJn?=
 =?utf-8?B?V0VqL2dTQ2xVYzBiWGlUSy8wdWx2Tkk3cTI2dHo5Q29pZ0hFTzdCVklLaXlU?=
 =?utf-8?B?VXlSRzNNU2VYdHRMVGxjMWFhUFova2R5cDJaYnEvQnpDenhVWmtFSVZ2MElE?=
 =?utf-8?B?eERmRW1raG5HOEg5dTJHOWFKMG1NalU4ZUlVVjNMN1pDem5FVWxTVkYyLzZ0?=
 =?utf-8?B?MDhvalR6ODZIRkxoVVBzWkpvQUlSeHZqWTYrUFhjUXZWTHY4RzluTG9PQXJq?=
 =?utf-8?B?TEllWFlES2VNaDZtNUU4S2JrMUpSY2NpWlpFWDNMWmgydlpnTC9wNXluNStS?=
 =?utf-8?B?QXJVa1I2RVd0dURWcjBzNmd6UU1lTHJELys0b0xsK0N1eGVQZEh0V29MWUt6?=
 =?utf-8?B?R0tmdDlmMVpsVWx5WG9hd1FHYkR6ejQ4OVB2bnVPSk1xZllIRWxpVFVEdDZW?=
 =?utf-8?B?eXNBUUh6OVUvUFE5dmRER1RzTE5xWGxSaVNEWG9vZ0pOS1UxT3hWNk10RjRI?=
 =?utf-8?B?SFhIeDVjYS8yckFyY284TEh6QklZNVVZNHFHeFVyZHZNS25kNWJtSE9MOUhT?=
 =?utf-8?B?QzVUSS9RWU9waEoxczBaU1VRUEhIcGVESkRaaHViaE5yU0tORUp6TldONldS?=
 =?utf-8?B?ZUY3dzJhYzJJS3BORkJ1WVFsUldDS0xBQThORnBFbkp4NWVDcFprSmE5clFF?=
 =?utf-8?B?emI0VE9jS09QbmRsMnZ0Zm1laTl3czBuakh6dE9VZm55MnFVeFdFYzFsajU3?=
 =?utf-8?B?L1ozdVp4N3JiSEZENmxLalJmODhUQTVydGZxWEFkdUJZWEVmUHRUOGdhVUQ1?=
 =?utf-8?B?QUxtZis5eDAxTUlKMUx2cVE2Rkx0TjdVQXVvb2lGN3dmUzZpVFlvU1diRGlQ?=
 =?utf-8?B?SllmQm5GYlU3bjVkYTZkNFRvcmFFc2tKTVVMS284Y1Y3RXE4ZmY1czMvQU1H?=
 =?utf-8?B?ZjdxbDQ5ZTA0VFdJSDE5QkRtWURaSUVqcDhvSGt1WURiTjlTcU5wTkZ6anRS?=
 =?utf-8?B?dUhOc0VOdE9KYjc5S2owQnlObUpPUUZGeEhhVlJNRlNJMW9mY1ovZi9obHBO?=
 =?utf-8?Q?Qgyvn6UIdoN/miagVy4h/0Pj9+0B0KsX?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(7053199007)(41080700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?U3hDQXhpbkdkN3c2ekR1bmRGTlBQci9HbTR3RTdiUXVyLzdVRE1USTQvNlUx?=
 =?utf-8?B?anQxZ0FPOGlsZC9kS0w0dFlJS3VHZmUrUW1NakF3Vjl3U0JWSjl2V2YrMGhn?=
 =?utf-8?B?bFBHbTgxa1JJWkxnWmY0Um5xc0xvVUdBVjZNdEF2aGY4UDJDOFJkMU9KWTFW?=
 =?utf-8?B?ZG1TcEt1NEVCdkdiUWVDT3hreStsa2swcFdDVWpTajJqc0tLTUdjeTEvM0pN?=
 =?utf-8?B?cXN1MTZXTnlpb2hpTHNjazdtWHJBaVQzTDNRS3dMeWVnV2hmRlR4U0ZINmth?=
 =?utf-8?B?S3FsbXc2dVJ5TXJPdEZSMVBQbnlXMXRHbGtUa2RPdTFWRzd0Q1RsNEN2Yjgv?=
 =?utf-8?B?SHlqeGh6S1paWGd1S2cwbzB3bjI3Tlh5aWhFMjBXL25yQjZpdzBXajB1dlov?=
 =?utf-8?B?MUJMTXA1c1V4NFZDNWxiMUwrNmk1cEo0T0ZyQzNWcm5abXZRZVRHaDUyTU4z?=
 =?utf-8?B?akhoZU1IcGVFcXF5RTJlMXRJSXZUUDJhK0c3U2NtVFEyVGpNS1NzZHhucnZD?=
 =?utf-8?B?RGFxazdyeDNwRlk2bXp0WXpuNVk1THRRK2RpUGt6eEpuNEZ1OWVwWFpRRm1p?=
 =?utf-8?B?TWtzZmkwa1JRbU5FMzZVdmxDVisxWWFuVWtGSGtpRDl0OVB5UGt2NkFkcEI3?=
 =?utf-8?B?OVlCcHpCN2IrakFXZFNhSjFaZ2NXbExEK0RaZDNhUFoyL1FVT3ZEeGtzdzZL?=
 =?utf-8?B?aStlVnY5OTQ0NUhySVdvR2xUSWY0SDAwbklDSFppdkoyMjJRTkRuZUpzYXJk?=
 =?utf-8?B?eWsyYjBaK1ZGbnZrd0h0VkdvQnlyTnZIVEVBRkJmdENsbTZkbmdVdytIUWh3?=
 =?utf-8?B?MTcyUEdyNWE5MGtkS2VvSjBmR2JzUml6aHJTdE1BYXBUbGd6YUE3Y25QMVRn?=
 =?utf-8?B?ZU5hQmhNbzVzQjhUdURmSEV3dThKM2NBMVMwdHRTUUdZUEx3MmZnMjhpT0k4?=
 =?utf-8?B?elB1UitMMnFMMW5NSFkrKzFQUldIcy9UaytOS1VpY2V0UUxYdmRHalovR3lO?=
 =?utf-8?B?ck93Vm5nUVArejFBalVpc2F6ZW9iVVA3cnhCQ29GQUZ4czVCbGdxSTlNMVhu?=
 =?utf-8?B?bE5CNVNaYVdnSnVlUnhTY2RpOUV5QnBHT1BRUmk3MFR4VDBiS3ZrTzVpTFVX?=
 =?utf-8?B?ZnU4ckNKTHBBVjUxQ3dSUVRHT0YwUWRiSVBxYTdZakxhU3QydnNJbjVqNmNn?=
 =?utf-8?B?NlBZNUl4cm1YZW9yOGVDZ0hPWGlzZjFKdUJKSFBlZzhxYXRQSXhZeXcyWGJY?=
 =?utf-8?B?NUh1RUFtZ2x6SVlOMkhDRmllR1BlVXdweTV6c291ZVRCcWMwckpqM2dldU9F?=
 =?utf-8?B?OTEwUnNkR0hLUGNSeUtrSERFU2ZQUTA3ak54Yzh1WS9rUTM1UUpIN0U4S096?=
 =?utf-8?B?Vk5Sd2hMc0JNZzE4emQ1RUdmeGNWT2owazZ6aUJ4OFFtd3V4TFFRcE9lRWpK?=
 =?utf-8?B?SXBHejRvRFRHVUVxQ09tSlM3Mnowd2tETU5taU5zNUNTcnJ3N3RTcUxLNndG?=
 =?utf-8?B?MlJUV3lSQm5SOTJQQUozQUlFTXQ1dEZBNVh1MkxNZ0lNVVF5WkdUSEVDaWtX?=
 =?utf-8?B?SVJlYVJVZnZib2ZlUzQvNjV2dFNjTXliVE44UmFXSzNaT1FEd1paakRJa3JW?=
 =?utf-8?B?Mm1CUFo3cjRFbnkzVHdRaXZ2NEVRZE1hS1BOWjVHZTV2QnNXMlhwT2xXM211?=
 =?utf-8?B?T2liT0NEaHlGS2crNDgzbUN5QStIMmZid3FUK21kWnNBbzJoS0VpUDRvaFEw?=
 =?utf-8?B?MFNMeHhHc0hTMTZ0THNML2R3TWVZQnlmYU5HdjFxZE00S2k0ZEU4cUZkODZn?=
 =?utf-8?B?TGRXcUJkSXdGcFZxZlFMWDZxaWVEbjNGeVh2K3VNWFZzZHBwQ01Da3pSSCtH?=
 =?utf-8?B?MmI4TzVPdWlEYXM0NkJmeDdMWjBCSTIxR3Qva25MSCt5Qmw3NTcwOGdDTXRU?=
 =?utf-8?B?UDJJUmxqR1BnT1dSUUkvS0c4SmQ5RjJJckYxajlzbzNNcTVjaFVVNmJVMElw?=
 =?utf-8?B?U0FkTStIUFFJYndBUFEySlNUdG5kYkV0L3FFWGsrR0JWQ0JzS0RLOHE0WWtM?=
 =?utf-8?B?VTZSKzNsOVhBMFBlVy9NYWhuT3Y1SFl4NnVMQ0ZlSnVJYisxMzFLMGNIUG51?=
 =?utf-8?Q?h77oELC4yPYwOMJTv6CDGbTd8?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	gj9llAYkUC+576a/pBBuqV8DYK4YQ1/zSxmM0YKZn2zO3VnCcoXmFUz/NlE9SkVXrD/hyaqzlWFDm51b/i+2MfTW7QV9LAg1IXRCMR/7w505IWeiWC8QKew0K/hL/A0gEPZKGBqG0HINVaH9fF0zyULwaur/eT36JFAUwtuDlqm0D7Oc6K2bkEzG9/Y2eBH9F4aw4uEY0350Pim1xcQm/3nox5NIsEFR4tP1j95qsWcSWqdnHMnKhHqbzMbvpbeeXQ7mTzTMODY+3SHm49NrPRSI+U3yz+rEVFWzmjp3rKbrT1Xtu9Wfu9pU05SFtVDP2eA55TJxpmwCfilIYNUkfxlxIc6evHXXxUgtYwM/RqhMcdiKvEU38jeO4O3jNLDd8y3CetJk4QKxtJ3DezO0wcr6AGEYK852pKLMqoOF90KBNr+LTMlte+c+/GSw8JwXff2ZWolrbPviYblsmfZ1Sggugy5qeCIPNTrMZeNl6s8L+EjlCpH7LT1wv1w4Gumrq9n3C/X4h/5hvE30mPbOJWfXomJFiLuGcR3UUyUdUijcBIbgK8TguA2pdF+x0rehbpzAaTaeb/WvIuR8PodBgq5IqX0NfrFQIr9LWMk3Ltc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fed875f-0eda-452d-188f-08dd1ea8859a
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2024 14:38:50.4472
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D4ejlxxnBvwqYQIHlHVRZqw/DglCMVntVBnDkO0lSSEXjodX0V1yVKjMiNg869s7aEJ90UguvL48ifh/8fyb1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB5830
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-17_08,2024-12-17_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 suspectscore=0
 adultscore=0 bulkscore=0 mlxscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2412170116
X-Proofpoint-ORIG-GUID: fujksIyXgr8lyrqOAZis8O6fMsesRgmq
X-Proofpoint-GUID: fujksIyXgr8lyrqOAZis8O6fMsesRgmq

On 12/16/24 9:34 PM, Kees Cook wrote:
> The proto_ops::getname callback was long ago backed by sockaddr_storage,
> but the replacement of it for sockaddr was never done. Plumb it through
> all the getname() callbacks, adjust prototypes, and fix casts.
> 
> There are a few cases where the backing object is _not_ a sockaddr_storage
> and converting it looks painful. In those cases, they use a cast to
> struct sockaddr_storage. They appear well bounds-checked, so the risk
> is no worse that we have currently.
> 
> Other casts to sockaddr are removed, though to avoid spilling this
> change into BPF (which becomes a much larger set of changes), cast the
> sockaddr_storage instances there to sockaddr for the time being.
> 
> In theory this could be split up into per-caller patches that add more
> casts that all later get removed, but it seemed like there are few
> enough callers that it seems feasible to do this in a single patch. Most
> conversions are mechanical, so review should be fairly easy. (Famous
> last words.)
> 
> Signed-off-by: Kees Cook <kees@kernel.org>
> ---
>   drivers/infiniband/hw/erdma/erdma_cm.h        |  4 +-
>   drivers/infiniband/hw/usnic/usnic_transport.c | 16 +++---
>   drivers/infiniband/sw/siw/siw_cm.h            |  4 +-
>   drivers/isdn/mISDN/socket.c                   |  2 +-
>   drivers/net/ppp/pppoe.c                       |  4 +-
>   drivers/net/ppp/pptp.c                        |  4 +-
>   drivers/nvme/host/tcp.c                       |  2 +-
>   drivers/nvme/target/tcp.c                     |  6 +--
>   drivers/scsi/iscsi_tcp.c                      | 18 +++----
>   drivers/soc/qcom/qmi_interface.c              |  2 +-
>   drivers/target/iscsi/iscsi_target_login.c     | 51 +++++++++----------
>   fs/dlm/lowcomms.c                             |  2 +-
>   fs/nfs/nfs4client.c                           |  4 +-
>   fs/ocfs2/cluster/tcp.c                        | 26 +++++-----
>   fs/smb/server/connection.h                    |  2 +-
>   fs/smb/server/mgmt/tree_connect.c             |  2 +-
>   fs/smb/server/transport_ipc.c                 |  4 +-
>   fs/smb/server/transport_ipc.h                 |  4 +-
>   fs/smb/server/transport_tcp.c                 |  6 +--
>   include/linux/net.h                           |  6 +--
>   include/linux/sunrpc/clnt.h                   |  4 +-
>   include/net/inet_common.h                     |  2 +-
>   include/net/ipv6.h                            |  2 +-
>   include/net/sock.h                            |  3 +-
>   net/appletalk/ddp.c                           |  2 +-
>   net/atm/pvc.c                                 |  2 +-
>   net/atm/svc.c                                 |  2 +-
>   net/ax25/af_ax25.c                            |  4 +-
>   net/bluetooth/hci_sock.c                      |  2 +-
>   net/bluetooth/iso.c                           |  6 +--
>   net/bluetooth/l2cap_sock.c                    |  6 +--
>   net/bluetooth/rfcomm/sock.c                   |  3 +-
>   net/bluetooth/sco.c                           |  6 +--
>   net/can/isotp.c                               |  3 +-
>   net/can/j1939/socket.c                        |  2 +-
>   net/can/raw.c                                 |  2 +-
>   net/core/sock.c                               |  4 +-
>   net/ipv4/af_inet.c                            |  2 +-
>   net/ipv6/af_inet6.c                           |  2 +-
>   net/iucv/af_iucv.c                            |  6 +--
>   net/l2tp/l2tp_ip.c                            |  2 +-
>   net/l2tp/l2tp_ip6.c                           |  2 +-
>   net/l2tp/l2tp_ppp.c                           |  2 +-
>   net/llc/af_llc.c                              |  2 +-
>   net/netlink/af_netlink.c                      |  4 +-
>   net/netrom/af_netrom.c                        |  4 +-
>   net/nfc/llcp_sock.c                           |  4 +-
>   net/packet/af_packet.c                        | 15 +++---
>   net/phonet/socket.c                           | 10 ++--
>   net/qrtr/af_qrtr.c                            |  2 +-
>   net/qrtr/ns.c                                 |  2 +-
>   net/rds/af_rds.c                              |  2 +-
>   net/rose/af_rose.c                            |  4 +-
>   net/sctp/ipv6.c                               |  2 +-
>   net/smc/af_smc.c                              |  2 +-
>   net/smc/smc.h                                 |  2 +-
>   net/smc/smc_clc.c                             |  2 +-
>   net/socket.c                                  | 10 ++--
>   net/sunrpc/clnt.c                             |  9 ++--
>   net/sunrpc/svcsock.c                          |  8 +--
>   net/sunrpc/xprtsock.c                         |  4 +-
>   net/tipc/socket.c                             |  2 +-
>   net/unix/af_unix.c                            |  9 ++--
>   net/vmw_vsock/af_vsock.c                      |  2 +-
>   net/x25/af_x25.c                              |  2 +-
>   security/tomoyo/network.c                     |  3 +-
>   66 files changed, 173 insertions(+), 173 deletions(-)
> 
> diff --git a/drivers/infiniband/hw/erdma/erdma_cm.h b/drivers/infiniband/hw/erdma/erdma_cm.h
> index a26d80770188..4e46ba491d5c 100644
> --- a/drivers/infiniband/hw/erdma/erdma_cm.h
> +++ b/drivers/infiniband/hw/erdma/erdma_cm.h
> @@ -141,12 +141,12 @@ struct erdma_cm_work {
>   
>   static inline int getname_peer(struct socket *s, struct sockaddr_storage *a)
>   {
> -	return s->ops->getname(s, (struct sockaddr *)a, 1);
> +	return s->ops->getname(s, a, 1);
>   }
>   
>   static inline int getname_local(struct socket *s, struct sockaddr_storage *a)
>   {
> -	return s->ops->getname(s, (struct sockaddr *)a, 0);
> +	return s->ops->getname(s, a, 0);
>   }
>   
>   int erdma_connect(struct iw_cm_id *id, struct iw_cm_conn_param *param);
> diff --git a/drivers/infiniband/hw/usnic/usnic_transport.c b/drivers/infiniband/hw/usnic/usnic_transport.c
> index dc37066900a5..7c38abc25671 100644
> --- a/drivers/infiniband/hw/usnic/usnic_transport.c
> +++ b/drivers/infiniband/hw/usnic/usnic_transport.c
> @@ -174,24 +174,24 @@ int usnic_transport_sock_get_addr(struct socket *sock, int *proto,
>   					uint32_t *addr, uint16_t *port)
>   {
>   	int err;
> -	struct sockaddr_in sock_addr;
> +	union {
> +		struct sockaddr_storage storage;
> +		struct sockaddr_in sock_addr;
> +	} u;
>   
> -	err = sock->ops->getname(sock,
> -				(struct sockaddr *)&sock_addr,
> -				0);
> +	err = sock->ops->getname(sock, &u.storage, 0);
>   	if (err < 0)
>   		return err;
>   
> -	if (sock_addr.sin_family != AF_INET)
> +	if (u.sock_addr.sin_family != AF_INET)
>   		return -EINVAL;
>   
>   	if (proto)
>   		*proto = sock->sk->sk_protocol;
>   	if (port)
> -		*port = ntohs(((struct sockaddr_in *)&sock_addr)->sin_port);
> +		*port = ntohs(u.sock_addr.sin_port);
>   	if (addr)
> -		*addr = ntohl(((struct sockaddr_in *)
> -					&sock_addr)->sin_addr.s_addr);
> +		*addr = ntohl(u.sock_addr.sin_addr.s_addr);
>   
>   	return 0;
>   }
> diff --git a/drivers/infiniband/sw/siw/siw_cm.h b/drivers/infiniband/sw/siw/siw_cm.h
> index 7011c8a8ee7b..804559be83d4 100644
> --- a/drivers/infiniband/sw/siw/siw_cm.h
> +++ b/drivers/infiniband/sw/siw/siw_cm.h
> @@ -94,12 +94,12 @@ struct siw_cm_work {
>   
>   static inline int getname_peer(struct socket *s, struct sockaddr_storage *a)
>   {
> -	return s->ops->getname(s, (struct sockaddr *)a, 1);
> +	return s->ops->getname(s, a, 1);
>   }
>   
>   static inline int getname_local(struct socket *s, struct sockaddr_storage *a)
>   {
> -	return s->ops->getname(s, (struct sockaddr *)a, 0);
> +	return s->ops->getname(s, a, 0);
>   }
>   
>   static inline int ksock_recv(struct socket *sock, char *buf, size_t size,
> diff --git a/drivers/isdn/mISDN/socket.c b/drivers/isdn/mISDN/socket.c
> index b215b28cad7b..2a3bcbf6d15b 100644
> --- a/drivers/isdn/mISDN/socket.c
> +++ b/drivers/isdn/mISDN/socket.c
> @@ -549,7 +549,7 @@ data_sock_bind(struct socket *sock, struct sockaddr *addr, int addr_len)
>   }
>   
>   static int
> -data_sock_getname(struct socket *sock, struct sockaddr *addr,
> +data_sock_getname(struct socket *sock, struct sockaddr_storage *addr,
>   		  int peer)
>   {
>   	struct sockaddr_mISDN	*maddr = (struct sockaddr_mISDN *) addr;
> diff --git a/drivers/net/ppp/pppoe.c b/drivers/net/ppp/pppoe.c
> index 2ea4f4890d23..139def6a7128 100644
> --- a/drivers/net/ppp/pppoe.c
> +++ b/drivers/net/ppp/pppoe.c
> @@ -717,8 +717,8 @@ static int pppoe_connect(struct socket *sock, struct sockaddr *uservaddr,
>   	goto end;
>   }
>   
> -static int pppoe_getname(struct socket *sock, struct sockaddr *uaddr,
> -		  int peer)
> +static int pppoe_getname(struct socket *sock, struct sockaddr_storage *uaddr,
> +			 int peer)
>   {
>   	int len = sizeof(struct sockaddr_pppox);
>   	struct sockaddr_pppox sp;
> diff --git a/drivers/net/ppp/pptp.c b/drivers/net/ppp/pptp.c
> index 689687bd2574..6d090008a34e 100644
> --- a/drivers/net/ppp/pptp.c
> +++ b/drivers/net/ppp/pptp.c
> @@ -479,8 +479,8 @@ static int pptp_connect(struct socket *sock, struct sockaddr *uservaddr,
>   	return error;
>   }
>   
> -static int pptp_getname(struct socket *sock, struct sockaddr *uaddr,
> -	int peer)
> +static int pptp_getname(struct socket *sock, struct sockaddr_storage *uaddr,
> +			int peer)
>   {
>   	int len = sizeof(struct sockaddr_pppox);
>   	struct sockaddr_pppox sp;
> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
> index 28c76a3e1bd2..06853bf1ee8c 100644
> --- a/drivers/nvme/host/tcp.c
> +++ b/drivers/nvme/host/tcp.c
> @@ -2642,7 +2642,7 @@ static int nvme_tcp_get_address(struct nvme_ctrl *ctrl, char *buf, int size)
>   
>   	mutex_lock(&queue->queue_lock);
>   
> -	ret = kernel_getsockname(queue->sock, (struct sockaddr *)&src_addr);
> +	ret = kernel_getsockname(queue->sock, &src_addr);
>   	if (ret > 0) {
>   		if (len > 0)
>   			len--; /* strip trailing newline */
> diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
> index df24244fb820..87324c723ed4 100644
> --- a/drivers/nvme/target/tcp.c
> +++ b/drivers/nvme/target/tcp.c
> @@ -1689,13 +1689,11 @@ static int nvmet_tcp_set_queue_sock(struct nvmet_tcp_queue *queue)
>   	struct inet_sock *inet = inet_sk(sock->sk);
>   	int ret;
>   
> -	ret = kernel_getsockname(sock,
> -		(struct sockaddr *)&queue->sockaddr);
> +	ret = kernel_getsockname(sock, &queue->sockaddr);
>   	if (ret < 0)
>   		return ret;
>   
> -	ret = kernel_getpeername(sock,
> -		(struct sockaddr *)&queue->sockaddr_peer);
> +	ret = kernel_getpeername(sock, &queue->sockaddr_peer);
>   	if (ret < 0)
>   		return ret;
>   
> diff --git a/drivers/scsi/iscsi_tcp.c b/drivers/scsi/iscsi_tcp.c
> index c708e1059638..0a457f8a5062 100644
> --- a/drivers/scsi/iscsi_tcp.c
> +++ b/drivers/scsi/iscsi_tcp.c
> @@ -794,7 +794,7 @@ static int iscsi_sw_tcp_conn_get_param(struct iscsi_cls_conn *cls_conn,
>   	struct iscsi_conn *conn = cls_conn->dd_data;
>   	struct iscsi_sw_tcp_conn *tcp_sw_conn;
>   	struct iscsi_tcp_conn *tcp_conn;
> -	struct sockaddr_in6 addr;
> +	struct sockaddr_storage addr;
>   	struct socket *sock;
>   	int rc;
>   
> @@ -825,19 +825,16 @@ static int iscsi_sw_tcp_conn_get_param(struct iscsi_cls_conn *cls_conn,
>   		}
>   
>   		if (param == ISCSI_PARAM_LOCAL_PORT)
> -			rc = kernel_getsockname(sock,
> -						(struct sockaddr *)&addr);
> +			rc = kernel_getsockname(sock, &addr);
>   		else
> -			rc = kernel_getpeername(sock,
> -						(struct sockaddr *)&addr);
> +			rc = kernel_getpeername(sock, &addr);
>   sock_unlock:
>   		mutex_unlock(&tcp_sw_conn->sock_lock);
>   		iscsi_put_conn(conn->cls_conn);
>   		if (rc < 0)
>   			return rc;
>   
> -		return iscsi_conn_get_addr_param((struct sockaddr_storage *)
> -						 &addr, param, buf);
> +		return iscsi_conn_get_addr_param(&addr, param, buf);
>   	default:
>   		return iscsi_conn_get_param(cls_conn, param, buf);
>   	}
> @@ -853,7 +850,7 @@ static int iscsi_sw_tcp_host_get_param(struct Scsi_Host *shost,
>   	struct iscsi_conn *conn;
>   	struct iscsi_tcp_conn *tcp_conn;
>   	struct iscsi_sw_tcp_conn *tcp_sw_conn;
> -	struct sockaddr_in6 addr;
> +	struct sockaddr_storage addr;
>   	struct socket *sock;
>   	int rc;
>   
> @@ -883,14 +880,13 @@ static int iscsi_sw_tcp_host_get_param(struct Scsi_Host *shost,
>   		if (!sock)
>   			rc = -ENOTCONN;
>   		else
> -			rc = kernel_getsockname(sock, (struct sockaddr *)&addr);
> +			rc = kernel_getsockname(sock, &addr);
>   		mutex_unlock(&tcp_sw_conn->sock_lock);
>   		iscsi_put_conn(conn->cls_conn);
>   		if (rc < 0)
>   			return rc;
>   
> -		return iscsi_conn_get_addr_param((struct sockaddr_storage *)
> -						 &addr,
> +		return iscsi_conn_get_addr_param(&addr,
>   						 (enum iscsi_param)param, buf);
>   	default:
>   		return iscsi_host_get_param(shost, param, buf);
> diff --git a/drivers/soc/qcom/qmi_interface.c b/drivers/soc/qcom/qmi_interface.c
> index bc6d6379d8b1..977cdf0f6598 100644
> --- a/drivers/soc/qcom/qmi_interface.c
> +++ b/drivers/soc/qcom/qmi_interface.c
> @@ -593,7 +593,7 @@ static struct socket *qmi_sock_create(struct qmi_handle *qmi,
>   	if (ret < 0)
>   		return ERR_PTR(ret);
>   
> -	ret = kernel_getsockname(sock, (struct sockaddr *)sq);
> +	ret = kernel_getsockname(sock, (struct sockaddr_storage *)sq);
>   	if (ret < 0) {
>   		sock_release(sock);
>   		return ERR_PTR(ret);
> diff --git a/drivers/target/iscsi/iscsi_target_login.c b/drivers/target/iscsi/iscsi_target_login.c
> index 90b870f234f0..9fcbfba43035 100644
> --- a/drivers/target/iscsi/iscsi_target_login.c
> +++ b/drivers/target/iscsi/iscsi_target_login.c
> @@ -907,8 +907,11 @@ int iscsi_target_setup_login_socket(
>   int iscsit_accept_np(struct iscsi_np *np, struct iscsit_conn *conn)
>   {
>   	struct socket *new_sock, *sock = np->np_socket;
> -	struct sockaddr_in sock_in;
> -	struct sockaddr_in6 sock_in6;
> +	union {
> +		struct sockaddr_storage storage;
> +		struct sockaddr_in sock_in;
> +		struct sockaddr_in6 sock_in6;
> +	} u;
>   	int rc;
>   
>   	rc = kernel_accept(sock, &new_sock, 0);
> @@ -919,47 +922,43 @@ int iscsit_accept_np(struct iscsi_np *np, struct iscsit_conn *conn)
>   	conn->login_family = np->np_sockaddr.ss_family;
>   
>   	if (np->np_sockaddr.ss_family == AF_INET6) {
> -		memset(&sock_in6, 0, sizeof(struct sockaddr_in6));
> +		memset(&u.sock_in6, 0, sizeof(struct sockaddr_in6));
>   
> -		rc = conn->sock->ops->getname(conn->sock,
> -				(struct sockaddr *)&sock_in6, 1);
> +		rc = conn->sock->ops->getname(conn->sock, &u.storage, 1);
>   		if (rc >= 0) {
> -			if (!ipv6_addr_v4mapped(&sock_in6.sin6_addr)) {
> -				memcpy(&conn->login_sockaddr, &sock_in6, sizeof(sock_in6));
> +			if (!ipv6_addr_v4mapped(&u.sock_in6.sin6_addr)) {
> +				memcpy(&conn->login_sockaddr, &u.sock_in6, sizeof(u.sock_in6));
>   			} else {
>   				/* Pretend to be an ipv4 socket */
> -				sock_in.sin_family = AF_INET;
> -				sock_in.sin_port = sock_in6.sin6_port;
> -				memcpy(&sock_in.sin_addr, &sock_in6.sin6_addr.s6_addr32[3], 4);
> -				memcpy(&conn->login_sockaddr, &sock_in, sizeof(sock_in));
> +				u.sock_in.sin_family = AF_INET;
> +				u.sock_in.sin_port = u.sock_in6.sin6_port;
> +				memcpy(&u.sock_in.sin_addr, &u.sock_in6.sin6_addr.s6_addr32[3], 4);
> +				memcpy(&conn->login_sockaddr, &u.sock_in, sizeof(u.sock_in));
>   			}
>   		}
>   
> -		rc = conn->sock->ops->getname(conn->sock,
> -				(struct sockaddr *)&sock_in6, 0);
> +		rc = conn->sock->ops->getname(conn->sock, &u.storage, 0);
>   		if (rc >= 0) {
> -			if (!ipv6_addr_v4mapped(&sock_in6.sin6_addr)) {
> -				memcpy(&conn->local_sockaddr, &sock_in6, sizeof(sock_in6));
> +			if (!ipv6_addr_v4mapped(&u.sock_in6.sin6_addr)) {
> +				memcpy(&conn->local_sockaddr, &u.sock_in6, sizeof(u.sock_in6));
>   			} else {
>   				/* Pretend to be an ipv4 socket */
> -				sock_in.sin_family = AF_INET;
> -				sock_in.sin_port = sock_in6.sin6_port;
> -				memcpy(&sock_in.sin_addr, &sock_in6.sin6_addr.s6_addr32[3], 4);
> -				memcpy(&conn->local_sockaddr, &sock_in, sizeof(sock_in));
> +				u.sock_in.sin_family = AF_INET;
> +				u.sock_in.sin_port = u.sock_in6.sin6_port;
> +				memcpy(&u.sock_in.sin_addr, &u.sock_in6.sin6_addr.s6_addr32[3], 4);
> +				memcpy(&conn->local_sockaddr, &u.sock_in, sizeof(u.sock_in));
>   			}
>   		}
>   	} else {
> -		memset(&sock_in, 0, sizeof(struct sockaddr_in));
> +		memset(&u.sock_in, 0, sizeof(struct sockaddr_in));
>   
> -		rc = conn->sock->ops->getname(conn->sock,
> -				(struct sockaddr *)&sock_in, 1);
> +		rc = conn->sock->ops->getname(conn->sock, &u.storage, 1);
>   		if (rc >= 0)
> -			memcpy(&conn->login_sockaddr, &sock_in, sizeof(sock_in));
> +			memcpy(&conn->login_sockaddr, &u.sock_in, sizeof(u.sock_in));
>   
> -		rc = conn->sock->ops->getname(conn->sock,
> -				(struct sockaddr *)&sock_in, 0);
> +		rc = conn->sock->ops->getname(conn->sock, &u.storage, 0);
>   		if (rc >= 0)
> -			memcpy(&conn->local_sockaddr, &sock_in, sizeof(sock_in));
> +			memcpy(&conn->local_sockaddr, &u.sock_in, sizeof(u.sock_in));
>   	}
>   
>   	return 0;
> diff --git a/fs/dlm/lowcomms.c b/fs/dlm/lowcomms.c
> index df40c3fd1070..7f232936e73c 100644
> --- a/fs/dlm/lowcomms.c
> +++ b/fs/dlm/lowcomms.c
> @@ -993,7 +993,7 @@ static int accept_from_sock(void)
>   
>   	/* Get the connected socket's peer */
>   	memset(&peeraddr, 0, sizeof(peeraddr));
> -	len = newsock->ops->getname(newsock, (struct sockaddr *)&peeraddr, 2);
> +	len = newsock->ops->getname(newsock, &peeraddr, 2);
>   	if (len < 0) {
>   		result = -ECONNABORTED;
>   		goto accept_err;
> diff --git a/fs/nfs/nfs4client.c b/fs/nfs/nfs4client.c
> index 83378f69b35e..a7428367a526 100644
> --- a/fs/nfs/nfs4client.c
> +++ b/fs/nfs/nfs4client.c
> @@ -248,7 +248,7 @@ struct nfs_client *nfs4_alloc_client(const struct nfs_client_initdata *cl_init)
>   		struct sockaddr_storage cb_addr;
>   		struct sockaddr *sap = (struct sockaddr *)&cb_addr;
>   
> -		err = rpc_localaddr(clp->cl_rpcclient, sap, sizeof(cb_addr));
> +		err = rpc_localaddr(clp->cl_rpcclient, &cb_addr, sizeof(cb_addr));
>   		if (err < 0)
>   			goto error;
>   		err = rpc_ntop(sap, buf, sizeof(buf));
> @@ -1352,7 +1352,7 @@ int nfs4_update_server(struct nfs_server *server, const char *hostname,
>   	if (error != 0)
>   		return error;
>   
> -	error = rpc_localaddr(clnt, localaddr, sizeof(address));
> +	error = rpc_localaddr(clnt, &address, sizeof(address));
>   	if (error != 0)
>   		return error;
>   
> diff --git a/fs/ocfs2/cluster/tcp.c b/fs/ocfs2/cluster/tcp.c
> index 2b8fa3e782fb..bb8ccd3a222f 100644
> --- a/fs/ocfs2/cluster/tcp.c
> +++ b/fs/ocfs2/cluster/tcp.c
> @@ -1779,7 +1779,10 @@ int o2net_register_hb_callbacks(void)
>   static int o2net_accept_one(struct socket *sock, int *more)
>   {
>   	int ret;
> -	struct sockaddr_in sin;
> +	union {
> +		struct sockaddr_storage storage;
> +		struct sockaddr_in sin;
> +	} u;
>   	struct socket *new_sock = NULL;
>   	struct o2nm_node *node = NULL;
>   	struct o2nm_node *local_node = NULL;
> @@ -1815,15 +1818,14 @@ static int o2net_accept_one(struct socket *sock, int *more)
>   	tcp_sock_set_nodelay(new_sock->sk);
>   	tcp_sock_set_user_timeout(new_sock->sk, O2NET_TCP_USER_TIMEOUT);
>   
> -	ret = new_sock->ops->getname(new_sock, (struct sockaddr *) &sin, 1);
> +	ret = new_sock->ops->getname(new_sock, &u.storage, 1);
>   	if (ret < 0)
>   		goto out;
>   
> -	node = o2nm_get_node_by_ip(sin.sin_addr.s_addr);
> +	node = o2nm_get_node_by_ip(u.sin.sin_addr.s_addr);
>   	if (node == NULL) {
> -		printk(KERN_NOTICE "o2net: Attempt to connect from unknown "
> -		       "node at %pI4:%d\n", &sin.sin_addr.s_addr,
> -		       ntohs(sin.sin_port));
> +		printk(KERN_NOTICE "o2net: Attempt to connect from unknown node at %pI4:%d\n",
> +		       &u.sin.sin_addr.s_addr, ntohs(u.sin.sin_port));
>   		ret = -EINVAL;
>   		goto out;
>   	}
> @@ -1838,8 +1840,8 @@ static int o2net_accept_one(struct socket *sock, int *more)
>   					&(local_node->nd_ipv4_address),
>   					ntohs(local_node->nd_ipv4_port),
>   					node->nd_name,
> -					node->nd_num, &sin.sin_addr.s_addr,
> -					ntohs(sin.sin_port));
> +					node->nd_num, &u.sin.sin_addr.s_addr,
> +					ntohs(u.sin.sin_port));
>   		ret = -EINVAL;
>   		goto out;
>   	}
> @@ -1849,8 +1851,8 @@ static int o2net_accept_one(struct socket *sock, int *more)
>   	if (!o2hb_check_node_heartbeating_from_callback(node->nd_num)) {
>   		mlog(ML_CONN, "attempt to connect from node '%s' at "
>   		     "%pI4:%d but it isn't heartbeating\n",
> -		     node->nd_name, &sin.sin_addr.s_addr,
> -		     ntohs(sin.sin_port));
> +		     node->nd_name, &u.sin.sin_addr.s_addr,
> +		     ntohs(u.sin.sin_port));
>   		ret = -EINVAL;
>   		goto out;
>   	}
> @@ -1866,8 +1868,8 @@ static int o2net_accept_one(struct socket *sock, int *more)
>   	if (ret) {
>   		printk(KERN_NOTICE "o2net: Attempt to connect from node '%s' "
>   		       "at %pI4:%d but it already has an open connection\n",
> -		       node->nd_name, &sin.sin_addr.s_addr,
> -		       ntohs(sin.sin_port));
> +		       node->nd_name, &u.sin.sin_addr.s_addr,
> +		       ntohs(u.sin.sin_port));
>   		goto out;
>   	}
>   
> diff --git a/fs/smb/server/connection.h b/fs/smb/server/connection.h
> index 8ddd5a3c7baf..35fc9f7cd0b2 100644
> --- a/fs/smb/server/connection.h
> +++ b/fs/smb/server/connection.h
> @@ -141,7 +141,7 @@ struct ksmbd_transport {
>   
>   #define KSMBD_TCP_RECV_TIMEOUT	(7 * HZ)
>   #define KSMBD_TCP_SEND_TIMEOUT	(5 * HZ)
> -#define KSMBD_TCP_PEER_SOCKADDR(c)	((struct sockaddr *)&((c)->peer_addr))
> +#define KSMBD_TCP_PEER_SOCKADDR(c)	(&((c)->peer_addr))
>   
>   extern struct list_head conn_list;
>   extern struct rw_semaphore conn_list_lock;
> diff --git a/fs/smb/server/mgmt/tree_connect.c b/fs/smb/server/mgmt/tree_connect.c
> index ecfc57508671..06a59fb8d25b 100644
> --- a/fs/smb/server/mgmt/tree_connect.c
> +++ b/fs/smb/server/mgmt/tree_connect.c
> @@ -22,7 +22,7 @@ ksmbd_tree_conn_connect(struct ksmbd_work *work, const char *share_name)
>   	struct ksmbd_tree_connect_response *resp = NULL;
>   	struct ksmbd_share_config *sc;
>   	struct ksmbd_tree_connect *tree_conn = NULL;
> -	struct sockaddr *peer_addr;
> +	struct sockaddr_storage *peer_addr;
>   	struct ksmbd_conn *conn = work->conn;
>   	struct ksmbd_session *sess = work->sess;
>   	int ret;
> diff --git a/fs/smb/server/transport_ipc.c b/fs/smb/server/transport_ipc.c
> index 48cda3350e5a..b279f8f75eeb 100644
> --- a/fs/smb/server/transport_ipc.c
> +++ b/fs/smb/server/transport_ipc.c
> @@ -644,7 +644,7 @@ struct ksmbd_tree_connect_response *
>   ksmbd_ipc_tree_connect_request(struct ksmbd_session *sess,
>   			       struct ksmbd_share_config *share,
>   			       struct ksmbd_tree_connect *tree_conn,
> -			       struct sockaddr *peer_addr)
> +			       struct sockaddr_storage *peer_addr)
>   {
>   	struct ksmbd_ipc_msg *msg;
>   	struct ksmbd_tree_connect_request *req;
> @@ -671,7 +671,7 @@ ksmbd_ipc_tree_connect_request(struct ksmbd_session *sess,
>   	strscpy(req->share, share->name, KSMBD_REQ_MAX_SHARE_NAME);
>   	snprintf(req->peer_addr, sizeof(req->peer_addr), "%pIS", peer_addr);
>   
> -	if (peer_addr->sa_family == AF_INET6)
> +	if (peer_addr->ss_family == AF_INET6)
>   		req->flags |= KSMBD_TREE_CONN_FLAG_REQUEST_IPV6;
>   	if (test_session_flag(sess, CIFDS_SESSION_FLAG_SMB2))
>   		req->flags |= KSMBD_TREE_CONN_FLAG_REQUEST_SMB2;
> diff --git a/fs/smb/server/transport_ipc.h b/fs/smb/server/transport_ipc.h
> index d9b6737f8cd0..840b9b1c56f6 100644
> --- a/fs/smb/server/transport_ipc.h
> +++ b/fs/smb/server/transport_ipc.h
> @@ -18,13 +18,13 @@ ksmbd_ipc_login_request_ext(const char *account);
>   struct ksmbd_session;
>   struct ksmbd_share_config;
>   struct ksmbd_tree_connect;
> -struct sockaddr;
> +struct __kernel_sockaddr_storage;
>   
>   struct ksmbd_tree_connect_response *
>   ksmbd_ipc_tree_connect_request(struct ksmbd_session *sess,
>   			       struct ksmbd_share_config *share,
>   			       struct ksmbd_tree_connect *tree_conn,
> -			       struct sockaddr *peer_addr);
> +			       struct __kernel_sockaddr_storage *peer_addr);
>   int ksmbd_ipc_tree_disconnect_request(unsigned long long session_id,
>   				      unsigned long long connect_id);
>   int ksmbd_ipc_logout_request(const char *account, int flags);
> diff --git a/fs/smb/server/transport_tcp.c b/fs/smb/server/transport_tcp.c
> index 0d9007285e30..7ab1031e554b 100644
> --- a/fs/smb/server/transport_tcp.c
> +++ b/fs/smb/server/transport_tcp.c
> @@ -160,9 +160,9 @@ static struct kvec *get_conn_iovec(struct tcp_transport *t, unsigned int nr_segs
>   	return new_iov;
>   }
>   
> -static unsigned short ksmbd_tcp_get_port(const struct sockaddr *sa)
> +static unsigned short ksmbd_tcp_get_port(const struct sockaddr_storage *sa)
>   {
> -	switch (sa->sa_family) {
> +	switch (sa->ss_family) {
>   	case AF_INET:
>   		return ntohs(((struct sockaddr_in *)sa)->sin_port);
>   	case AF_INET6:
> @@ -182,7 +182,7 @@ static unsigned short ksmbd_tcp_get_port(const struct sockaddr *sa)
>    */
>   static int ksmbd_tcp_new_connection(struct socket *client_sk)
>   {
> -	struct sockaddr *csin;
> +	struct sockaddr_storage *csin;
>   	int rc = 0;
>   	struct tcp_transport *t;
>   	struct task_struct *handler;
> diff --git a/include/linux/net.h b/include/linux/net.h
> index b75bc534c1b3..e31baa3fb360 100644
> --- a/include/linux/net.h
> +++ b/include/linux/net.h
> @@ -175,7 +175,7 @@ struct proto_ops {
>   				      struct socket *newsock,
>   				      struct proto_accept_arg *arg);
>   	int		(*getname)   (struct socket *sock,
> -				      struct sockaddr *addr,
> +				      struct sockaddr_storage *addr,
>   				      int peer);
>   	__poll_t	(*poll)	     (struct file *file, struct socket *sock,
>   				      struct poll_table_struct *wait);
> @@ -353,8 +353,8 @@ int kernel_listen(struct socket *sock, int backlog);
>   int kernel_accept(struct socket *sock, struct socket **newsock, int flags);
>   int kernel_connect(struct socket *sock, struct sockaddr *addr, int addrlen,
>   		   int flags);
> -int kernel_getsockname(struct socket *sock, struct sockaddr *addr);
> -int kernel_getpeername(struct socket *sock, struct sockaddr *addr);
> +int kernel_getsockname(struct socket *sock, struct sockaddr_storage *addr);
> +int kernel_getpeername(struct socket *sock, struct sockaddr_storage *addr);
>   int kernel_sock_shutdown(struct socket *sock, enum sock_shutdown_cmd how);
>   
>   /* Routine returns the IP overhead imposed by a (caller-protected) socket. */
> diff --git a/include/linux/sunrpc/clnt.h b/include/linux/sunrpc/clnt.h
> index 5321585c778f..8f29cede4ff3 100644
> --- a/include/linux/sunrpc/clnt.h
> +++ b/include/linux/sunrpc/clnt.h
> @@ -223,8 +223,8 @@ unsigned int	rpc_num_bc_slots(struct rpc_clnt *);
>   void		rpc_force_rebind(struct rpc_clnt *);
>   size_t		rpc_peeraddr(struct rpc_clnt *, struct sockaddr *, size_t);
>   const char	*rpc_peeraddr2str(struct rpc_clnt *, enum rpc_display_format_t);
> -int		rpc_localaddr(struct rpc_clnt *, struct sockaddr *, size_t);
> -
> +int		rpc_localaddr(struct rpc_clnt *clnt, struct sockaddr_storage *buf,
> +			      size_t buflen);
>   int 		rpc_clnt_iterate_for_each_xprt(struct rpc_clnt *clnt,
>   			int (*fn)(struct rpc_clnt *, struct rpc_xprt *, void *),
>   			void *data);
> diff --git a/include/net/inet_common.h b/include/net/inet_common.h
> index c17a6585d0b0..2bc95e0171e7 100644
> --- a/include/net/inet_common.h
> +++ b/include/net/inet_common.h
> @@ -54,7 +54,7 @@ int inet_bind_sk(struct sock *sk, struct sockaddr *uaddr, int addr_len);
>   #define BIND_NO_CAP_NET_BIND_SERVICE	(1 << 3)
>   int __inet_bind(struct sock *sk, struct sockaddr *uaddr, int addr_len,
>   		u32 flags);
> -int inet_getname(struct socket *sock, struct sockaddr *uaddr,
> +int inet_getname(struct socket *sock, struct sockaddr_storage *uaddr,
>   		 int peer);
>   int inet_ioctl(struct socket *sock, unsigned int cmd, unsigned long arg);
>   int inet_ctl_sock_create(struct sock **sk, unsigned short family,
> diff --git a/include/net/ipv6.h b/include/net/ipv6.h
> index 248bfb26e2af..e0ee07a8486e 100644
> --- a/include/net/ipv6.h
> +++ b/include/net/ipv6.h
> @@ -1214,7 +1214,7 @@ void inet6_sock_destruct(struct sock *sk);
>   int inet6_release(struct socket *sock);
>   int inet6_bind(struct socket *sock, struct sockaddr *uaddr, int addr_len);
>   int inet6_bind_sk(struct sock *sk, struct sockaddr *uaddr, int addr_len);
> -int inet6_getname(struct socket *sock, struct sockaddr *uaddr,
> +int inet6_getname(struct socket *sock, struct sockaddr_storage *uaddr,
>   		  int peer);
>   int inet6_ioctl(struct socket *sock, unsigned int cmd, unsigned long arg);
>   int inet6_compat_ioctl(struct socket *sock, unsigned int cmd,
> diff --git a/include/net/sock.h b/include/net/sock.h
> index 7464e9f9f47c..647edced2a51 100644
> --- a/include/net/sock.h
> +++ b/include/net/sock.h
> @@ -1837,7 +1837,8 @@ int sock_no_bind(struct socket *, struct sockaddr *, int);
>   int sock_no_connect(struct socket *, struct sockaddr *, int, int);
>   int sock_no_socketpair(struct socket *, struct socket *);
>   int sock_no_accept(struct socket *, struct socket *, struct proto_accept_arg *);
> -int sock_no_getname(struct socket *, struct sockaddr *, int);
> +int sock_no_getname(struct socket *sock, struct sockaddr_storage *saddr,
> +		    int peer);
>   int sock_no_ioctl(struct socket *, unsigned int, unsigned long);
>   int sock_no_listen(struct socket *, int);
>   int sock_no_shutdown(struct socket *, int);
> diff --git a/net/appletalk/ddp.c b/net/appletalk/ddp.c
> index b068651984fe..b0a5137e9dce 100644
> --- a/net/appletalk/ddp.c
> +++ b/net/appletalk/ddp.c
> @@ -1258,7 +1258,7 @@ static int atalk_connect(struct socket *sock, struct sockaddr *uaddr,
>    * Find the name of an AppleTalk socket. Just copy the right
>    * fields into the sockaddr.
>    */
> -static int atalk_getname(struct socket *sock, struct sockaddr *uaddr,
> +static int atalk_getname(struct socket *sock, struct sockaddr_storage *uaddr,
>   			 int peer)
>   {
>   	struct sockaddr_at sat;
> diff --git a/net/atm/pvc.c b/net/atm/pvc.c
> index 66d9a9bd5896..897b82de7a5b 100644
> --- a/net/atm/pvc.c
> +++ b/net/atm/pvc.c
> @@ -86,7 +86,7 @@ static int pvc_getsockopt(struct socket *sock, int level, int optname,
>   	return error;
>   }
>   
> -static int pvc_getname(struct socket *sock, struct sockaddr *sockaddr,
> +static int pvc_getname(struct socket *sock, struct sockaddr_storage *sockaddr,
>   		       int peer)
>   {
>   	struct sockaddr_atmpvc *addr;
> diff --git a/net/atm/svc.c b/net/atm/svc.c
> index f8137ae693b0..b02f5833cc9a 100644
> --- a/net/atm/svc.c
> +++ b/net/atm/svc.c
> @@ -423,7 +423,7 @@ static int svc_accept(struct socket *sock, struct socket *newsock,
>   	return error;
>   }
>   
> -static int svc_getname(struct socket *sock, struct sockaddr *sockaddr,
> +static int svc_getname(struct socket *sock, struct sockaddr_storage *sockaddr,
>   		       int peer)
>   {
>   	struct sockaddr_atmsvc *addr;
> diff --git a/net/ax25/af_ax25.c b/net/ax25/af_ax25.c
> index d6f9fae06a9d..82edd9d8a8f6 100644
> --- a/net/ax25/af_ax25.c
> +++ b/net/ax25/af_ax25.c
> @@ -1447,8 +1447,8 @@ static int ax25_accept(struct socket *sock, struct socket *newsock,
>   	return err;
>   }
>   
> -static int ax25_getname(struct socket *sock, struct sockaddr *uaddr,
> -	int peer)
> +static int ax25_getname(struct socket *sock, struct sockaddr_storage *uaddr,
> +			int peer)
>   {
>   	struct full_sockaddr_ax25 *fsa = (struct full_sockaddr_ax25 *)uaddr;
>   	struct sock *sk = sock->sk;
> diff --git a/net/bluetooth/hci_sock.c b/net/bluetooth/hci_sock.c
> index 2272e1849ebd..3fe844460fc4 100644
> --- a/net/bluetooth/hci_sock.c
> +++ b/net/bluetooth/hci_sock.c
> @@ -1478,7 +1478,7 @@ static int hci_sock_bind(struct socket *sock, struct sockaddr *addr,
>   	return err;
>   }
>   
> -static int hci_sock_getname(struct socket *sock, struct sockaddr *addr,
> +static int hci_sock_getname(struct socket *sock, struct sockaddr_storage *addr,
>   			    int peer)
>   {
>   	struct sockaddr_hci *haddr = (struct sockaddr_hci *)addr;
> diff --git a/net/bluetooth/iso.c b/net/bluetooth/iso.c
> index 1b40fd2b2f02..37696247b9a8 100644
> --- a/net/bluetooth/iso.c
> +++ b/net/bluetooth/iso.c
> @@ -1273,15 +1273,15 @@ static int iso_sock_accept(struct socket *sock, struct socket *newsock,
>   	return err;
>   }
>   
> -static int iso_sock_getname(struct socket *sock, struct sockaddr *addr,
> -			    int peer)
> +static int iso_sock_getname(struct socket *sock,
> +			    struct sockaddr_storage *addr, int peer)
>   {
>   	struct sockaddr_iso *sa = (struct sockaddr_iso *)addr;
>   	struct sock *sk = sock->sk;
>   
>   	BT_DBG("sock %p, sk %p", sock, sk);
>   
> -	addr->sa_family = AF_BLUETOOTH;
> +	sa->iso_family = AF_BLUETOOTH;
>   
>   	if (peer) {
>   		bacpy(&sa->iso_bdaddr, &iso_pi(sk)->dst);
> diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
> index 18e89e764f3b..799b2991ab17 100644
> --- a/net/bluetooth/l2cap_sock.c
> +++ b/net/bluetooth/l2cap_sock.c
> @@ -382,8 +382,8 @@ static int l2cap_sock_accept(struct socket *sock, struct socket *newsock,
>   	return err;
>   }
>   
> -static int l2cap_sock_getname(struct socket *sock, struct sockaddr *addr,
> -			      int peer)
> +static int l2cap_sock_getname(struct socket *sock,
> +			      struct sockaddr_storage *addr, int peer)
>   {
>   	struct sockaddr_l2 *la = (struct sockaddr_l2 *) addr;
>   	struct sock *sk = sock->sk;
> @@ -397,7 +397,7 @@ static int l2cap_sock_getname(struct socket *sock, struct sockaddr *addr,
>   		return -ENOTCONN;
>   
>   	memset(la, 0, sizeof(struct sockaddr_l2));
> -	addr->sa_family = AF_BLUETOOTH;
> +	la->l2_family = AF_BLUETOOTH;
>   
>   	la->l2_psm = chan->psm;
>   
> diff --git a/net/bluetooth/rfcomm/sock.c b/net/bluetooth/rfcomm/sock.c
> index 40766f8119ed..167a95f446da 100644
> --- a/net/bluetooth/rfcomm/sock.c
> +++ b/net/bluetooth/rfcomm/sock.c
> @@ -529,7 +529,8 @@ static int rfcomm_sock_accept(struct socket *sock, struct socket *newsock,
>   	return err;
>   }
>   
> -static int rfcomm_sock_getname(struct socket *sock, struct sockaddr *addr, int peer)
> +static int rfcomm_sock_getname(struct socket *sock, struct sockaddr_storage *addr,
> +			       int peer)
>   {
>   	struct sockaddr_rc *sa = (struct sockaddr_rc *) addr;
>   	struct sock *sk = sock->sk;
> diff --git a/net/bluetooth/sco.c b/net/bluetooth/sco.c
> index 78f7bca24487..a828bc2990d0 100644
> --- a/net/bluetooth/sco.c
> +++ b/net/bluetooth/sco.c
> @@ -750,15 +750,15 @@ static int sco_sock_accept(struct socket *sock, struct socket *newsock,
>   	return err;
>   }
>   
> -static int sco_sock_getname(struct socket *sock, struct sockaddr *addr,
> -			    int peer)
> +static int sco_sock_getname(struct socket *sock,
> +			    struct sockaddr_storage *addr, int peer)
>   {
>   	struct sockaddr_sco *sa = (struct sockaddr_sco *) addr;
>   	struct sock *sk = sock->sk;
>   
>   	BT_DBG("sock %p, sk %p", sock, sk);
>   
> -	addr->sa_family = AF_BLUETOOTH;
> +	sa->sco_family = AF_BLUETOOTH;
>   
>   	if (peer)
>   		bacpy(&sa->sco_bdaddr, &sco_pi(sk)->dst);
> diff --git a/net/can/isotp.c b/net/can/isotp.c
> index 16046931542a..5afb88885548 100644
> --- a/net/can/isotp.c
> +++ b/net/can/isotp.c
> @@ -1352,7 +1352,8 @@ static int isotp_bind(struct socket *sock, struct sockaddr *uaddr, int len)
>   	return err;
>   }
>   
> -static int isotp_getname(struct socket *sock, struct sockaddr *uaddr, int peer)
> +static int isotp_getname(struct socket *sock, struct sockaddr_storage *uaddr,
> +			 int peer)
>   {
>   	struct sockaddr_can *addr = (struct sockaddr_can *)uaddr;
>   	struct sock *sk = sock->sk;
> diff --git a/net/can/j1939/socket.c b/net/can/j1939/socket.c
> index 305dd72c844c..66ea829811ab 100644
> --- a/net/can/j1939/socket.c
> +++ b/net/can/j1939/socket.c
> @@ -598,7 +598,7 @@ static void j1939_sk_sock2sockaddr_can(struct sockaddr_can *addr,
>   	}
>   }
>   
> -static int j1939_sk_getname(struct socket *sock, struct sockaddr *uaddr,
> +static int j1939_sk_getname(struct socket *sock, struct sockaddr_storage *uaddr,
>   			    int peer)
>   {
>   	struct sockaddr_can *addr = (struct sockaddr_can *)uaddr;
> diff --git a/net/can/raw.c b/net/can/raw.c
> index 255c0a8f39d6..551aec0e321e 100644
> --- a/net/can/raw.c
> +++ b/net/can/raw.c
> @@ -530,7 +530,7 @@ static int raw_bind(struct socket *sock, struct sockaddr *uaddr, int len)
>   	return err;
>   }
>   
> -static int raw_getname(struct socket *sock, struct sockaddr *uaddr,
> +static int raw_getname(struct socket *sock, struct sockaddr_storage *uaddr,
>   		       int peer)
>   {
>   	struct sockaddr_can *addr = (struct sockaddr_can *)uaddr;
> diff --git a/net/core/sock.c b/net/core/sock.c
> index 74729d20cd00..fd6d42512530 100644
> --- a/net/core/sock.c
> +++ b/net/core/sock.c
> @@ -1909,7 +1909,7 @@ int sk_getsockopt(struct sock *sk, int level, int optname,
>   	{
>   		struct sockaddr_storage address;
>   
> -		lv = READ_ONCE(sock->ops)->getname(sock, (struct sockaddr *)&address, 2);
> +		lv = READ_ONCE(sock->ops)->getname(sock, &address, 2);
>   		if (lv < 0)
>   			return -ENOTCONN;
>   		if (lv < len)
> @@ -3348,7 +3348,7 @@ int sock_no_accept(struct socket *sock, struct socket *newsock,
>   }
>   EXPORT_SYMBOL(sock_no_accept);
>   
> -int sock_no_getname(struct socket *sock, struct sockaddr *saddr,
> +int sock_no_getname(struct socket *sock, struct sockaddr_storage *saddr,
>   		    int peer)
>   {
>   	return -EOPNOTSUPP;
> diff --git a/net/ipv4/af_inet.c b/net/ipv4/af_inet.c
> index 8095e82de808..1ebe2ebe9f22 100644
> --- a/net/ipv4/af_inet.c
> +++ b/net/ipv4/af_inet.c
> @@ -792,7 +792,7 @@ EXPORT_SYMBOL(inet_accept);
>   /*
>    *	This does both peername and sockname.
>    */
> -int inet_getname(struct socket *sock, struct sockaddr *uaddr,
> +int inet_getname(struct socket *sock, struct sockaddr_storage *uaddr,
>   		 int peer)
>   {
>   	struct sock *sk		= sock->sk;
> diff --git a/net/ipv6/af_inet6.c b/net/ipv6/af_inet6.c
> index f60ec8b0f8ea..78d29dbeda1c 100644
> --- a/net/ipv6/af_inet6.c
> +++ b/net/ipv6/af_inet6.c
> @@ -518,7 +518,7 @@ EXPORT_SYMBOL_GPL(inet6_cleanup_sock);
>   /*
>    *	This does both peername and sockname.
>    */
> -int inet6_getname(struct socket *sock, struct sockaddr *uaddr,
> +int inet6_getname(struct socket *sock, struct sockaddr_storage *uaddr,
>   		  int peer)
>   {
>   	struct sockaddr_in6 *sin = (struct sockaddr_in6 *)uaddr;
> diff --git a/net/iucv/af_iucv.c b/net/iucv/af_iucv.c
> index 7929df08d4e0..2612382e1a48 100644
> --- a/net/iucv/af_iucv.c
> +++ b/net/iucv/af_iucv.c
> @@ -848,14 +848,14 @@ static int iucv_sock_accept(struct socket *sock, struct socket *newsock,
>   	return err;
>   }
>   
> -static int iucv_sock_getname(struct socket *sock, struct sockaddr *addr,
> -			     int peer)
> +static int iucv_sock_getname(struct socket *sock,
> +			     struct sockaddr_storage *addr, int peer)
>   {
>   	DECLARE_SOCKADDR(struct sockaddr_iucv *, siucv, addr);
>   	struct sock *sk = sock->sk;
>   	struct iucv_sock *iucv = iucv_sk(sk);
>   
> -	addr->sa_family = AF_IUCV;
> +	siucv->sa_family = AF_IUCV;
>   
>   	if (peer) {
>   		memcpy(siucv->siucv_user_id, iucv->dst_user_id, 8);
> diff --git a/net/l2tp/l2tp_ip.c b/net/l2tp/l2tp_ip.c
> index 4bc24fddfd52..ed92eabb8552 100644
> --- a/net/l2tp/l2tp_ip.c
> +++ b/net/l2tp/l2tp_ip.c
> @@ -373,7 +373,7 @@ static int l2tp_ip_disconnect(struct sock *sk, int flags)
>   	return __udp_disconnect(sk, flags);
>   }
>   
> -static int l2tp_ip_getname(struct socket *sock, struct sockaddr *uaddr,
> +static int l2tp_ip_getname(struct socket *sock, struct sockaddr_storage *uaddr,
>   			   int peer)
>   {
>   	struct sock *sk		= sock->sk;
> diff --git a/net/l2tp/l2tp_ip6.c b/net/l2tp/l2tp_ip6.c
> index f4c1da070826..59a5e74b2561 100644
> --- a/net/l2tp/l2tp_ip6.c
> +++ b/net/l2tp/l2tp_ip6.c
> @@ -443,7 +443,7 @@ static int l2tp_ip6_disconnect(struct sock *sk, int flags)
>   	return __udp_disconnect(sk, flags);
>   }
>   
> -static int l2tp_ip6_getname(struct socket *sock, struct sockaddr *uaddr,
> +static int l2tp_ip6_getname(struct socket *sock, struct sockaddr_storage *uaddr,
>   			    int peer)
>   {
>   	struct sockaddr_l2tpip6 *lsa = (struct sockaddr_l2tpip6 *)uaddr;
> diff --git a/net/l2tp/l2tp_ppp.c b/net/l2tp/l2tp_ppp.c
> index 53baf2dd5d5d..ae1536ed5a5b 100644
> --- a/net/l2tp/l2tp_ppp.c
> +++ b/net/l2tp/l2tp_ppp.c
> @@ -886,7 +886,7 @@ static int pppol2tp_session_create(struct net *net, struct l2tp_tunnel *tunnel,
>   
>   /* getname() support.
>    */
> -static int pppol2tp_getname(struct socket *sock, struct sockaddr *uaddr,
> +static int pppol2tp_getname(struct socket *sock, struct sockaddr_storage *uaddr,
>   			    int peer)
>   {
>   	int len = 0;
> diff --git a/net/llc/af_llc.c b/net/llc/af_llc.c
> index 0259cde394ba..12c0b14e1ef6 100644
> --- a/net/llc/af_llc.c
> +++ b/net/llc/af_llc.c
> @@ -1023,7 +1023,7 @@ static int llc_ui_sendmsg(struct socket *sock, struct msghdr *msg, size_t len)
>    *
>    *	Return the address information of a socket.
>    */
> -static int llc_ui_getname(struct socket *sock, struct sockaddr *uaddr,
> +static int llc_ui_getname(struct socket *sock, struct sockaddr_storage *uaddr,
>   			  int peer)
>   {
>   	struct sockaddr_llc sllc;
> diff --git a/net/netlink/af_netlink.c b/net/netlink/af_netlink.c
> index f4e7b5e4bb59..64ec9293136f 100644
> --- a/net/netlink/af_netlink.c
> +++ b/net/netlink/af_netlink.c
> @@ -1113,8 +1113,8 @@ static int netlink_connect(struct socket *sock, struct sockaddr *addr,
>   	return err;
>   }
>   
> -static int netlink_getname(struct socket *sock, struct sockaddr *addr,
> -			   int peer)
> +static int netlink_getname(struct socket *sock,
> +			   struct sockaddr_storage *addr, int peer)
>   {
>   	struct sock *sk = sock->sk;
>   	struct netlink_sock *nlk = nlk_sk(sk);
> diff --git a/net/netrom/af_netrom.c b/net/netrom/af_netrom.c
> index 6ee148f0e6d0..f845c0a56b75 100644
> --- a/net/netrom/af_netrom.c
> +++ b/net/netrom/af_netrom.c
> @@ -835,8 +835,8 @@ static int nr_accept(struct socket *sock, struct socket *newsock,
>   	return err;
>   }
>   
> -static int nr_getname(struct socket *sock, struct sockaddr *uaddr,
> -	int peer)
> +static int nr_getname(struct socket *sock, struct sockaddr_storage *uaddr,
> +		      int peer)
>   {
>   	struct full_sockaddr_ax25 *sax = (struct full_sockaddr_ax25 *)uaddr;
>   	struct sock *sk = sock->sk;
> diff --git a/net/nfc/llcp_sock.c b/net/nfc/llcp_sock.c
> index 57a2f97004e1..1ba19e542320 100644
> --- a/net/nfc/llcp_sock.c
> +++ b/net/nfc/llcp_sock.c
> @@ -500,8 +500,8 @@ static int llcp_sock_accept(struct socket *sock, struct socket *newsock,
>   	return ret;
>   }
>   
> -static int llcp_sock_getname(struct socket *sock, struct sockaddr *uaddr,
> -			     int peer)
> +static int llcp_sock_getname(struct socket *sock,
> +			     struct sockaddr_storage *uaddr, int peer)
>   {
>   	struct sock *sk = sock->sk;
>   	struct nfc_llcp_sock *llcp_sock = nfc_llcp_sock(sk);
> diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
> index 886c0dd47b66..3661476920af 100644
> --- a/net/packet/af_packet.c
> +++ b/net/packet/af_packet.c
> @@ -3640,27 +3640,28 @@ static int packet_recvmsg(struct socket *sock, struct msghdr *msg, size_t len,
>   	return err;
>   }
>   
> -static int packet_getname_spkt(struct socket *sock, struct sockaddr *uaddr,
> -			       int peer)
> +static int packet_getname_spkt(struct socket *sock,
> +			       struct sockaddr_storage *uaddr, int peer)
>   {
> +	struct sockaddr *addr = (struct sockaddr *)uaddr;
>   	struct net_device *dev;
>   	struct sock *sk	= sock->sk;
>   
>   	if (peer)
>   		return -EOPNOTSUPP;
>   
> -	uaddr->sa_family = AF_PACKET;
> -	memset(uaddr->sa_data, 0, sizeof(uaddr->sa_data_min));
> +	addr->sa_family = AF_PACKET;
> +	memset(addr->sa_data, 0, sizeof(addr->sa_data_min));
>   	rcu_read_lock();
>   	dev = dev_get_by_index_rcu(sock_net(sk), READ_ONCE(pkt_sk(sk)->ifindex));
>   	if (dev)
> -		strscpy(uaddr->sa_data, dev->name, sizeof(uaddr->sa_data_min));
> +		strscpy(addr->sa_data, dev->name, sizeof(addr->sa_data_min));
>   	rcu_read_unlock();
>   
> -	return sizeof(*uaddr);
> +	return sizeof(*addr);
>   }
>   
> -static int packet_getname(struct socket *sock, struct sockaddr *uaddr,
> +static int packet_getname(struct socket *sock, struct sockaddr_storage *uaddr,
>   			  int peer)
>   {
>   	struct net_device *dev;
> diff --git a/net/phonet/socket.c b/net/phonet/socket.c
> index 5ce0b3ee5def..711c70cc110a 100644
> --- a/net/phonet/socket.c
> +++ b/net/phonet/socket.c
> @@ -311,17 +311,17 @@ static int pn_socket_accept(struct socket *sock, struct socket *newsock,
>   	return 0;
>   }
>   
> -static int pn_socket_getname(struct socket *sock, struct sockaddr *addr,
> -				int peer)
> +static int pn_socket_getname(struct socket *sock,
> +			     struct sockaddr_storage *uaddr, int peer)
>   {
> +	struct sockaddr_pn *addr = (struct sockaddr_pn *)uaddr;
>   	struct sock *sk = sock->sk;
>   	struct pn_sock *pn = pn_sk(sk);
>   
>   	memset(addr, 0, sizeof(struct sockaddr_pn));
> -	addr->sa_family = AF_PHONET;
> +	addr->spn_family = AF_PHONET;
>   	if (!peer) /* Race with bind() here is userland's problem. */
> -		pn_sockaddr_set_object((struct sockaddr_pn *)addr,
> -					pn->sobject);
> +		pn_sockaddr_set_object(addr, pn->sobject);
>   
>   	return sizeof(struct sockaddr_pn);
>   }
> diff --git a/net/qrtr/af_qrtr.c b/net/qrtr/af_qrtr.c
> index 00c51cf693f3..836c9a4a2119 100644
> --- a/net/qrtr/af_qrtr.c
> +++ b/net/qrtr/af_qrtr.c
> @@ -1115,7 +1115,7 @@ static int qrtr_connect(struct socket *sock, struct sockaddr *saddr,
>   	return 0;
>   }
>   
> -static int qrtr_getname(struct socket *sock, struct sockaddr *saddr,
> +static int qrtr_getname(struct socket *sock, struct sockaddr_storage *saddr,
>   			int peer)
>   {
>   	struct qrtr_sock *ipc = qrtr_sk(sock->sk);
> diff --git a/net/qrtr/ns.c b/net/qrtr/ns.c
> index 3de9350cbf30..0409983eb9fb 100644
> --- a/net/qrtr/ns.c
> +++ b/net/qrtr/ns.c
> @@ -697,7 +697,7 @@ int qrtr_ns_init(void)
>   	if (ret < 0)
>   		return ret;
>   
> -	ret = kernel_getsockname(qrtr_ns.sock, (struct sockaddr *)&sq);
> +	ret = kernel_getsockname(qrtr_ns.sock, (struct sockaddr_storage *)&sq);
>   	if (ret < 0) {
>   		pr_err("failed to get socket name\n");
>   		goto err_sock;
> diff --git a/net/rds/af_rds.c b/net/rds/af_rds.c
> index 8435a20968ef..6d0cef028454 100644
> --- a/net/rds/af_rds.c
> +++ b/net/rds/af_rds.c
> @@ -111,7 +111,7 @@ void rds_wake_sk_sleep(struct rds_sock *rs)
>   	read_unlock_irqrestore(&rs->rs_recv_lock, flags);
>   }
>   
> -static int rds_getname(struct socket *sock, struct sockaddr *uaddr,
> +static int rds_getname(struct socket *sock, struct sockaddr_storage *uaddr,
>   		       int peer)
>   {
>   	struct rds_sock *rs = rds_sk_to_rs(sock->sk);
> diff --git a/net/rose/af_rose.c b/net/rose/af_rose.c
> index 59050caab65c..0260a5862cf7 100644
> --- a/net/rose/af_rose.c
> +++ b/net/rose/af_rose.c
> @@ -984,8 +984,8 @@ static int rose_accept(struct socket *sock, struct socket *newsock,
>   	return err;
>   }
>   
> -static int rose_getname(struct socket *sock, struct sockaddr *uaddr,
> -	int peer)
> +static int rose_getname(struct socket *sock, struct sockaddr_storage *uaddr,
> +			int peer)
>   {
>   	struct full_sockaddr_rose *srose = (struct full_sockaddr_rose *)uaddr;
>   	struct sock *sk = sock->sk;
> diff --git a/net/sctp/ipv6.c b/net/sctp/ipv6.c
> index a9ed2ccab1bd..2d8decaae609 100644
> --- a/net/sctp/ipv6.c
> +++ b/net/sctp/ipv6.c
> @@ -1065,7 +1065,7 @@ static int sctp_inet6_supported_addrs(const struct sctp_sock *opt,
>   }
>   
>   /* Handle SCTP_I_WANT_MAPPED_V4_ADDR for getpeername() and getsockname() */
> -static int sctp_getname(struct socket *sock, struct sockaddr *uaddr,
> +static int sctp_getname(struct socket *sock, struct sockaddr_storage *uaddr,
>   			int peer)
>   {
>   	int rc;
> diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
> index 9e6c69d18581..5d44d2392268 100644
> --- a/net/smc/af_smc.c
> +++ b/net/smc/af_smc.c
> @@ -2741,7 +2741,7 @@ int smc_accept(struct socket *sock, struct socket *new_sock,
>   	return rc;
>   }
>   
> -int smc_getname(struct socket *sock, struct sockaddr *addr,
> +int smc_getname(struct socket *sock, struct sockaddr_storage *addr,
>   		int peer)
>   {
>   	struct smc_sock *smc;
> diff --git a/net/smc/smc.h b/net/smc/smc.h
> index 78ae10d06ed2..24260f4e6830 100644
> --- a/net/smc/smc.h
> +++ b/net/smc/smc.h
> @@ -48,7 +48,7 @@ int smc_connect(struct socket *sock, struct sockaddr *addr,
>   		int alen, int flags);
>   int smc_accept(struct socket *sock, struct socket *new_sock,
>   	       struct proto_accept_arg *arg);
> -int smc_getname(struct socket *sock, struct sockaddr *addr,
> +int smc_getname(struct socket *sock, struct sockaddr_storage *addr,
>   		int peer);
>   __poll_t smc_poll(struct file *file, struct socket *sock,
>   		  poll_table *wait);
> diff --git a/net/smc/smc_clc.c b/net/smc/smc_clc.c
> index 33fa787c28eb..6eeb5decc51e 100644
> --- a/net/smc/smc_clc.c
> +++ b/net/smc/smc_clc.c
> @@ -571,7 +571,7 @@ static int smc_clc_prfx_set(struct socket *clcsock,
>   		goto out_rel;
>   	}
>   	/* get address to which the internal TCP socket is bound */
> -	if (kernel_getsockname(clcsock, (struct sockaddr *)&addrs) < 0)
> +	if (kernel_getsockname(clcsock, &addrs) < 0)
>   		goto out_rel;
>   	/* analyze IP specific data of net_device belonging to TCP socket */
>   	addr6 = (struct sockaddr_in6 *)&addrs;
> diff --git a/net/socket.c b/net/socket.c
> index 9a117248f18f..b10f2b3f4054 100644
> --- a/net/socket.c
> +++ b/net/socket.c
> @@ -1943,7 +1943,7 @@ struct file *do_accept(struct file *file, struct proto_accept_arg *arg,
>   		goto out_fd;
>   
>   	if (upeer_sockaddr) {
> -		len = ops->getname(newsock, (struct sockaddr *)&address, 2);
> +		len = ops->getname(newsock, &address, 2);
>   		if (len < 0) {
>   			err = -ECONNABORTED;
>   			goto out_fd;
> @@ -2103,7 +2103,7 @@ int __sys_getsockname(int fd, struct sockaddr __user *usockaddr,
>   	if (err)
>   		return err;
>   
> -	err = READ_ONCE(sock->ops)->getname(sock, (struct sockaddr *)&address, 0);
> +	err = READ_ONCE(sock->ops)->getname(sock, &address, 0);
>   	if (err < 0)
>   		return err;
>   
> @@ -2140,7 +2140,7 @@ int __sys_getpeername(int fd, struct sockaddr __user *usockaddr,
>   	if (err)
>   		return err;
>   
> -	err = READ_ONCE(sock->ops)->getname(sock, (struct sockaddr *)&address, 1);
> +	err = READ_ONCE(sock->ops)->getname(sock, &address, 1);
>   	if (err < 0)
>   		return err;
>   
> @@ -3636,7 +3636,7 @@ EXPORT_SYMBOL(kernel_connect);
>    *	Returns the length of the address in bytes or an error code.
>    */
>   
> -int kernel_getsockname(struct socket *sock, struct sockaddr *addr)
> +int kernel_getsockname(struct socket *sock, struct sockaddr_storage *addr)
>   {
>   	return READ_ONCE(sock->ops)->getname(sock, addr, 0);
>   }
> @@ -3651,7 +3651,7 @@ EXPORT_SYMBOL(kernel_getsockname);
>    *	Returns the length of the address in bytes or an error code.
>    */
>   
> -int kernel_getpeername(struct socket *sock, struct sockaddr *addr)
> +int kernel_getpeername(struct socket *sock, struct sockaddr_storage *addr)
>   {
>   	return READ_ONCE(sock->ops)->getname(sock, addr, 1);
>   }
> diff --git a/net/sunrpc/clnt.c b/net/sunrpc/clnt.c
> index 0090162ee8c3..8af253f5ad08 100644
> --- a/net/sunrpc/clnt.c
> +++ b/net/sunrpc/clnt.c
> @@ -1445,7 +1445,7 @@ static const struct sockaddr_in6 rpc_in6addr_loopback = {
>    * negative errno is returned.
>    */
>   static int rpc_sockname(struct net *net, struct sockaddr *sap, size_t salen,
> -			struct sockaddr *buf)
> +			struct sockaddr_storage *buf)
>   {
>   	struct socket *sock;
>   	int err;
> @@ -1490,7 +1490,7 @@ static int rpc_sockname(struct net *net, struct sockaddr *sap, size_t salen,
>   	}
>   
>   	err = 0;
> -	if (buf->sa_family == AF_INET6) {
> +	if (buf->ss_family == AF_INET6) {
>   		struct sockaddr_in6 *sin6 = (struct sockaddr_in6 *)buf;
>   		sin6->sin6_scope_id = 0;
>   	}
> @@ -1510,7 +1510,7 @@ static int rpc_sockname(struct net *net, struct sockaddr *sap, size_t salen,
>    * Returns zero and fills in "buf" if successful; otherwise, a
>    * negative errno is returned.
>    */
> -static int rpc_anyaddr(int family, struct sockaddr *buf, size_t buflen)
> +static int rpc_anyaddr(int family, struct sockaddr_storage *buf, size_t buflen)
>   {
>   	switch (family) {
>   	case AF_INET:
> @@ -1550,7 +1550,8 @@ static int rpc_anyaddr(int family, struct sockaddr *buf, size_t buflen)
>    * succession may give different results, depending on how local
>    * networking configuration changes over time.
>    */
> -int rpc_localaddr(struct rpc_clnt *clnt, struct sockaddr *buf, size_t buflen)
> +int rpc_localaddr(struct rpc_clnt *clnt, struct sockaddr_storage *buf,
> +		  size_t buflen)
>   {
>   	struct sockaddr_storage address;
>   	struct sockaddr *sap = (struct sockaddr *)&address;
> diff --git a/net/sunrpc/svcsock.c b/net/sunrpc/svcsock.c
> index 95397677673b..b062fadb2e6b 100644
> --- a/net/sunrpc/svcsock.c
> +++ b/net/sunrpc/svcsock.c
> @@ -903,7 +903,7 @@ static struct svc_xprt *svc_tcp_accept(struct svc_xprt *xprt)
>   
>   	set_bit(XPT_CONN, &svsk->sk_xprt.xpt_flags);
>   
> -	err = kernel_getpeername(newsock, sin);
> +	err = kernel_getpeername(newsock, &addr);
>   	if (err < 0) {
>   		trace_svcsock_getpeername_err(xprt, serv->sv_name, err);
>   		goto failed;		/* aborted connection or whatever */
> @@ -925,7 +925,7 @@ static struct svc_xprt *svc_tcp_accept(struct svc_xprt *xprt)
>   	if (IS_ERR(newsvsk))
>   		goto failed;
>   	svc_xprt_set_remote(&newsvsk->sk_xprt, sin, slen);
> -	err = kernel_getsockname(newsock, sin);
> +	err = kernel_getsockname(newsock, &addr);
>   	slen = err;
>   	if (unlikely(err < 0))
>   		slen = offsetof(struct sockaddr, sa_data);
> @@ -1478,7 +1478,7 @@ int svc_addsock(struct svc_serv *serv, struct net *net, const int fd,
>   		err = PTR_ERR(svsk);
>   		goto out;
>   	}
> -	salen = kernel_getsockname(svsk->sk_sock, sin);
> +	salen = kernel_getsockname(svsk->sk_sock, &addr);
>   	if (salen >= 0)
>   		svc_xprt_set_local(&svsk->sk_xprt, sin, salen);
>   	svsk->sk_xprt.xpt_cred = get_cred(cred);
> @@ -1545,7 +1545,7 @@ static struct svc_xprt *svc_create_socket(struct svc_serv *serv,
>   	if (error < 0)
>   		goto bummer;
>   
> -	error = kernel_getsockname(sock, newsin);
> +	error = kernel_getsockname(sock, &addr);
>   	if (error < 0)
>   		goto bummer;
>   	newlen = error;
> diff --git a/net/sunrpc/xprtsock.c b/net/sunrpc/xprtsock.c
> index c60936d8cef7..735c3c1d2bdf 100644
> --- a/net/sunrpc/xprtsock.c
> +++ b/net/sunrpc/xprtsock.c
> @@ -1710,7 +1710,7 @@ static unsigned short xs_sock_getport(struct socket *sock)
>   	struct sockaddr_storage buf;
>   	unsigned short port = 0;
>   
> -	if (kernel_getsockname(sock, (struct sockaddr *)&buf) < 0)
> +	if (kernel_getsockname(sock, &buf) < 0)
>   		goto out;
>   	switch (buf.ss_family) {
>   	case AF_INET6:
> @@ -1779,7 +1779,7 @@ static int xs_sock_srcaddr(struct rpc_xprt *xprt, char *buf, size_t buflen)
>   
>   	mutex_lock(&sock->recv_mutex);
>   	if (sock->sock) {
> -		ret = kernel_getsockname(sock->sock, &saddr.sa);
> +		ret = kernel_getsockname(sock->sock, &saddr.st);
>   		if (ret >= 0)
>   			ret = snprintf(buf, buflen, "%pISc", &saddr.sa);
>   	}
> diff --git a/net/tipc/socket.c b/net/tipc/socket.c
> index 65dcbb54f55d..56f609c7f2a6 100644
> --- a/net/tipc/socket.c
> +++ b/net/tipc/socket.c
> @@ -741,7 +741,7 @@ static int tipc_bind(struct socket *sock, struct sockaddr *skaddr, int alen)
>    *       accesses socket information that is unchanging (or which changes in
>    *       a completely predictable manner).
>    */
> -static int tipc_getname(struct socket *sock, struct sockaddr *uaddr,
> +static int tipc_getname(struct socket *sock, struct sockaddr_storage *uaddr,
>   			int peer)
>   {
>   	struct sockaddr_tipc *addr = (struct sockaddr_tipc *)uaddr;
> diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
> index 001ccc55ef0f..0f71ed2f35e7 100644
> --- a/net/unix/af_unix.c
> +++ b/net/unix/af_unix.c
> @@ -813,7 +813,7 @@ static int unix_stream_connect(struct socket *, struct sockaddr *,
>   			       int addr_len, int flags);
>   static int unix_socketpair(struct socket *, struct socket *);
>   static int unix_accept(struct socket *, struct socket *, struct proto_accept_arg *arg);
> -static int unix_getname(struct socket *, struct sockaddr *, int);
> +static int unix_getname(struct socket *, struct sockaddr_storage *, int);
>   static __poll_t unix_poll(struct file *, struct socket *, poll_table *);
>   static __poll_t unix_dgram_poll(struct file *, struct socket *,
>   				    poll_table *);
> @@ -1789,7 +1789,8 @@ static int unix_accept(struct socket *sock, struct socket *newsock,
>   }
>   
>   
> -static int unix_getname(struct socket *sock, struct sockaddr *uaddr, int peer)
> +static int unix_getname(struct socket *sock, struct sockaddr_storage *uaddr,
> +			int peer)
>   {
>   	struct sock *sk = sock->sk;
>   	struct unix_address *addr;
> @@ -1817,10 +1818,10 @@ static int unix_getname(struct socket *sock, struct sockaddr *uaddr, int peer)
>   		memcpy(sunaddr, addr->name, addr->len);
>   
>   		if (peer)
> -			BPF_CGROUP_RUN_SA_PROG(sk, uaddr, &err,
> +			BPF_CGROUP_RUN_SA_PROG(sk, (struct sockaddr *)uaddr, &err,
>   					       CGROUP_UNIX_GETPEERNAME);
>   		else
> -			BPF_CGROUP_RUN_SA_PROG(sk, uaddr, &err,
> +			BPF_CGROUP_RUN_SA_PROG(sk, (struct sockaddr *)uaddr, &err,
>   					       CGROUP_UNIX_GETSOCKNAME);
>   	}
>   	sock_put(sk);
> diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
> index 5cf8109f672a..6b51ee9cb8d3 100644
> --- a/net/vmw_vsock/af_vsock.c
> +++ b/net/vmw_vsock/af_vsock.c
> @@ -943,7 +943,7 @@ vsock_bind(struct socket *sock, struct sockaddr *addr, int addr_len)
>   }
>   
>   static int vsock_getname(struct socket *sock,
> -			 struct sockaddr *addr, int peer)
> +			 struct sockaddr_storage *addr, int peer)
>   {
>   	int err;
>   	struct sock *sk;
> diff --git a/net/x25/af_x25.c b/net/x25/af_x25.c
> index 8dda4178497c..f97876d30935 100644
> --- a/net/x25/af_x25.c
> +++ b/net/x25/af_x25.c
> @@ -913,7 +913,7 @@ static int x25_accept(struct socket *sock, struct socket *newsock,
>   	return rc;
>   }
>   
> -static int x25_getname(struct socket *sock, struct sockaddr *uaddr,
> +static int x25_getname(struct socket *sock, struct sockaddr_storage *uaddr,
>   		       int peer)
>   {
>   	struct sockaddr_x25 *sx25 = (struct sockaddr_x25 *)uaddr;
> diff --git a/security/tomoyo/network.c b/security/tomoyo/network.c
> index 8dc61335f65e..450fd7a37ca4 100644
> --- a/security/tomoyo/network.c
> +++ b/security/tomoyo/network.c
> @@ -658,8 +658,7 @@ int tomoyo_socket_listen_permission(struct socket *sock)
>   	if (!family || (type != SOCK_STREAM && type != SOCK_SEQPACKET))
>   		return 0;
>   	{
> -		const int error = sock->ops->getname(sock, (struct sockaddr *)
> -						     &addr, 0);
> +		const int error = sock->ops->getname(sock, &addr, 0);
>   
>   		if (error < 0)
>   			return error;

For the net/sunrpc/svcsock.c hunks:

Acked-by: Chuck Lever <chuck.lever@oracle.com>


-- 
Chuck Lever

