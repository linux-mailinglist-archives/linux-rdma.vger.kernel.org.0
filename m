Return-Path: <linux-rdma+bounces-19700-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uJ0VMLs28WmfegEAu9opvQ
	(envelope-from <linux-rdma+bounces-19700-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 29 Apr 2026 00:37:47 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2117148CA92
	for <lists+linux-rdma@lfdr.de>; Wed, 29 Apr 2026 00:37:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8A3DD302FE81
	for <lists+linux-rdma@lfdr.de>; Tue, 28 Apr 2026 22:37:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7058035A393;
	Tue, 28 Apr 2026 22:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b="BI68HpUh"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E1AF2ECD3A
	for <linux-rdma@vger.kernel.org>; Tue, 28 Apr 2026 22:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.147.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777415864; cv=fail; b=kdKdUnKvtljkpbFZJUJZaP+3B5xG/7LxgW1PRF2l5KY7kKy7gRYjII0KhsPm7o5+0v1BBr6IH0Jie6AsZ6QM0mij2ypR1xs2uaZp1KFDFFeDjbwwY5jxUHoWFrK03GyG9rSgXAaPcR4DN4g2bqqbr9r0kyTVSwYJN7OKh7O4Ma4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777415864; c=relaxed/simple;
	bh=VVpsb74m1Eu6ZMeJ6ouMHLTm9dqWumviK10C1ykCyaE=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=M9UQ+zOpTZeVLDXLj3n/7o+a5rvZz5dU+eW2CTc6aKhU784TS2DdzpDaxAXxsrTHv1fD5RX7t4gIsPyvQ4ZszZgWJ+c66BBCBKwlYFUFXwB9sEkyz1sXVNWZR0xRERcHkZscdf+gfjErkA8G1BQzVZPJFxoJkeKXEUyPk0vfxKc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.com; spf=pass smtp.mailfrom=hpe.com; dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b=BI68HpUh; arc=fail smtp.client-ip=148.163.147.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hpe.com
Received: from pps.filterd (m0134420.ppops.net [127.0.0.1])
	by mx0b-002e3701.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63SLISqc3712525;
	Tue, 28 Apr 2026 22:37:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pps0720; bh=VVpsb74m1Eu6ZMeJ6ouMHLTm9d
	qWumviK10C1ykCyaE=; b=BI68HpUhKidxenhDo97QiF1qSzDJrKf/E88wxLobKo
	GjBy0hw7r2y15S2o3CJQ0mMngZpTGdXOs8hbW0llkdfyMsHnLwj7drfIuzicUxoE
	JPWk0seHroAoWPt7AHe4x9VU8cnPAUtkOTJkQEH9zsLGUjdTkqj+LOMHOilrHx1L
	CWLIYTi8dWEF1wLNuX+I+L6h3K3Bh/NPXamzfZ6JmhyfuzWdDChIP4LHZ4Zm9Yyq
	h7118n6TuBRstUAL7KXejzLt8Yc6MQ8x2f4TDYvaTvup4ZObwtNfXM6txn5BGZxy
	BN3PONkeBN3lTgtXr3YUHCNGoHQ1GEJT8qo726KG6P9A==
Received: from p1lg14879.it.hpe.com (p1lg14879.it.hpe.com [16.230.97.200])
	by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 4du4p30maw-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 28 Apr 2026 22:37:17 +0000 (GMT)
Received: from p1wg14924.americas.hpqcorp.net (unknown [10.119.18.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by p1lg14879.it.hpe.com (Postfix) with ESMTPS id 679E82FCFC;
	Tue, 28 Apr 2026 22:37:16 +0000 (UTC)
Received: from p1wg14928.americas.hpqcorp.net (10.119.18.116) by
 p1wg14924.americas.hpqcorp.net (10.119.18.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 28 Apr 2026 10:37:02 -1200
Received: from p1wg14920.americas.hpqcorp.net (16.230.19.123) by
 p1wg14928.americas.hpqcorp.net (10.119.18.116) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Tue, 28 Apr 2026 10:37:02 -1200
Received: from BYAPR08CU003.outbound.protection.outlook.com (192.58.206.38) by
 edge.it.hpe.com (16.230.19.123) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 28 Apr
 2026 10:37:02 -1200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f9BI9ykE2358xmX8ARadlyJiq/mfONz3ZD5kmMKUtISe/prVSPj+bJE9RcyG6MMRJzhevaCLrtLBapsNEJd1RlIUK3ZuLMtDg43XFjowCxKeWjk+dmMEJOy8gQJo74Yu54rPNEZyau7yc1Wnxxz4Ah2oRjtXsKdE4D2vp0wtL/kFOHqFcy56cXnb2gTrWw0yjKBgWUICQtMCioEWOsMbpV3f4/sZae/aaJQ7VYr0IYLb9aoK8rp7HwNRl1wYt6UtFr/z6QC7tzn4du/mV4dEP637/xhfWlqonwYzCvyYX9nh8rynCz4XSwc9lfs0munjwZKqVaHigLwz6cGWPvoE0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VVpsb74m1Eu6ZMeJ6ouMHLTm9dqWumviK10C1ykCyaE=;
 b=tL0GIcICT4wcCqAahz1nJ4CIY+rhdEBwb18u+y7R8rbECVJ2z3jYrzo3x9CjFkFjAndjGx6aBe1EccQjDBL2erS2M9Y8K8LeAUxvfKAzwNyK6LHURVAxXd7GiDOehLJ4IoV928z59C3aYzCc5iVDs7KsfZ+pXU8kBqTW0nhaiWpkVs5svUlniwFuxQEzXBCZHEycx1O2Dc9lotWt91orrr/mVziSoQMVEHqKqxh6ih3q5W+YPJJf0zGG/oG+sJgbbjI8fI6zSA97bk2mJYAyVH1ZtCMrjl3vq9zKXQxtOfBX2jhvpzlrMzAWpn6lgK7zNM3nYoTmli3038hsi6NxYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from DM4PR84MB3970.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:8:225::20)
 by MW5PR84MB1913.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:303:1c3::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.26; Tue, 28 Apr
 2026 22:37:00 +0000
Received: from DM4PR84MB3970.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::d136:e75e:53c5:73d8]) by DM4PR84MB3970.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::d136:e75e:53c5:73d8%4]) with mapi id 15.20.9846.025; Tue, 28 Apr 2026
 22:37:00 +0000
