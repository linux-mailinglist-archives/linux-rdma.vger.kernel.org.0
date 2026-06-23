Return-Path: <linux-rdma+bounces-22436-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id i6XuOQjIOmogGwgAu9opvQ
	(envelope-from <linux-rdma+bounces-22436-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 23 Jun 2026 19:53:12 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5797D6B9433
	for <lists+linux-rdma@lfdr.de>; Tue, 23 Jun 2026 19:53:12 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=oracle.com header.s=corp-2025-04-25 header.b=JttT30g8;
	dkim=pass header.d=oracle.onmicrosoft.com header.s=selector2-oracle-onmicrosoft-com header.b=cBbiJbCh;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22436-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22436-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=oracle.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 22B5F3065191
	for <lists+linux-rdma@lfdr.de>; Tue, 23 Jun 2026 17:51:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0D673909A2;
	Tue, 23 Jun 2026 17:51:38 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 064E43905EB;
	Tue, 23 Jun 2026 17:51:36 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782237098; cv=fail; b=QZgDA00JgjsWF7qdr4mqOoGXO87Yr/LqUwJ0B1g0V1nvLfLx5KLH+KCrrKAzAjKTciYMxu+UZVIpHctoZLG2brgtWvZ1rsZqgHa0QlTWWa4m3u/77ZfCLM8GwJZmSv2XJAjZPSUc7+KCsKVNx+2VvwakbyUrxbWhx5HbnwBhFB4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782237098; c=relaxed/simple;
	bh=SNRbpilPwizjUxP5eTVNOvz3oFhwe5HN5dthywbo4QA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=BFOdswSsIJ644T8jKsNtwPlGx84en5hE12vbWLqx4dORmskagCeZS1D59GMqg3xc3PHMylYjnde17W8kEsuOezAyS9hc/VyuFJHbo6ihmB0YhpxykS4bjFOzmbNvf3BRLbQeIfow7R04QXohxv9VvMLOrVc0pmzW/OBBXvsAkhE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=JttT30g8; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=cBbiJbCh; arc=fail smtp.client-ip=205.220.177.32
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65NEBpde196246;
	Tue, 23 Jun 2026 17:51:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=qXoY1Prt+81pz/100NaPiv8GJiIPAZQS2MWXFj1br1Y=; b=
	JttT30g8DG7goh8eWNSQSGqozQA7UK68uKDwyhRQzq1Jm7KfvwuVuoJ6CV7tIqJi
	m3neqb+k1/gtT5s22Mg5gYxmRl/V1Pjn7aKo/jq2YQjpz/d7gO6lTLALscsX4NNF
	a47Ls1efWHF8vOtPVkfzKY4fUp4ocos2cMlo1OVIQGGOm2oA+gAmzb6MCyC/iO+R
	2rliCB3wFhiSeq7QcwdeQaggt9J0whF1mwRdaBl8xZgcvVDftItV5Rfv+QCi78KA
	dwgDB7y98dGyKv4a+0310AVY823qxkyNIzb9TtnmvTbNC9dPXTcvPH64Th1nD2WP
	6QB6YMkbEqs87OPBEE4NLg==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4ewjwcc54f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 23 Jun 2026 17:51:25 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 65NHhqHu022831;
	Tue, 23 Jun 2026 17:51:25 GMT
Received: from ph0pr06cu001.outbound.protection.outlook.com (mail-westus3azon11011025.outbound.protection.outlook.com [40.107.208.25])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4ewhaqdsr5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 23 Jun 2026 17:51:25 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RJ0VJHPJXQNFnz/r0LsJPIpemVyCYXClWQ5Y6sUPmf69JByvg9gNJqIJ+px+WvjXrbfSORpxwVUojjEFzUcSX4isAaq6C2RCSbeQjyI35QsTLwSSmJi2kjW6QxqkX2sVp0RDRAIhJ3fVRE8X0QF7q7oFF0c9syzFPks7Y+iEOAVt5OMNVMYq15ijCaXkw+al3KJgfoNMbElFdAZdM127INcBrqu5LbNufJs0YoZk8FndPIKsVlL8DWtVNME48bLs0jnLBpN2jR7iipyN2kbMrDf+HbUE0XjuPq92wacR9WbgPYa/OmTOvX4lqznqNUxz5PVVLlyPT0ze9+xT53Ufsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qXoY1Prt+81pz/100NaPiv8GJiIPAZQS2MWXFj1br1Y=;
 b=Eox8kOTQf0EAkZNoioZd2FCnaZvMrSRMWNIXA9ewdxOid8phZM/+oF1RtxiU1kase2XAZXwH2n8JNlhakEW16RufmsELp/ZzQrwqLV0/RwKsaMqQpGjN5DTEm3JfSKPlRtLY3zYfaXRhPE4SYl1Cruxlvz1bLzJqiI149yldnu9ktYIVRC9nBXieqjfVsTQQ2G8DHEfluix029hNPumrEvIltT16BFHteL/Qk2vNkeQzHsEmO45d3wTj8RuMyvYIktlIvdodM2KN3H3IT1vGtzA2VhfPC0MQI5LrJCEnbFkHDqPYJMC7ezzwhGioLzI2KxJ4WXkVvmkJVa7z004PaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qXoY1Prt+81pz/100NaPiv8GJiIPAZQS2MWXFj1br1Y=;
 b=cBbiJbChXW7s3gLqJHARmJQXxXBCl35F/XaYw2UtrQ3cO2PnTL8lMF41zZWz3Bm05Z69I/TfseBfAeqVyv4pqE3kqrwBhbACu98Sl5p86F6T3muk1X0GNa01TLBnlt5QZAfQP5Rq4VJXDyIfxXtgIRozTUPDh+X59ssU7t6A5Rc=
Received: from LV3PR10MB7796.namprd10.prod.outlook.com (2603:10b6:408:1ae::6)
 by SJ2PR10MB7617.namprd10.prod.outlook.com (2603:10b6:a03:545::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.20; Tue, 23 Jun
 2026 17:51:21 +0000
Received: from LV3PR10MB7796.namprd10.prod.outlook.com
 ([fe80::a30e:ee88:c7b4:c0d8]) by LV3PR10MB7796.namprd10.prod.outlook.com
 ([fe80::a30e:ee88:c7b4:c0d8%4]) with mapi id 15.21.0159.012; Tue, 23 Jun 2026
 17:51:21 +0000
Message-ID: <f5bbe6d4-b0a8-414c-bdbc-5dd169a64c2b@oracle.com>
Date: Tue, 23 Jun 2026 10:51:17 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net/mlx5e: Use sender devcom for MPV master-up
To: Tariq Toukan <tariqt@nvidia.com>, Saeed Mahameed <saeedm@nvidia.com>,
        Mark Bloch <mbloch@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
        netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Patrisious Haddad <phaddad@nvidia.com>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260610173915.4053423-1-manjunath.b.patil@oracle.com>
 <293db0b4-f308-469e-99c1-ef1b57d41451@nvidia.com>
Content-Language: en-US
From: manjunath.b.patil@oracle.com
In-Reply-To: <293db0b4-f308-469e-99c1-ef1b57d41451@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PH0PR07CA0096.namprd07.prod.outlook.com
 (2603:10b6:510:4::11) To LV3PR10MB7796.namprd10.prod.outlook.com
 (2603:10b6:408:1ae::6)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR10MB7796:EE_|SJ2PR10MB7617:EE_
X-MS-Office365-Filtering-Correlation-Id: 710918ba-e312-40c1-9eb1-08ded15008ec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|23010399003|366016|6133799003|22082099003|18002099003|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info:
	uh65djN4IiI+vSZT66531PujQvu5h7dVlndzCQ4IoDs2OKRHopVfRs+cyvBlo5/5GMx0ykTDkaSYXeHPFs77SsJn1dHtZu3EbagiJvRGvxzxPyEQGt+nxyFzdsA0uXk+AVDGeo5ZGBCEd6UHoltZAJMJ7t4T3nNxRdvPbDh/+4kpDjOzFrcFHYd8ir+V264OdT57oLYXDMgoR7riJWY3BRMQv5b9cMV6drIvWuAKjUDFd8/VgOSOuWX5BeYeVxThJFY9pfB7G/vwdld3lqATFGbygiB5L08PwpDRVAhCwxwyrHoD87auO8XospqSt4yBgbkrPrBUDM/QA8Nci4Dg2kUWw0yLLzC6o2MU+NyyKqmQIjy9AtY4YCqvGQwArxTAa2DRFzuexyiVjmfZ7QjvESx/t7R6MzrINfHaEoKC+LHW+2S/T/BXzNVfSMqkm2ZKa0BTIgoti+2ghp5VNxD5/gAbxEbpi6+A/w4ARaAJNONsZK4t4SVQapEvf8XWB3Qr4ISuDoZDAhMSEiuW7zdsPqfQP1vwJlEgv2Bo1hFQA2L2jyLDSZK0AHNJgdyp8kHfwNeya9fwd0F3FzBHWhzUjkz9HeAmywHmDc/AoNuVHqlV1PZ98+xQsq8G6gqMKDOzpWPiNYQmm/oVhfjEwzVSn7PzPAW7mmqIG7EPeNlk8l8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR10MB7796.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(23010399003)(366016)(6133799003)(22082099003)(18002099003)(4143699003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TmFaaGRXVVJPUEhXb3kxRTdZSXNENXU3SHVmYVA5L2FJeVgzSzhYMFRlNVNx?=
 =?utf-8?B?UHJGWlJSZVJhdk1mdWJXQmt3eVB4K0FzTHlBaGNSRUMvSFBpcnpGaWRvNFRq?=
 =?utf-8?B?aUZZbFFZQytNeXJhSVk3dFdpVTJGMkNyWGM0amJPZDRlV2J3a1NieGd5ZzVD?=
 =?utf-8?B?ODlCd0pPRkw3eFUyaWZzSmhYMzN5T1NjbGRsTmhBSUhwU2loS3VnMmpIdmxw?=
 =?utf-8?B?TGYxWitNU0orRm5FUExGaE9KSTZ5WVcrczdxQ0VvZWM1VFgxam81RTRFblVV?=
 =?utf-8?B?M3hqQzRHaEtKaDcxaWU0emQ5ZDVjbGtESUw3QlNtdTFzbGp2MGd5dzI4bWpJ?=
 =?utf-8?B?MVpNb0poaWRiN1RmeWxobWM1OU5YOHRUdG1YdEdnZ1k2dkdZNVRZb0h2ZWxo?=
 =?utf-8?B?U0xwRVFKTXBOMklxU0V3ZmFCclROWFhWWjRTTmJ4RTZ5MjNhY1d0QTVUYWF4?=
 =?utf-8?B?cldldjNkZjN6dWRNaHMyNDF6YUUwQitVVGNTT2JjQXlwQzkwaVd4TXg4cm5z?=
 =?utf-8?B?TTNZUk1JY3U0UmtoK2NUaU1JU2s4ZnJsbG03WTl1aS92RlpWOFhBTUhoVXJt?=
 =?utf-8?B?RUcwTXR0a1I3aFp4azNpR004N1RMNmFtcS9ycE0rTEhZVldpTDhDM0UrSVJy?=
 =?utf-8?B?OENGcjByTWIrY1pXWmxDaHpWNHlpNUYwZEM3Mnp5NnNjeGdUbFhJR1ZhcE9T?=
 =?utf-8?B?WU1zVFFyaEpqejZncW40cmt1T1dFdE5JL25QQmN5dFdZTmN3ZDI4ZHlFSnpO?=
 =?utf-8?B?RGlYS1M0dm9IZlplaWJlMzZ6UkFjZ1lmREJlb29ERVVyeU9RemlwclpoSEhv?=
 =?utf-8?B?ZWlmUnB1S0dlYlFqR2J5cmZ5b0R3R1lKaUw5Z0hTbUpRZGh1TWx4ZUFYZWtn?=
 =?utf-8?B?TXVBTzlhQmxVYU5PL21STlFoRjB6TkJIOUNhczZHYjJCMXhyZlBMWGJsS1RM?=
 =?utf-8?B?TGtYdkNpS1orYjg0THB6ek93MXI2T0xJYmxQRGp4bmNrUGY1eGFJbit1dkJ5?=
 =?utf-8?B?ZWE1d2haaDI0bDQ5YThDSDEvaHlRTmRhK3lVRExHTDZiWW1tT1R3WTVzWC94?=
 =?utf-8?B?bUx6L3J3cXJmNGxZMVZZeGduL3BhOWtYYndIK3FaMktXZG5OdnpSdnJBemJ4?=
 =?utf-8?B?RnZWV3dYNm9mUWg2YXRWT2VBU0Ftcmw0ZXZyOE51K0k2Y3ZLVS90UnU1L3Jh?=
 =?utf-8?B?aGhLelRTNkdmNTcxS0NDSmRkLzhKYVJDVkQ1eTkzR2VaUmFsbzB3a0FUTFFI?=
 =?utf-8?B?SDM4M2JmRCtrQnZnWHVNWTJ1b0pvdkRGU0ZGMkhQUXJTWklKSHA4Rmtud0Vk?=
 =?utf-8?B?ZlU5ZnpJT0FUUDVQQ1NuSTRmSDBTTFZCV0hOZWtONWxGamhqOG9WVlkvUE92?=
 =?utf-8?B?cFhEV0lFeGpwR1RiMnQ5UWhqZFY3WTR3bm5US0h0dDZUMXhWalZrQzVLbkZ1?=
 =?utf-8?B?YkozWHZzaE9PdFVkRCsrT29VdTRLNUNaOVhaZWt1SVVwRlYrMldFVnIrUkZT?=
 =?utf-8?B?Wk5hd2N4YWdTZ0I1K2dsK1pxMVFNdnhraHRoYVFLL2luQ01aM04wb0FXaHJ5?=
 =?utf-8?B?UFFlN0k3VHBHVHUxVWxrd0xGcHlkNW5DRWk0cG1TK2NTZlF2cEU2UHpPdzlR?=
 =?utf-8?B?cGhpd1h4cE01ejU2QStrcmlLOTlrd2YraUdhRFJGTVR6aWtvS3l5bndJditq?=
 =?utf-8?B?L3ZvaExleU42dzRyYlUrQTJVWmlIUEJRcFJtL0dGY0JBVTc5MFJHOFJGNlVn?=
 =?utf-8?B?dksrMFRjc3N5VmxlNkxIQnVFeCtxRzBFamxWZTZKcDkyYVh6aFpKQVJXeWtQ?=
 =?utf-8?B?UkFoUlZWaldiK1U2VjNTcFRvWnlNdmd5Wnc3YzIrM3NSLzVZVnc5Z3NIZTQ4?=
 =?utf-8?B?OC9lZ3d0dkkzSGMwKzMrZ1FFa09aTDUzN3VNMGFtOUxLMG4zcHBBNEFFeXFU?=
 =?utf-8?B?akhqR1VURjNnckRTVTRpU1E1Rklxem45R2k3Q2FPc0ZlL0g0M0YrV2pmVFhH?=
 =?utf-8?B?K2xidFpVZmpocjZZVVFNQzdSOWo3ZitlNkdHby93bEtmbVBldEdiSVpVMWZo?=
 =?utf-8?B?ZEJweEcyMnRySUM3bUpnM3Y4eE84R2dMaDJUTjErZUhLZEVSZENaWmVsQy9K?=
 =?utf-8?B?VGFRc3dzM1M3ZllSVXRuOHJhY05IQmIwVVdocGZqTTN1Wi9HWG11aFRXTjh0?=
 =?utf-8?B?SkdvcFpPSm1aMG43enU5ZWllQXluWnBFU1A3VXI5VWdsREZyWmZUS3VGUzZM?=
 =?utf-8?B?YXM0UVM3S1J3amdBTlozOTU3QUwwTHp5Ulc3Uzd4OXdJT1pCbDhYTks2UHB2?=
 =?utf-8?B?eDRjWmFqeHRNb2VFZWJCbmxUcmpTc0N1bVZlM1I1T3ZQTjZtdkhRNXh1bU9G?=
 =?utf-8?Q?Fik0wKQaFbz8Cf2M=3D?=
X-Exchange-RoutingPolicyChecked:
	QPd/GHC540ZPplniigKt8HUyyj7Kury5lgQXruupfuaKGt0e6CnVGz7fFIJMVKSUKvm1Lt3N0V0X63y+lZevfs7DOC/Zo0tY61y/YGvtTAboN2ihL2r0hRGTtv765b+tEsNBhKeOdZqhmxAQpV/hRd7yzH5QEfMowasGQIP1A3mSjOXWDagdNfKOJ2a4W+ObjamPYk3ysXfpGH8Mpi2FmfcFPj8jtVOkeIjMmTkI0ZdjR1Bmel0LkR2rdS4HaHulUwoxad8MZfNNrkmQSebTlglbKGmiESmXjv00hSk3l7zsUSRYhCMZJWLByuVa0e429StRD5e3ENtfdAV4kaj6Vw==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	zpNsVNI8gnPmfcemP0S8kMzZbDcYlzy6OMeWUf4qEiUk9foL4BJ5jwvBbo+HQu3TH4+lsNLAxbuG202uGNpwIOsEev+i3pC8cb/hqV7XZ0sGFloF2C4tr0lPkGtFDkZceKSDiwXV2BVDWuigkX7BVTwjtEGcApUnGXTbYgitI/UEPVS7zUV1x1p8kmGxkdkNeyDQtjPyA/YqxEi8oAhJUD8E+3HnLmITLfyP84wzhmP9370haJAh1FCcdiqh230QHg46PZ3rzm/bP1YT7k64zUt+4aFyijI/ibZrWQY5SLReJddka57/08LIqJgNIqRlwZrESk3TTtWrhe0DN0noWS5+su+AAI6uepdNEvjK5ZDBATVjUpplPRq4w4vNZ2mXDObEeygFPe3P7f2u1itvIXYy3bROBh9U7xYWpAbBlHnk648PaQ3ayY+rOu9pNp+oiMDxf1jCTL1ei+iZQrvA5QScJwX6fC46NrhwYGFuewO0KM47EeZ5cENpqrIuj/MiKSZviP3xg3De8HDO+u+VNGIp5FKQhCRgmXu4MdicCYKAcshA04IEJPoWbcT8LU39DzKOO1ii9mNrbbvyaUWBTzgnkzWMUQB3a1v0RaPe9Ns=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 710918ba-e312-40c1-9eb1-08ded15008ec
X-MS-Exchange-CrossTenant-AuthSource: LV3PR10MB7796.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2026 17:51:21.2514
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NMshKegbJt31pEsCnXOxFc024Uh/39OLOSVqt4TxT9BHPA+DGesLTtdasz8iSLzvy4VSDaQJa23x7S5WezDRlmJpVd56Y7CEat+CicFhmj8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR10MB7617
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-23_03,2026-06-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 bulkscore=0 phishscore=0 malwarescore=0 suspectscore=0 mlxscore=0
 mlxlogscore=999 lowpriorityscore=0 spamscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2606160000 definitions=main-2606230146
X-Authority-Analysis: v=2.4 cv=eJAjSnp1 c=1 sm=1 tr=0 ts=6a3ac79e b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=FelO9ux0wxsA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=BqU2WV_vvsyTyxaotp0D:22 a=yPCof4ZbAAAA:8
 a=VwQbUJbxAAAA:8 a=Vs-gDwy9XAL3cos7o8YA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=5yU3S35YU4bGjq-dph-N:22 a=Bho9c0fBagfJEIQBS7DQ:22 cc=ntf awl=host:12313
X-Proofpoint-ORIG-GUID: He8y6M-X3rT5YqIpgh5nxtxKeN--HTkl
X-Proofpoint-GUID: He8y6M-X3rT5YqIpgh5nxtxKeN--HTkl
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIzMDE0NyBTYWx0ZWRfX1gTMFqGDyAEj
 8CXPLeyAIJTXTb+L8evlzKKB9EyFAvAAiZvKbA+Zm9hh0JGcxvPVbqKKltmaMagwhJF+MQZQV0s
 Y9z0XLQWuD/l7gg3whJdvVXwehqxuy5uDFraWnDeE6nSypXOYhJu+xx2J+70BzyRJw8cPi33r9t
 yUqitXVy5ovoaGqc3mHXb4WRERMvLr2feKfa3PXjw9jyySZxn40omsXFmj5EWweHMVJY6ncuZUm
 ubMUAw1CYBk/uUac0NiG7tMzpDhA9Ozc9snzN0yLggjG09HAnaaX4Q/w4UwqNIdcmdUfrMC2B/l
 NCCZAbO1EPJ9Oqdt+YqT7PpJIl/ZdYadderBFhzeJv5AZLfcLlABA6jHFLNNjW5Ly9/NN6s7PLn
 dlnTAO9CtQ3c7RoVJDDDZwp5nvvI9pwQo9YysmRs9TuC8O02BUsU1G9QcjEktkoHObtrWzWz02O
 8i5jNTZygCoDmxqzPmb55oMJi5/Q9Da/VtQRqhHA=
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIzMDE0NyBTYWx0ZWRfXw9OJowh9lM/d
 qGWK6Pmt5TfAC4TV5RyJQpylWmVhE93Z3lICLh6+djvuRPucu1obHhLCHEFjOmsqcxPzWD7u6kE
 SmDF0p3tiMkz5HEfsHlm7qf5wKBLPzqIp43LhPZx+ZpbKAXo4KnV
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.66 / 15.00];
	WHITELIST_DMARC(-7.00)[oracle.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[oracle.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25,oracle.onmicrosoft.com:s=selector2-oracle-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-22436-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[manjunath.b.patil@oracle.com,linux-rdma@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	FORGED_RECIPIENTS(0.00)[m:tariqt@nvidia.com,m:saeedm@nvidia.com,m:mbloch@nvidia.com,m:leon@kernel.org,m:netdev@vger.kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:phaddad@nvidia.com,m:linux-rdma@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp,oracle.com:dkim,oracle.com:email,oracle.com:mid,oracle.com:from_mime];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[manjunath.b.patil@oracle.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[oracle.com:+,oracle.onmicrosoft.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5797D6B9433



On 6/22/26 2:01 AM, Tariq Toukan wrote:
> 
> 
> On 10/06/2026 20:39, Manjunath Patil wrote:
>> After PCIe DPC recovery, mlx5 reloads the affected functions and
>> replays multiport affiliation events. In the reported failure, the
>> first relevant device error was:
>>
>>    pcieport 0000:10:01.1: DPC: containment event
>>    pcieport 0000:10:01.1: PCIe Bus Error: severity=Uncorrected (Fatal)
>>    pcieport 0000:10:01.1:    [ 5] SDES                   (First)
>>
>> mlx5 recovered the PCI functions and resumed 0000:11:00.1. During
>> that resume, RDMA multiport binding replayed
>> MLX5_DRIVER_EVENT_AFFILIATION_DONE and mlx5e sent
>> MPV_DEVCOM_MASTER_UP. The host then panicked with:
>>
>>    BUG: kernel NULL pointer dereference, address: 0000000000000010
>>    RIP: mlx5_devcom_comp_set_ready+0x5/0x40 [mlx5_core]
>>    RDI: 0000000000000000
>>
>> Call trace included:
>>
>>    mlx5_devcom_comp_set_ready
>>    mlx5e_devcom_event_mpv
>>    mlx5_devcom_send_event
>>    mlx5_ib_bind_slave_port
>>    mlx5r_mp_probe
>>    mlx5_pci_resume
>>
>> MPV devcom registration publishes mlx5e private data to the component
>> peer list before mlx5e_devcom_init_mpv() stores the returned component
>> device in priv->devcom. A concurrent master-up event can therefore
>> reach a peer whose private data is visible but whose priv->devcom
>> backpointer is still NULL.
>>
>> MPV_DEVCOM_MASTER_UP already carries the sender/master mlx5e private
>> data as event_data. The ready bit is stored on the shared devcom
>> component, not on an individual peer. Use the sender devcom when
>> marking the MPV component ready.
>>
>> This preserves the readiness transition while avoiding a NULL
>> dereference of the peer devcom pointer during affiliation replay after
>> PCI error recovery.
>>
>> Fixes: bf11485f8419 ("net/mlx5: Register mlx5e priv to devcom in MPV 
>> mode")
>> Assisted-by: Codex:gpt-5
>> Signed-off-by: Manjunath Patil <manjunath.b.patil@oracle.com>
>> Cc: stable@vger.kernel.org # 6.7+
>> ---
> 
> Thanks for your patch and sorry for the late response.
> 
>>   drivers/net/ethernet/mellanox/mlx5/core/en_main.c | 7 +++++--
>>   1 file changed, 5 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/ 
>> drivers/net/ethernet/mellanox/mlx5/core/en_main.c
>> index 8f2b3abe0092..f7ff20b97e8c 100644
>> --- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
>> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
>> @@ -211,11 +211,14 @@ static void mlx5e_disable_async_events(struct 
>> mlx5e_priv *priv)
>>   static int mlx5e_devcom_event_mpv(int event, void *my_data, void 
>> *event_data)
>>   {
>> -    struct mlx5e_priv *slave_priv = my_data;
>> +    struct mlx5e_priv *master_priv = event_data;
> 
> makes sense.
> 
>>       switch (event) {
>>       case MPV_DEVCOM_MASTER_UP:
>> -        mlx5_devcom_comp_set_ready(slave_priv->devcom, true);
>> +        if (!master_priv || !master_priv->devcom)
>> +            return -EINVAL;
> 
> is this currently possible? or just being defensive?
> if this return is unreachable I'd drop it.

Yes, the check is only defensive. For MPV_DEVCOM_MASTER_UP, event_data 
is passed from mlx5e_devcom_init_mpv() after priv->devcom has been 
assigned, so it should not be reachable in the valid path.

Please feel free to drop the check while applying. If you prefer a v2, 
let me know and I will send one.

Thanks,
Manjunath

> 
>> +
>> +        mlx5_devcom_comp_set_ready(master_priv->devcom, true);
>>           break;
>>       case MPV_DEVCOM_MASTER_DOWN:
>>           /* no need for comp set ready false since we unregister after
> 


