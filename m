Return-Path: <linux-rdma+bounces-3987-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 94D3593C342
	for <lists+linux-rdma@lfdr.de>; Thu, 25 Jul 2024 15:46:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 19AAA1F228D7
	for <lists+linux-rdma@lfdr.de>; Thu, 25 Jul 2024 13:46:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D00391E528;
	Thu, 25 Jul 2024 13:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cornelisnetworks.com header.i=@cornelisnetworks.com header.b="CYOqLoXk"
X-Original-To: linux-rdma@vger.kernel.org
Received: from CY4PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11020101.outbound.protection.outlook.com [40.93.198.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70D3F1DA4D
	for <linux-rdma@vger.kernel.org>; Thu, 25 Jul 2024 13:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.101
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721915199; cv=fail; b=sYxB7+l4PcQFyQMply50eG2e5iyd/nB0l0ng7a3MNeeYlzkbylaE+dyjcyU7YGfZK+ZMEDGkJAfgADuKMMtBH1LA1I72DflUP1mYd/f9NNRwcRJsoLkk/4fa4lm/GbCsG9Phi7ogPNxGY6F9/K4K+RH8sMnRrApPfqmiobp2Llk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721915199; c=relaxed/simple;
	bh=ms+MDXmW+CRtrI8Mg2/31qSIzC+2rlkJ2HaGyBdJcIU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=EV9cqgEJDmRI2h2TeVyzJ1YiCneX48oe3ws5qKBIj5DT7DUizjh8ysGBUYJfo/XvaZsu/AL/sF66sID8V7e1JfsYThGoqShwRzabztP9TetWgQ6idU2L9xobkDSepjZUlkRdvuGKzQG5YP3GTgSKW62Qvlo5BkPyGe7ECg+gcSE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cornelisnetworks.com; spf=pass smtp.mailfrom=cornelisnetworks.com; dkim=pass (2048-bit key) header.d=cornelisnetworks.com header.i=@cornelisnetworks.com header.b=CYOqLoXk; arc=fail smtp.client-ip=40.93.198.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cornelisnetworks.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cornelisnetworks.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EomquU2ea8FU4VXB8QZmpGz25E3Y746fxacOqKVW8mS6DEF2jJuslk1DhxsyOgif5w3XB64cqUNQAvIufZ9ebu6YG4SH61sJhLqlHJ9rI0E+bt7FHUONeJOZ32j0y2DqVubhyUTrJentQ7UZQhoom5Icc1PBaweBqEf4s2TJjuw39uqq53BCAclIcAxfW6lF9pk6v7vfM0MGnlw6T5/nUwqrrAS+5Y+g7SW3DJzUffY4uIlCVacFRhsl2Vnv5tg68YJsRq2myXD8ZP6J+sTbJBRpZAQwVv9ZpIYcQuWuNU5ubDGi/ufxIQHsSp52BnCHycIZeFcdSs+5c/EzfOFVXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o3VKqeBvUANUNeeX0ca3nJ/4Xty978z0xHXGLBwZO3w=;
 b=MG5LgNwdf6ynYsbeOekrSRCdQMplyx/rDjsE3sxVszOQ6MTAvrb0c6e4TToHKTsXiyDqZVmdpfSG9UuTrdhSoeKq9gibEELK4cngmyLnG2p/c2XaPPe5RffviTgX5vCMOS0mCzKWCySHgI5K7XDmKym8TdupqzxxxcaLMOZ1wYtTSyw1u31cwO3I4wlRCnopGJCAq7epGMCzf5FJ5UhdoL4DMt2FpqDQjFURfEuQoZ9Q4Qs/n2pKOp12iiHc7VLvmuHBv2THJfbmJS9riw/LJAkC9ULJe/v/PMrPse4erLZYshr7GfzXxMVWVFMZl58roYos1lPtO9ccnDL+oVFhAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornelisnetworks.com; dmarc=pass action=none
 header.from=cornelisnetworks.com; dkim=pass header.d=cornelisnetworks.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornelisnetworks.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o3VKqeBvUANUNeeX0ca3nJ/4Xty978z0xHXGLBwZO3w=;
 b=CYOqLoXkn+ucwIm/8rZJkekBCEa6bTuabDulYvELbKBdaTygb0c4rXK3aDGsV0+6T3yW9rySlpNyjiR4+sqftg1EWmdKNDcuK/dfbcwn46olR6T4m3dk2KfFchw5uZ26V3eXU+YNworPsjgHreiYnGctUX7NMpOpY1VKtgvo06cQXeR0Dt420SIVq/fBSN3IvFpc4RrHjNdNgxvId+kE6C8XArQqwPl6AYt8jmiZi4DJzuqQC3XU517En0buwmnU4B3DWcu8Hc/1B1G7wOOGUjklY61Z0GFDcSmIPt/LymMQSkcHhvQxOKJGgKuXarF6c7fSE+0V1mL6kjapROuV3Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cornelisnetworks.com;
Received: from SJ0PR01MB7240.prod.exchangelabs.com (2603:10b6:a03:3fe::16) by
 MWHPR01MB8698.prod.exchangelabs.com (2603:10b6:303:285::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7784.19; Thu, 25 Jul 2024 13:46:34 +0000
Received: from SJ0PR01MB7240.prod.exchangelabs.com
 ([fe80::8f57:a917:f186:b794]) by SJ0PR01MB7240.prod.exchangelabs.com
 ([fe80::8f57:a917:f186:b794%4]) with mapi id 15.20.7784.016; Thu, 25 Jul 2024
 13:46:33 +0000
Message-ID: <db63e419-8185-4c45-8e59-2756013c73c3@cornelisnetworks.com>
Date: Thu, 25 Jul 2024 08:46:30 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] infiniband/hw/hfi1/tid_rdma: use kmalloc_array_node()
To: flyingpenghao@gmail.com, dennis.dalessandro@cornelisnetworks.com,
 leon@kernel.org
Cc: linux-rdma@vger.kernel.org, Peng Hao <flyingpeng@tencent.com>
References: <20240725071716.26136-1-flyingpeng@tencent.com>
Content-Language: en-US
From: Dean Luick <dean.luick@cornelisnetworks.com>
In-Reply-To: <20240725071716.26136-1-flyingpeng@tencent.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: CH0PR13CA0038.namprd13.prod.outlook.com
 (2603:10b6:610:b2::13) To SJ0PR01MB7240.prod.exchangelabs.com
 (2603:10b6:a03:3fe::16)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR01MB7240:EE_|MWHPR01MB8698:EE_
X-MS-Office365-Filtering-Correlation-Id: 44ddeb6d-2ea0-4ec5-8302-08dcacb0321e
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZittaWFWNCtlb1g5Vk8rT2t6aTVpSzVnMlVLR1RpMkF0ZkRYSzJDYXdlN1lY?=
 =?utf-8?B?Nk5LdGdLRU1LZVBBYmo4ejlPVkFvcXRpSTFUeDhnVGpOb0N5QWZHWFl5VjJs?=
 =?utf-8?B?K2VCL1QxeVVKQ3AwUVQxYWt4WUV2bkVZRVZTbFdvZlZXUHhKbTcvRnlXRFFs?=
 =?utf-8?B?YWRVVnJIVGJQVUtxSTV2c0I4VFl6SUt5MTlsKzdWZUdtQXRZMDZaWTFIUUdw?=
 =?utf-8?B?SW9aWmE4eHBrb3Fickg1ZFNMampxVUJ3bGs1K3cyZTdRcm9YckozRisxMUlG?=
 =?utf-8?B?Z3BrVlNtMDY0MXVBV3ZRc0RqbG13bVYva0hwSTdacklIQXkwa3VkRlZVeXpm?=
 =?utf-8?B?Nm9HQUgzUXJPb2tzeCtzZ2NTUm9iY0VGcDBPaXFucDFCeHhTa2VpbHNabC9a?=
 =?utf-8?B?QmY4SldDMHVLaEZPVW54bnEwK0NmdmwzMVg1R3FWV1F1S0cwT29MR08wbUpt?=
 =?utf-8?B?UWxCTDVrNVBsT051OHpnNlZnWUtIdE5GdjYwdzZEZ3JnZ1MxVVhPZThHRjBp?=
 =?utf-8?B?U2VFYlRtS2xaZEh1eTBYSE5FYzM0SFcxRW16elpjWXdCbGNqVVczNXB0eU1T?=
 =?utf-8?B?bERYeXkrQ2xhd2tzNjFNWFhYbDVNc0VmRFFNNU4zbjg5TEpoOUV0UnZVYzJH?=
 =?utf-8?B?REdYVlBGS0hKRDQ2bVQ4Tzh4VFFqUmk2aTFkZDA3eUNhdlprbjFsb29uVXFp?=
 =?utf-8?B?aVVxRWV5NWlMTmJKYUdXSERua3dxRGZ5YVliTFpOZDQxOTFMRmRsT1E3Nit5?=
 =?utf-8?B?cU10VGErTmZhUVR5a3J0cmlrb2Fab1JvZithSGdmdWRobnJLZFNqSitoOTdp?=
 =?utf-8?B?cXNKM0NONGhTZlZEbmdBbWxjbmtlbFF0R3ZKb0ZWYndNNlVveHpoMThZNDdK?=
 =?utf-8?B?Qy9uQjhpbjJhbURYYzROUDdHQytUbFV5cXpROWtOTXFHZE01SmplUTdWcG43?=
 =?utf-8?B?em1HUmlTSEdWb0R3TWhjOENGM3gwbm9aWTNUVXJ4eW9iNGFRUGRwVUJJeENR?=
 =?utf-8?B?dXFHOWpHUDVkbXFQb2FPV3U4OUpOZ1BEWGE1Ti81V1ZBb3cyd0lnTjVOY3BZ?=
 =?utf-8?B?MnVtZkFkM2FVdit0R1VNdUpZT1JLRHJwemxmZTBQMmVpZjc2d0pVa0E4SW1N?=
 =?utf-8?B?OU5lUFZQZ3FFNkplVHpHdUZLRGdGZ1hodjA3c2ozUWtuTHVPaEt4emZFa244?=
 =?utf-8?B?UCt0MU9qRFpjeWtuOENPSFM1M0tSaFFaVjNZMHlEV3pQZ1RmWHlPSkY1bFhE?=
 =?utf-8?B?d3phK1R4R2JKblRsdFFDLzZON0FPK3dHYTF5c0JESmUvVlR5N1RwWHlNbFpM?=
 =?utf-8?B?cjBPc05UdnpnRE5RUnRxRmtZQUNscTB5NERMem01WTFVazNrSWs0SHJCOHc1?=
 =?utf-8?B?L29vb1Fka0ZmdzFzOUR3VVJ6TDBCTmxYWHlEV0l5RG5pM2ZuUVhoamw2d2Z5?=
 =?utf-8?B?MWpudkg0S3ZJY1VZSnV0bWRLSzVxMXZjYlgrVTlnVkV5R0kzNGVEcFJnOEVH?=
 =?utf-8?B?SDZnQTVycEVSWWxKR1dWUk9FdnZpZzRxRkZxeWV2bWVtZ1p4eFFKcHZnRkRn?=
 =?utf-8?B?ZEdGS3FLTVRjOEJyLy9RbmhRekltTll6QVZNSnMvOE0xOFptNWpkcHQ2UEZa?=
 =?utf-8?B?ajM4bU83R0V2dHhPN3ZYWDU5aGdoRkVaOEl5YjNiU01xc2ZJbDFsN0R3MjB6?=
 =?utf-8?B?TGtOQSs0LzgyWktZdklBa2hqYk5lc3FkS0FIRElCSkVmS3gwU1JyYitNZER2?=
 =?utf-8?B?Z0JxeWlzRVRTVXpjcFpTNG1rRk0zang1N3VkQk11VVVvVmVsZ1h5UjhYdlZI?=
 =?utf-8?B?NzdGRmM3QzZwRlgvWUZQUT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR01MB7240.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QjhWeGJUOWRjOGI0VzY4SkVId0dLa25hU3U2S2VZUUZwQ2dEZ0MzSm1Ob1Uy?=
 =?utf-8?B?b3pseHhnelFLSFlUTUZRWGx4ZkNQVXg4WnZzNDRhbnJKVzI5ZkplenBzNU56?=
 =?utf-8?B?ZUc3SWJWTGwwNkhZNldtTXM5RDkrZy8vQnNUUE9PWlc2OGQ4clhsZ2E2ekg5?=
 =?utf-8?B?VlFMQW9iV2tzL2FJTTBJZGkzUTZkL3JnZVBpckF1ckhTbDk3TmJaYzh4QVhv?=
 =?utf-8?B?YVZzRnlCeEtKWi9sSXZKc2pTTUVVd3BJMS9RTk8vTEZpWTdSQitQOHJ0bE9F?=
 =?utf-8?B?SVB0aDhDTHp5VVdLeDNFTEZuR0FUVWpLYmVkZURaeVFDUjhWQWJiSEp4bUtC?=
 =?utf-8?B?czNIR0lqSUZsR2Jjdnc4aEpNSm5yWXFBV0pPdW1wY1ViTTRMNkZkcTZITWVy?=
 =?utf-8?B?ejhhamUzV1FDZk1kUWJRNU5oQVlYdWVYdUYrZi9zRjc3WjBBWGVkWjVxTys0?=
 =?utf-8?B?YlM5T2pBbGtFdk5CSy85UGplaGZPVEVTSHl6NU9ja0NVWHdYZEZGMGFsWEhj?=
 =?utf-8?B?Rnc3TllrNzlHcEtYbS8vVTlpRWtHak40MUR3UWN3OGtYMy9mZVI2TkUyQTh3?=
 =?utf-8?B?emtVMmdkNlhYNlUyUm5aQWE4RzUwQ1BXb0xsRUJwNGNmWFlYbGgycTF3MHho?=
 =?utf-8?B?aXdiR1QxN1dTQ0FINU1hQmtqdVIwdXRzb3hBbmliNmwxV0phSE9WN29sQk5v?=
 =?utf-8?B?bkdtK05XQWs0NjBCYnFNRUhQREwxZ2JKK2NpbUFwbzUzOWtkUlFTSHZoVjRt?=
 =?utf-8?B?UzNIUTlsMEc1SFZNOHNDdXpnamJ6bFFnQ3NsQ2dnRWQrM0ZyNHNhTVM0c3JE?=
 =?utf-8?B?M1h4VUx5OUQxYk5Ja0I1VmpDNHlYTFphMmc3SW5vS2pFU3BLYzZwTnNtdHQv?=
 =?utf-8?B?VnFQNmVvem9ac2lpOEtXOEpvSFo0cjkyVXB2OXZVelJRVHZZU3ZMZHZMZVlT?=
 =?utf-8?B?VTVjRkp1WkRsRm4yVkUxL2ZZMXFRSmgwb0JUc0NEaGZFbnZRNXRJVGNlMC9T?=
 =?utf-8?B?TmNDbXN3S2hqMzR6bGp0NHpaNmtPcFNOZzNtZHUyUXlCOHc1SW5mbzJpd01v?=
 =?utf-8?B?WUM1VGcyL1NBUmtVOGZERFNENkZ1OFF5VVovZzVKSUM5Vkx1cXFzQnZ5ZkV3?=
 =?utf-8?B?NkM2Tm51OCtPSmNKU1lLSXIxM3VNdnNkaDFSSEV6T3ZmcW4zazAwV0lWRnNv?=
 =?utf-8?B?bkF2Qmp1SzYxNysyaDdackYwL0hrNGo1R1JyRVRScFh6azJKS1FLbWlpRHNv?=
 =?utf-8?B?d0lCUGdLbEEyREdEZjY3elExVSszbXRIWDJEM3dvVFJZcWx6MkpYalc1NVc4?=
 =?utf-8?B?TnI3c0Qra3JsQ3F3aElwOHpwL0o2ck1mMW5EenlaSmJsL29OSnpVQ1E5eEJM?=
 =?utf-8?B?VDBUVVdZczk4cVJKM0VUTjZ1a1ByUDhiRXVIYktacWNRMndTaFd1UzZxRGpm?=
 =?utf-8?B?TitYQmdpVnJPbnBXaHFxbjVvV1hXLzZEYUhTWU1BSW5oNWVYUlZlSUdTVTR1?=
 =?utf-8?B?eUpmeEFrWUpRWVpSdC9SRU83M1hpNVJlNGlEUFdWVWF3YlNaVFBRQjdEbmcy?=
 =?utf-8?B?NTNpbENDVFRTeFNoT3Y2enhtWDRTOEZ0eVlTdzlVbldsc2ZGZk9VM2UzTkVV?=
 =?utf-8?B?dk0xcS9lbmJoTkFBamtwd2hnYi8veVliTDkyNU5ZTmpyeVJMcktGSlBROGlo?=
 =?utf-8?B?VVIxVmY2UGNmbUNUVzR5R3VwT0Y1L3ZPWEVZREhua1hjNytDWXV4K1ducTJz?=
 =?utf-8?B?bnM3RGs5WWtqL2pjckdwUE01dTc1RDNQdzFTYXA4bjRpSVZSOXZVb1F1d0Y0?=
 =?utf-8?B?OFg2RkNjZ3dHSUZHb2xzZVpWemxwQlMxWlhQRExhQktUZFY1SjhHOGZWQWEx?=
 =?utf-8?B?bk4zL2pISzVuVVRUVEdsekM0Mlc0MTYvbDkwbHpiakNsVDdnUXljeHFSc0Fh?=
 =?utf-8?B?QzJSNFlCeExUQzRJRVVaREpEdDVKK1RSQ0I1TVJ3eWZKWk1kdDFod2VGazR3?=
 =?utf-8?B?bFdmQUVnU2NFUXM2Q1BySGJRck11T043QW9nUEpxYnRpQjVrdTRWWlZuOXl6?=
 =?utf-8?B?NXJmcEVtMklPbUQ0ZDhFbFM2QTY0bE42Ty9Sdm10QmNlRjg0QjdIV0w4Y0Jj?=
 =?utf-8?B?UURLb2xQWkJ4S0xEbTVYSmljVEpXZFVPZ1hBWFJUNk55V0tVSHFMcUdOdWE3?=
 =?utf-8?B?OWc9PQ==?=
X-OriginatorOrg: cornelisnetworks.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44ddeb6d-2ea0-4ec5-8302-08dcacb0321e
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR01MB7240.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2024 13:46:33.6916
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W8gQ0C6lDg+yXSNZGxy4FyUHSdTPK4bF45USi+Fmw+qD+5qPQ6J9Ml3820TdyWH9CzLiSEOtWf/WxgGpvYi0CLOl8mphjI6EVaSwPXLwWU0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR01MB8698

On 7/25/2024 2:17 AM, flyingpenghao@gmail.com wrote:
> From: Peng Hao <flyingpeng@tencent.com>
>
> kmalloc_array_node() is a NUMA-aware version of kmalloc_array that
> has overflow checking and can be used as a replacement for kmalloc_node.
>
> Signed-off-by: Peng Hao <flyingpeng@tencent.com>
> ---
>  drivers/infiniband/hw/hfi1/tid_rdma.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/infiniband/hw/hfi1/tid_rdma.c b/drivers/infiniband/h=
w/hfi1/tid_rdma.c
> index c465966a1d9c..6b1921f6280b 100644
> --- a/drivers/infiniband/hw/hfi1/tid_rdma.c
> +++ b/drivers/infiniband/hw/hfi1/tid_rdma.c
> @@ -1636,7 +1636,7 @@ static int hfi1_kern_exp_rcv_alloc_flows(struct tid=
_rdma_request *req,
>
>       if (likely(req->flows))
>               return 0;
> -     flows =3D kmalloc_node(MAX_FLOWS * sizeof(*flows), gfp,
> +     flows =3D kmalloc_array_node(MAX_FLOWS, sizeof(*flows), gfp,
>                            req->rcd->numa_id);
>       if (!flows)
>               return -ENOMEM;

This is clearly not going to overflow.  I see no reason to change it.

However, I don't know the current policy on such replacements.

-Dean

External recipient