Message-ID: <d0cbdd01-87e2-4a36-8b34-97445f9f8f2b@hpe.com>
Date: Tue, 28 Apr 2026 16:36:57 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-next v2 0/5] Introduce Completion Counters
To: Michael Margolin <mrgolin@amazon.com>, <jgg@nvidia.com>, <leon@kernel.org>,
        <linux-rdma@vger.kernel.org>
CC: <sleybo@amazon.com>, <matua@amazon.com>, <gal.pressman@linux.dev>
References: <20260416212327.18191-1-mrgolin@amazon.com>
Content-Language: en-US
From: Doug Ledford <doug.ledford@hpe.com>
Organization: Hewlett Packard Enterprise
In-Reply-To: <20260416212327.18191-1-mrgolin@amazon.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------sKQEuyJXy0Tf1AfSndWvVlwt"
X-ClientProxiedBy: SA9PR13CA0146.namprd13.prod.outlook.com
 (2603:10b6:806:27::31) To DM4PR84MB3970.NAMPRD84.PROD.OUTLOOK.COM
 (2603:10b6:8:225::20)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR84MB3970:EE_|MW5PR84MB1913:EE_
X-MS-Office365-Filtering-Correlation-Id: 530d4c1e-cc16-43b3-af2c-08dea576a98b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: f9wXGNrAum1dsWONGmf1ToZotOXkdAlzbMdGp3hVG2cEChDL8RA7qFULVLWoKK/rv4pAhXDyHZuMQEaEJpd48SzkDERPIs/ezVzmtaYusiuOMh+bB+YDqpY8RxHWPXq7R0BbQNHo+rbVNhVAhjGn1rARFAfN+ZUlnURKDmFL9RokNlHlyVywaRzdo7WBtEzm2a1913IN3Qy3wC6dwAM6vMRT4G2mP9MRWXBthUIRV/RKHZnew9T2peEe2J5gDO2m4kUBl+yQbG8tpNErd2200WisK7Jzd+1xcgROl8UbuiGbx9o9UB3JXUO/QjCfcLcMq4O1tVfI72J90xPJRz5fpg8chnIG/G+ft/JWaVaQkrfb81DSGz0dT2i4QetNXUKcoZr1d5uwuX5SvBCtboa0QSpCxsa9cGQ1varxdN2La5UQW7P1TwTKMVI/Gm4k5GQglR1ZFGMDAa1U5082XrkRTil8rPQ0B+pkTiI146Si1zGnk9JaHmV6x/Dzn+HPe+yz47s53CUewsL/r9YwXZA17joVI+RdTjaASrcYa85epkbRKxsAW4oyD1Yoe8pJcXdMBWSJ/LuI7WXZ6to9EPF8XLMewWdACk3pZAjEn1RWnSQD+/7Odv2nMJSp8CdaYofZKFwS4FEV+FBYNyh2ruMR41N8wDQzN7AkuMSiDkmuCWK4v3h0PpJxRPTClrXaCS790uTMw7HcBBwgqpV/G1cpdK24UOCjUiidbD7rl2uPtWA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR84MB3970.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VUJvV3U2Si9BRDg5NjVDcDg3K3RQWWxvNWJFZEZPcFVPRjQ5a2Fvdkl5Wnpx?=
 =?utf-8?B?WlJ6L0JWbGI2SWU5MFdkV2FnZ1hOdE9IT0cyM0krUWs3L25veDJGb0czSjdh?=
 =?utf-8?B?bUtiY3N0Rm1Tb2lBbU5rclhGaUxmQnczSFJtM2sveU5SdHFTVFk3OUt0dThF?=
 =?utf-8?B?QnJGQXdqdUNyVXA0QjE0dUp2K0JrNEhJYVZOMWVNZGlDbkVJbVhvczdrcEFh?=
 =?utf-8?B?NEtBYUVGQUNvUnRvcFlVeGFhSTJQcFNLNXlFSGdYdGdXQWx4bFNMVDBQN2Uv?=
 =?utf-8?B?NUgvQXliOUhWaW5RcEIxenB0Y3RPWXFTK1FRc0ZzSGZXK3pDNzdQdHVPaXM5?=
 =?utf-8?B?SjdZZ3VoemtmZTNlZEg0cmNFaWpjQWoxV1FGdGNQL05wR2VUSFljZmZ0L0RO?=
 =?utf-8?B?RExBN21DaFdXNmlDdU5IbHhWWHc2bzE5UG5FS1MwcWIrYlFuUE9DTWxKekdB?=
 =?utf-8?B?SGNwRExWdmdwcE95dnJNNnkyUkNzS3dWOUJOeXNrVllBbTNKcHJiRnp3MGda?=
 =?utf-8?B?SmV0TG1nNmd0K1lsT1RzNzk4eG52eHFiOVVvZ20xamJ4cEZsRUZUZStRRFRZ?=
 =?utf-8?B?OGJPS29Pclc1anROaXllTG1WMzIzOGllcWxNeEI2THhrVkVhWXJHcVN6Zm52?=
 =?utf-8?B?dFhSMlVFWVVLQWR5aHBOTGlBV2NMc2kydU5rRmZLSU13T01DY09EMi9YTXNN?=
 =?utf-8?B?cFpkdmZDWEFxTnljYzhIQmdGM29KT3BVc3NHQkQxR2NPRmorcGU3bE5JRmt4?=
 =?utf-8?B?cmJiTmowU2xhVDRSRHJiSDc3WHQ4SWRoMG9tcmQ0cC94T1dRaTE4OVN3Vi80?=
 =?utf-8?B?NGtGSkJ6eERtc2t4QlNQMGp0V2VZdjZRMFZVdVBhSHZFSEU5d01WU0xNWTgy?=
 =?utf-8?B?U2x1VVEyWUtXVCsrbmtDUWVHcDNUd2h0YnUvenV2bk9MMEFmM0pZdFpKSzRs?=
 =?utf-8?B?eG8zWWg3YkI3a290WVhNK3JiTlo1a2NEcHkvU0hRMWdVSkJTd21KZmdVUTc3?=
 =?utf-8?B?VDVaKzZLaHNUZHRvYWpYckNOWHE3ZkFESGZDRU5peE9KMkY5RnBENXNoakMz?=
 =?utf-8?B?NHp1aG9MR3E1bkpTT0E4UmhDQ3pnblRnUEFBNEdGcTFVYjFmSWtvMkJ6Vnk4?=
 =?utf-8?B?anBGVWtaNFYwcVhRSnhXam9STVFHR0lLWDBBWXZmS0crWlUzOXdLa0JvZkg3?=
 =?utf-8?B?SmdhUE9NeEdZWG1MTEp2NVJ1NkJSanJsQ3hlWnRjbEpmVE50V0VpMHNLMUNY?=
 =?utf-8?B?M3pweHdwemxMdnJOQzJCRzRvYjd2RUNpOE1DMEExZi9RbkJJUnJQNTVodEFn?=
 =?utf-8?B?cDl2WGtEUGg5ZUJNWmFHeGdyVk9XcWpUcVpFR21xWHBhV3Yra21pSWhJUXJV?=
 =?utf-8?B?OEo5RHc2UjRUY3dOUDl6d25UYkRldC9ScnVKSXJwREJGTml2aDUzWE9yS05R?=
 =?utf-8?B?ZHlkZkdEWkgwenhVME8vMGVwcWN1cDA4OTJidTJpaTZ1NVVYSTFqNzVuZmw5?=
 =?utf-8?B?NlkydzlIdndLQ3hsSlZ5MEV3VG1LajJtN25sT2JZMWtpSG9DSGVtcU9kdXlh?=
 =?utf-8?B?WWpGZ0NOUXo0c3pSNVp2M2M1TTFPN0RQaSt3amM5QTFOU3Y1YVc5dnhUZkhF?=
 =?utf-8?B?bi9EYk00Y0NWcTBhVHY0RVVxRjd4NEhlSjMxVlY2VHQwT3dvWi9Ha2hIWW1D?=
 =?utf-8?B?c2lESTl6SWRNaUNJenBDZ2Zsb1pCZHN2R1UwK3NMaTNmdGhVbndLcktrTGtP?=
 =?utf-8?B?VmhjVVU0N3RrWlhteDU5RTZxTmQ1ZFhUYW4xSFVKTUswUXZYOEtEak9sRkdy?=
 =?utf-8?B?M2lFUHVEbDYveXMzQ3hkcXNJcjBVQWc1ZFZ1ZkwwSmlTMFVpTGVpa1YyTmM3?=
 =?utf-8?B?aVNlN1Z3ZSs4WUFEQlJ4Qy9aWTlEUGR4bWk2bGtEYkhTZlJHWURlRm4vNkRx?=
 =?utf-8?B?OUx5aTl0MUhrejB0MFp2Smpxa3FzOGsrU0FzR1hqWGxkZkV4N1VvOHlXK29D?=
 =?utf-8?B?ZWN5QUxQQnBhSHFEbjhMbzZKTFJYcUN3OU54RGN2bUFHR0Noc3kzcjBGbTk1?=
 =?utf-8?B?NzBhVUwrMnptSnowZ0JlbmRBcGlhQys5UmFvQldFTHF4SkI1SGFMb2ozb3k0?=
 =?utf-8?B?UXRDMDEyekRkTGNCNjZPU0hNZ0hRUVJyQVJQZWJPU2N0cmtCL2ZNK01oUExB?=
 =?utf-8?B?SGNBWU1oTTZONnFsYW9oKzdUNnc0dXJXc3RKWlBZOUxZYnpPV2VYdk52Tkds?=
 =?utf-8?B?aCtkbHh6TDRMQXcwUGMyTk9FV3lFTDRFV2RWUTdPdE5jc3FlbWJKSmdDbEVW?=
 =?utf-8?B?c1U4UXQ3MTJ3RG1LbnB3WWxOSDhDZ05pODdlRzlSOExGbEhkVXJzQT09?=
X-Exchange-RoutingPolicyChecked: SYHVasaf+IZyyruEEs+GTVUFI/lXLUxZDU13IQju54L3XwHqyLbP+Pi2vd+1BagoMX7MEuBZbRcg0v1Yn+rIuZGO1lNQGTMWeKhmXMWxYcuuO0nMCP0b67f/SyWWorcZBu3V7qjMNz0iHjR9nSkY/sOXKToHVlp00ylLNHS5jvMu6n2BAvemSxG3krqaHPZPII2lHRmQ3dfKnXDhnc514rhrgfCCQGPn31rRNXXqlvdnwv4bDqwFjtuBinyLk7UNixwb+w9j+I1a9WpxEd1J0uCRDgw3R4tw0U/W94WWKHQqTiT6ahpXtw3RXEls4iUJ2r5XyPLg/m5uHnWTXIYj5Q==
X-MS-Exchange-CrossTenant-Network-Message-Id: 530d4c1e-cc16-43b3-af2c-08dea576a98b
X-MS-Exchange-CrossTenant-AuthSource: DM4PR84MB3970.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2026 22:37:00.3029
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y66UEH/wd4wjFqQ5YfJPnTYMxnVjPycsUG3YisZrwj82PYLavdY/8iaEsuGfzYZtwSftHvmLWaZ+B7bI1NkYcQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR84MB1913
X-OriginatorOrg: hpe.com
X-Proofpoint-ORIG-GUID: GVPCpImYpcCy0LBB6kqFUp9aZFlO7yfg
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI4MDIyMiBTYWx0ZWRfX62jc19aXNDK7
 sYq1uzrVZGMND3j9RjrLl/yadjWW0pg5Fq/UKLHDHOpwMKnil7WIXH2Z3EDKg4TCHRHffkfnTO5
 Fm7GpvFB4SJw1dyVG1nOYTNFqQdmI3Z4KGQaT+mPuYpYOZhzRotT167w9rSMeeqWZfpl0nTLyR6
 //pTZUmKVyK5rS6i/nkEgKDVHC6+sLT4oFBKHi2oXYv5tfuXrDR3G3XFZfA6shSHIVxGlaK0p9E
 E57k6noU7x2keiJX8isWMlsz53FikhMBFwSqfHDj+qBGdBQ9O09YT/PqMDX/GCU3X4Rqhu/Lfx2
 eTD4iehMDZ/mMTUoDFuQm1o44yYHkivzAku6gehSjbr7vbBKAZXSHi53YparF5JeFDj010Km1ec
 0VJzbPgBaABizrs3lAjAvQfgQ1N6sUwGmq8ylf+P5OThJC2ge/Eaetc+IDsf1PxKOFKXe7jJARr
 f4a5kAXGRPjwlKrVzxA==
X-Proofpoint-GUID: GVPCpImYpcCy0LBB6kqFUp9aZFlO7yfg
X-Authority-Analysis: v=2.4 cv=a7cAM0SF c=1 sm=1 tr=0 ts=69f1369e cx=c_pps
 a=5jkVtQsCUlC8zk5UhkBgHg==:117 a=5jkVtQsCUlC8zk5UhkBgHg==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=A5OVakUREuEA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=gQcMVamqm3wCPoSYhaRC:22 a=RtSn8ETxjE2H05FtM2s8:22
 a=NEAV23lmAAAA:8 a=VwQbUJbxAAAA:8 a=vggBfdFIAAAA:8 a=MvuuwTCpAAAA:8
 a=F2YLD8dTl0QlYodOkhIA:9 a=QEXdDO2ut3YA:10 a=TMJTcb2WF2LcSSRGUBAA:9
 a=FfaGCDsud1wA:10
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-28_05,2026-04-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 priorityscore=1501 impostorscore=0 malwarescore=0
 spamscore=0 phishscore=0 adultscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604280222
X-Rspamd-Queue-Id: 2117148CA92
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[hpe.com,reject];
	R_DKIM_ALLOW(-0.20)[hpe.com:s=pps0720];
	MIME_GOOD(-0.20)[multipart/signed,multipart/mixed,text/plain];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-19700-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+,1:+,2:+,3:~];
	HAS_ORG_HEADER(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	HAS_ATTACHMENT(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FROM_NEQ_ENVFROM(0.00)[doug.ledford@hpe.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[hpe.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_SEVEN(0.00)[7];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[11]

--------------sKQEuyJXy0Tf1AfSndWvVlwt
Content-Type: multipart/mixed; boundary="------------QYWDgRBqqJgLXYjqC5yoF17v";
 protected-headers="v1"
Message-ID: <d0cbdd01-87e2-4a36-8b34-97445f9f8f2b@hpe.com>
Date: Tue, 28 Apr 2026 16:36:57 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-next v2 0/5] Introduce Completion Counters
To: Michael Margolin <mrgolin@amazon.com>, jgg@nvidia.com, leon@kernel.org,
 linux-rdma@vger.kernel.org
Cc: sleybo@amazon.com, matua@amazon.com, gal.pressman@linux.dev
References: <20260416212327.18191-1-mrgolin@amazon.com>
Content-Language: en-US
From: Doug Ledford <doug.ledford@hpe.com>
Organization: Hewlett Packard Enterprise
In-Reply-To: <20260416212327.18191-1-mrgolin@amazon.com>

--------------QYWDgRBqqJgLXYjqC5yoF17v
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gNC8xNi8yNiA0OjIzIFBNLCBNaWNoYWVsIE1hcmdvbGluIHdyb3RlOg0KPiBBZGQgY29y
ZSBpbmZyYXN0cnVjdHVyZSBmb3IgQ29tcGxldGlvbiBDb3VudGVycywgYSBsaWdodC13ZWln
aHQNCj4gYWx0ZXJuYXRpdmUgdG8gcG9sbGluZyBDUSBmb3IgdHJhY2tpbmcgb3BlcmF0aW9u
IGNvbXBsZXRpb25zLiBUaGUNCj4gcmVsYXRlZCByZG1hLWNvcmUgaW50ZXJmYWNlIHByb3Bv
c2FsIGlzIGxpbmtlZCBpbiBbMV0uDQo+IA0KPiBEZWZpbmUgdGhlIFVWRVJCU19PQkpFQ1Rf
Q09NUF9DTlRSIGlvY3RsIG9iamVjdCB3aXRoIGNyZWF0ZSwgZGVzdHJveSwNCj4gc2V0LCBp
bmMgYW5kIHJlYWQgbWV0aG9kcyBmb3IgYm90aCBzdWNjZXNzIGFuZCBlcnJvciBjb3VudGVy
cy4gQWRkIGENCj4gUVAgYXR0YWNoIG1ldGhvZCBvbiB0aGUgUVAgb2JqZWN0IHRvIGFzc29j
aWF0ZSBhIGNvbXBsZXRpb24gY291bnRlcg0KPiB3aXRoIGEgcXVldWUgcGFpci4NCj4gDQo+
IENvbXBsZXRpb24gQ291bnRlcnMgY2FuIGJlIGJhY2tlZCBieSB1c2VyLXByb3ZpZGVkIFZB
IG9yIGRtYWJ1ZiBvciBieQ0KPiBpbnRlcm5hbCBkZXZpY2UvZHJpdmVyIG1lbW9yeS4gQ29t
bW9uIGNvbW1hbmQgaW5mcmFzdHJ1Y3R1cmUgYWxsb3dzIGFueQ0KPiBvZiB0aGUgaW1wbGVt
ZW50YXRpb25zIHRvIHN1cHBvcnQgdGhlIHZhcmlvdXMgZGV2aWNlIGNhcGFiaWxpdGllcy4N
Cj4gDQo+IEFkZCBFRkEgQ29tcGxldGlvbiBDb3VudGVycyBzdXBwb3J0IGFzIGZpcnN0IGlt
cGxlbWVudGVyLg0KPiANCj4gWzFdIGh0dHBzOi8vZ2l0aHViLmNvbS9saW51eC1yZG1hL3Jk
bWEtY29yZS9wdWxsLzE3MDENCj4gDQo+IC0tLQ0KPiBDaGFuZ2VzIGluIHYyOg0KPiAtIFVu
aXRlZCBzZXQsIGluYyBhbmQgcmVhZCBmbG93cyBmb3Igc3VjY2Vzc2Z1bCBhbmQgZXJyb3Ig
Y29tcGxldGlvbnMNCj4gICAgY291bnRlcnMNCj4gLSBBZGRlZCBjb21wX2NudHIgdXNhZ2Ug
Y291bnQNCj4gLSBNaW5vciBjbGVhbnVwcw0KPiAtIExpbmsgdG8gdjE6IGh0dHBzOi8vbG9y
ZS5rZXJuZWwub3JnL2FsbC8yMDI2MDQwNzExNTQyNC4xMzM1OS0xLW1yZ29saW5AYW1hem9u
LmNvbS8NCj4gDQo+IE1pY2hhZWwgTWFyZ29saW4gKDUpOg0KPiAgICBSRE1BL2NvcmU6IEFk
ZCBDb21wbGV0aW9uIENvdW50ZXJzIHN1cHBvcnQNCj4gICAgUkRNQS9jb3JlOiBQcmV2ZW50
IGRlc3Ryb3lpbmcgaW4tdXNlIGNvbXBsZXRpb24gY291bnRlcnMNCj4gICAgUkRNQS9jb3Jl
OiBBZGQgQ29tcGxldGlvbiBDb3VudGVycyB0byByZXNvdXJjZSB0cmFja2luZw0KPiAgICBS
RE1BL2VmYTogVXBkYXRlIGRldmljZSBpbnRlcmZhY2UNCj4gICAgUkRNQS9lZmE6IEFkZCBD
b21wbGV0aW9uIENvdW50ZXJzIHN1cHBvcnQNCj4gDQo+ICAgZHJpdmVycy9pbmZpbmliYW5k
L2NvcmUvTWFrZWZpbGUgICAgICAgICAgICAgIHwgICAxICsNCj4gICBkcml2ZXJzL2luZmlu
aWJhbmQvY29yZS9kZXZpY2UuYyAgICAgICAgICAgICAgfCAgIDcgKw0KPiAgIGRyaXZlcnMv
aW5maW5pYmFuZC9jb3JlL25sZGV2LmMgICAgICAgICAgICAgICB8ICAgMSArDQo+ICAgZHJp
dmVycy9pbmZpbmliYW5kL2NvcmUvcmRtYV9jb3JlLmggICAgICAgICAgIHwgICAxICsNCj4g
ICBkcml2ZXJzL2luZmluaWJhbmQvY29yZS9yZXN0cmFjay5jICAgICAgICAgICAgfCAgIDIg
Kw0KPiAgIGRyaXZlcnMvaW5maW5pYmFuZC9jb3JlL3V2ZXJic19jbWQuYyAgICAgICAgICB8
ICAgMSArDQo+ICAgLi4uL2NvcmUvdXZlcmJzX3N0ZF90eXBlc19jb21wX2NudHIuYyAgICAg
ICAgIHwgMjk5ICsrKysrKysrKysrKysrKysrKw0KPiAgIGRyaXZlcnMvaW5maW5pYmFuZC9j
b3JlL3V2ZXJic19zdGRfdHlwZXNfcXAuYyB8ICA2NSArKystDQo+ICAgZHJpdmVycy9pbmZp
bmliYW5kL2NvcmUvdXZlcmJzX3VhcGkuYyAgICAgICAgIHwgICAxICsNCj4gICBkcml2ZXJz
L2luZmluaWJhbmQvY29yZS92ZXJicy5jICAgICAgICAgICAgICAgfCAgIDEgKw0KPiAgIGRy
aXZlcnMvaW5maW5pYmFuZC9ody9lZmEvZWZhLmggICAgICAgICAgICAgICB8ICAxMyArDQo+
ICAgLi4uL2luZmluaWJhbmQvaHcvZWZhL2VmYV9hZG1pbl9jbWRzX2RlZnMuaCAgIHwgMTg1
ICsrKysrKysrKystDQo+ICAgZHJpdmVycy9pbmZpbmliYW5kL2h3L2VmYS9lZmFfY29tX2Nt
ZC5jICAgICAgIHwgMTA2ICsrKysrKysNCj4gICBkcml2ZXJzL2luZmluaWJhbmQvaHcvZWZh
L2VmYV9jb21fY21kLmggICAgICAgfCAgMzYgKysrDQo+ICAgZHJpdmVycy9pbmZpbmliYW5k
L2h3L2VmYS9lZmFfaW9fZGVmcy5oICAgICAgIHwgIDYyICsrKy0NCj4gICBkcml2ZXJzL2lu
ZmluaWJhbmQvaHcvZWZhL2VmYV9tYWluLmMgICAgICAgICAgfCAgIDYgKw0KPiAgIGRyaXZl
cnMvaW5maW5pYmFuZC9ody9lZmEvZWZhX3ZlcmJzLmMgICAgICAgICB8IDE3MSArKysrKysr
KysrDQo+ICAgaW5jbHVkZS9yZG1hL2liX3ZlcmJzLmggICAgICAgICAgICAgICAgICAgICAg
IHwgIDQxICsrKw0KPiAgIGluY2x1ZGUvcmRtYS9yZXN0cmFjay5oICAgICAgICAgICAgICAg
ICAgICAgICB8ICAgNCArDQo+ICAgaW5jbHVkZS91YXBpL3JkbWEvZWZhLWFiaS5oICAgICAg
ICAgICAgICAgICAgIHwgICAxICsNCj4gICBpbmNsdWRlL3VhcGkvcmRtYS9pYl91c2VyX2lv
Y3RsX2NtZHMuaCAgICAgICAgfCAgNTAgKysrDQo+ICAgaW5jbHVkZS91YXBpL3JkbWEvaWJf
dXNlcl9pb2N0bF92ZXJicy5oICAgICAgIHwgIDE0ICsNCj4gICBpbmNsdWRlL3VhcGkvcmRt
YS9pYl91c2VyX3ZlcmJzLmggICAgICAgICAgICAgfCAgIDIgKy0NCj4gICAyMyBmaWxlcyBj
aGFuZ2VkLCAxMDYzIGluc2VydGlvbnMoKyksIDcgZGVsZXRpb25zKC0pDQo+ICAgY3JlYXRl
IG1vZGUgMTAwNjQ0IGRyaXZlcnMvaW5maW5pYmFuZC9jb3JlL3V2ZXJic19zdGRfdHlwZXNf
Y29tcF9jbnRyLmMNCj4gDQoNCkFwb2xvZ2llcywgbXkgbGFzdCBlbWFpbCBJIHNlbGVjdGVk
IHRoZSB3cm9uZyBjb3ZlciBsZXR0ZXIuICBJIGtuZXcgdGhhdCANCnYyIHdhcyBvdXQgYW5k
IEkgaGFkIGludGVuZGVkIHRvIGNvbW1lbnQgb24gaXQgKGFuZCBJIGhhZCBhbHJlYWR5IA0K
Y2hlY2tlZCBhbmQgZGlkbid0IHNlZSB0aGlzIGluIHRoZSA3LjEgd2luZG93IG1lcmdlIHJl
cXVlc3QpLg0KDQpTbywganVzdCB0byBtYWtlIHN1cmUgbXkgY29tbWVudCBpcyBpbiB0aGUg
cmlnaHQgdGhyZWFkIGZvciB0cmFja2luZyANCnRvb2xzIHRvIHByb2Nlc3MsIHdlIGhhdmUg
aGFyZHdhcmUgY291bnRlcnMgYW5kIGlmIHRoaXMgaXNuJ3QgYWxyZWFkeSANCm1lcmdlZCwg
dGhlbiBJJ2xsIHByaW9yaXRpemUgbWFraW5nIHN1cmUgdGhpcyBBUEkgd2lsbCB3b3JrIHJl
YXNvbmFibHkgDQpmb3Igb3VyIGhhcmR3YXJlIHRvby4NCg0KLS0gDQpEb3VnIExlZGZvcmQg
PGRvdWcubGVkZm9yZEBocGUuY29tPg0KICAgICBHUEcgS2V5SUQ6IEI4MjZBMzMzMEU1NzJG
REQNCiAgICAgS2V5IGZpbmdlcnByaW50ID0gQUU2QiAxQkRBIDEyMkIgMjNCNCAyNjVCICAx
Mjc0IEI4MjYgQTMzMyAwRTU3IDJGREQNCg==

--------------QYWDgRBqqJgLXYjqC5yoF17v--

--------------sKQEuyJXy0Tf1AfSndWvVlwt
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEErmsb2hIrI7QmWxJ0uCajMw5XL90FAmnxNokFAwAAAAAACgkQuCajMw5XL91Y
MxAAkNoTVghJVdqgY5bpF6XvbjohAbPENB0CsIcu10ep61vTNSyIVfc1vok93t0MgKI4sNdYnzvO
CiU3tl4Hh6l34PApkUTprNN/XQ82AAp6xB4vQmKc0TiLZj/E2hyeVv8Lo4Rw6cXaQBSXgmMuWTml
OUaffXVM4zG5hL5nH7abEdYZ/5bDMWUZ+35hCZ0OtdOxkMkHoAJTVSjiVdCMoaHo43+WUkQWbvWk
j0lRXc4KyLIfhiOq71nZeRH6M87kiahk/UE2saRJkDVW3CrAPdDTS+mhjHGUL9nlRK5TJ3LVlRFU
mnSGSkGHd7oPz5BauUswWI/a4AkdrNhg3oYELdj6O2r+c3vNElDyS8P9Zwp0JbuM84Tuanp7tXgC
dS7rKLssY303N/1ew9NlRaWBCvaNOw29lZ2fpageOh0YA+oRgWAMnGCzPKx1HrSarjdi7SnKAsCE
TL+whHEB3I0NkpINWzP+xYgb6j2IoaAFxlfiQpApv9ZYiloZOkCnrBOmxMwcYbIRc1KDAXg0Ddq2
VKvvHu/ZSNeihONLAWpmEXSmN3NTzw9MhMZRAGiA02VXYec8ksvQwlyNjh/ZqF7IEj/YUp2Wh1zt
Sqnb7C/h5+hNzAfmjOboBUl808yr+l3JzJW6IOjt6tk1KORTZKsf+0lN/KBXV+hjHkh/hzxbzh3u
2Sg=
=Ya+V
-----END PGP SIGNATURE-----

--------------sKQEuyJXy0Tf1AfSndWvVlwt--

