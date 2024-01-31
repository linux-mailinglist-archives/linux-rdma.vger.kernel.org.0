Return-Path: <linux-rdma+bounces-840-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CA929844579
	for <lists+linux-rdma@lfdr.de>; Wed, 31 Jan 2024 18:02:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80CB8296549
	for <lists+linux-rdma@lfdr.de>; Wed, 31 Jan 2024 17:02:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B14312BF32;
	Wed, 31 Jan 2024 17:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cornelisnetworks.com header.i=@cornelisnetworks.com header.b="T/jnam4E"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2097.outbound.protection.outlook.com [40.107.244.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7938812BF0E;
	Wed, 31 Jan 2024 17:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.97
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706720525; cv=fail; b=MUJGVWiN+VvyFx5/puCTPXHk6fq1BK+KcyVQ+f1j5QQYuANvGCodWibUrFE3SIwHcJ6fzmggWIWPv/Newtb4RxtXkTXp2Y3h1qsKL2nZZ27llQ9R+83z1rLUr+0z8K6nE6M72xWI3UQu3RqD8JtA6cFJwxvHcHN5rvOWPl8M6Zs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706720525; c=relaxed/simple;
	bh=mak9oODDoJTe+F5M/XBZGhoxjdhHlFWTaK8SK3b0pN0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=HbPgb72Km1CSqQ/86G5Hx3xtwp2UOKFIGt7frEyup/jUmfUh70OQ1P/WdVRJ9jPYLQeHOLBZ6uTo568Pex4axH1ZRMPl156bI6NuGTni0jxTg7DD5Ncn/ZYn+nunyuL+e/G4PmS5Xs5qWWKSeUy7FDkZyBYMxw2FJts4UJ4TkPo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cornelisnetworks.com; spf=pass smtp.mailfrom=cornelisnetworks.com; dkim=pass (2048-bit key) header.d=cornelisnetworks.com header.i=@cornelisnetworks.com header.b=T/jnam4E; arc=fail smtp.client-ip=40.107.244.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cornelisnetworks.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cornelisnetworks.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MrL/EEiPAOnWIZTBalv8dn+DaEqF0nLgDnkydR1pdbYxuyM4bLC6zCPINgEgUsj9zxhj1cBqgOENfE8Q+wRkv5wqj0V3H5gauobI72rcBkgQ/jePjy5O3Z1dqW2cF+ekr5Ka0GakV36Tpli2e8xkRiIhArLL7DvJrgCxggDt5JGd+l4viNKnvxLYRg6Y5hzpdP7b7+ocIAEkbeHVs9lE3qtuKBFWCbsbW75pC9HLol4g0hVI6hrG7qQ6Olvenerv3g1XYLth7C71dnq4fU9MGfRVEGdkvhqTfmon11O2gD6cEoI7qj9EeR1Oe9rHv2/2lXiFDsj7c3E7percgHcqdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FyRRgiTUNhoLdPIKIuSiOUTq5hR4NBqbFnW6LBy0jGk=;
 b=DGqldHFaC70+CuDV8ptv1oZCT3iXnLvLP6xUeh7lzlKAbeSBE3T1w9AJPXsTuUxaCa5CUui0c+ScnN7Wp8rxoeQSm4FCXPIudm2XXMtsGpS16esLtVzsXGPx5PVnaiNj0iprolU5CQzHf9kno3X7JRzU7//UZnedmwPI0mrLWHDUQyGvVSAlnqVFJvtOeeuNaWK5bBKOjKt16vUNYtRsGpOWM8p0Mx/fEEvJhUa/EPmt/6t4NQR8+FBF1ArHS2E5Sr32IQeUUdGv1Cv1sEGTqAJiOmbzmDv5/VUDjM4U2qYKlrkF3fsDpyRei0fFCKsxyhT8GhEjTJu4LkRQJSEqmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornelisnetworks.com; dmarc=pass action=none
 header.from=cornelisnetworks.com; dkim=pass header.d=cornelisnetworks.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornelisnetworks.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FyRRgiTUNhoLdPIKIuSiOUTq5hR4NBqbFnW6LBy0jGk=;
 b=T/jnam4Edy16m+FPYTPOjIkOgIkfD4RVCBoX6P+MMk2OfVAvHA8lp9V0irnR8uWKxZ6kKWh74CUJUDQaJzer5lGX0hUJVy1f3T8JCX46JoXzqU4RXuYCuu2EJTL1B8l+84KmtezRIs2wx3J3IF4nIWSpX+d0s/WyV4r1H2kOHEcAnyQWhhf2mCPtOnn2/7aCaWAQ6frlSikQ8KlurW727/6Kjpj9NE1NaWPdT5jIP1j9eeiwQxZpXCfNNn6bKRe4ESpp5bdMH/huRdnzrKA6acwxw0Mcff+R85/3SGaeLlc+qS9XeoXq/ftgax3DpmVW6Auzzc+IHprlXRfqGLtdEw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cornelisnetworks.com;
Received: from BL0PR01MB4099.prod.exchangelabs.com (2603:10b6:208:42::12) by
 SA0PR01MB6394.prod.exchangelabs.com (2603:10b6:806:e0::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7249.24; Wed, 31 Jan 2024 17:01:59 +0000
Received: from BL0PR01MB4099.prod.exchangelabs.com
 ([fe80::b624:a23a:44ff:a1e9]) by BL0PR01MB4099.prod.exchangelabs.com
 ([fe80::b624:a23a:44ff:a1e9%6]) with mapi id 15.20.7249.024; Wed, 31 Jan 2024
 17:01:59 +0000
Message-ID: <e89dc56f-556e-4743-8bd0-4050e5829de1@cornelisnetworks.com>
Date: Wed, 31 Jan 2024 12:01:54 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] IB/hfi1: Fix sdma.h tx->num_descs off-by-one error (take
 two)
Content-Language: en-US
To: Leon Romanovsky <leon@kernel.org>, Daniel Vacek <neelx@redhat.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>,
 Brendan Cunningham <bcunningham@cornelisnetworks.com>,
 Patrick Kelsey <pat.kelsey@cornelisnetworks.com>, stable@vger.kernel.org,
 Mats Kronberg <kronberg@nsc.liu.se>, linux-rdma@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240126152125.869509-1-neelx@redhat.com>
 <20240131125037.GF71813@unreal>
From: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
In-Reply-To: <20240131125037.GF71813@unreal>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1PR13CA0339.namprd13.prod.outlook.com
 (2603:10b6:208:2c6::14) To BL0PR01MB4099.prod.exchangelabs.com
 (2603:10b6:208:42::12)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR01MB4099:EE_|SA0PR01MB6394:EE_
X-MS-Office365-Filtering-Correlation-Id: 72858ef7-7852-46f9-0533-08dc227e564f
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	S7noM9kCPnWA89xB2pRmBwLPtHgjBO1HGj2qnt4Mwq83D7vIDfgrWa/r+gaAYOGVgYWlAUTeU0MfGfOvpkzZk09z4jAkeco/CQJplKrTH1KqY5qy3dJ1Z+adxR5ZJvcdlBh0SsVwglYz2kfYesixSDRLhxcGPvQCNCn5P6Bd7qqkgM99Da8g5weJO7SgjOmqlEMcWpX6lnjDRS41lMp+EbWPQbiv8HwZ14Awu9sPLTUBWDbkCvbamL1RE3VKeghISXY5+qL2OGVWo/m2lrYkwOYkVYSiMcU2P+8OdsBOK4Muj8Va8unOkAflnbqaOu3o38VcOfOsLxFWfG6umf/+wsoeHYQpRdKimGwwODwjOz2GIJLvBl7GFV2WstiZDbK6c+k+qWITMYerFLzYtKkebPFpQAp8r6Jl4UXl/nz2JsPqPNnVNnsObMgWbVCeZQBqHALqYFm79PG5rHcikXxdXVcZ8mBtYN7uS/sW0JkXF1XQXyfJgqBiu6eBjY/ofGbkWI2ANty4qa4UxiyuhA9yEymyhDahf2S9IioE84KrhbB31tM6joHYH8XrFZBtqU97zD96IyCRlrjJJKo2/ANXlWfT6oI4LcM8mUQTugTZ/vVkQjCnm+9XAybgz9GEY3Njaxdevfv075zGOpAUj5bq6Q==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR01MB4099.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(136003)(376002)(39840400004)(396003)(186009)(451199024)(64100799003)(1800799012)(41300700001)(66946007)(8936002)(44832011)(4326008)(86362001)(2906002)(5660300002)(31696002)(8676002)(110136005)(54906003)(66476007)(316002)(38350700005)(36756003)(66556008)(38100700002)(6506007)(6512007)(52116002)(478600001)(83380400001)(6666004)(53546011)(6486002)(2616005)(26005)(31686004)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?anozK0ZWekNlVzBXZ0tVZFJiSktBWmpiQWwrNENEN3RWckJhNWxQM3kwWG5M?=
 =?utf-8?B?MTQ2Y3hXNE9ZcHZKU3Jab2Uwd3diMlM4RUE1NS9qbisvYUJ4Wm5oKzVCUGho?=
 =?utf-8?B?TmFpU0FNSGcyaFltMlIrUXY2MlFvS0d6SWc3WWN0NGlGdUxKb2xRNGVpZ3dW?=
 =?utf-8?B?eFRUbkgraUVGOUhBMFJVWS8yVDA0RERXWEE3bjhpa09KVm84YnpTd3NNeTJZ?=
 =?utf-8?B?SFV1c045Y0JxRlREUUgzTHhLb2JIdVJqQU43MEI2YzV2ZmRJcUNjTW9yYU5P?=
 =?utf-8?B?U1VEUUdYVFNwSmNDbDBML3FDenZjZldTaFR6dFp6RXF5aTRoc0RneVJ4aFQ3?=
 =?utf-8?B?b1c4V1ZaTktJOEJ6b0lzT1Z1SHlpT2pucGl1djhycnhac0xYdmpLbHNwbGxz?=
 =?utf-8?B?cXg0a3VVMW1aTXY1eGNVQ1JibVRjbVhoaEp2RDNqejl1U0ZaZnFKL243bmhy?=
 =?utf-8?B?aGxNNC9GMTVycWFwUUlYc2pib1E2NTRJbFFlYk9ObnpzelhEZWpCYkJWZSs2?=
 =?utf-8?B?WjhvZVc0QURZcC9XRi9Ya3hITTlNNWhuK1g5ajhWMG00Z1JzZmhodHZOTWxk?=
 =?utf-8?B?eUo3aEFDa05CL3EyLzFYSnpsRUJTWm40SUZjMmZkeGVoOUtZSTNNWjlWa3R5?=
 =?utf-8?B?TE5aSzY4UFlTTWs5R3N5YnZybWxTQk1IWm8zeFVzc1lDWWtvVlZ5SUdvSFlp?=
 =?utf-8?B?cnEyMzllbnRUMTFOZ3BUaFZWRTV5a2J4eTNJZ09IdW82S1VNc2lkVUlXanVq?=
 =?utf-8?B?MVN4MHR0NE5uMnVESjJCQzNGRDA4WGR2ejVDNWhreGJvMGRjRXhyWitIcFow?=
 =?utf-8?B?VXpnZlZaUnNxMU1EOFdNMkhvNW5XOEt0UzJScjQzVG9HbEVaRWY1WUpBU2NJ?=
 =?utf-8?B?Sm8rU2pTTmVYNlNZalhScURHOGFTOTFUN0o2RlpyWkpCWWJwejZTN1lWenk5?=
 =?utf-8?B?SXY1NEdub0xiTGkvTE5LL0NoUWg0RlZLMGYxYTc5dTJpTlhlakxIN3RMTUtI?=
 =?utf-8?B?NUc5cmtiQWxBZmFlekV2WkhXWTdITEcyUUI1U1dJRDNvdXBRa3lpZDNYU1hL?=
 =?utf-8?B?VWpwT09udWNPVldiYmVhRVNzRTNXVW8rdzVsZnVsbEZvSFdsdFVUMXgyVlhp?=
 =?utf-8?B?K1BKZmRYMXhiS3l5WXltbklid05zLzI0NEFHbStEbGdZcVI2ZGk3Y0srMmhM?=
 =?utf-8?B?aGE0R2RWZTNJZ3lrbnlKTEhjU0VtdzZQelFYajMyZENvajI2MkQ1Y2Fhc3Yy?=
 =?utf-8?B?citoTFR6Rlc2a0l5RWh0WXFaSVVXajBxcjBsb3kvRHJNWGJuYTlKb0Z2VGR1?=
 =?utf-8?B?Y0lBWUtzWUhmckw5QThEZWZKdUpoWFprRzFERUtVVW1JakNPTU03dWhoSkFi?=
 =?utf-8?B?QmswVDVBSkdKL0RpZ1BsS2lBRnU1Rm4wUk9SVTZJcVZrekRoekxWTVcvWDdw?=
 =?utf-8?B?ZE5jSGdmYWJneTZIOUV3eG5BRC9KS1kzMWZOM3pFSDd6MDJTK0M0eTN2dXZP?=
 =?utf-8?B?UDhncEtUMkdsNyszSWZ5bEVqVkEzQ3lGa0hNb3lkdWoyditVTzdQOXR3Zktu?=
 =?utf-8?B?MnJ5ckpuSTJxczZkUnYrcDJCeFBQUXptYlAyMFRXVnFuQjcvNmdnYTdWQ0hJ?=
 =?utf-8?B?SW1Jd0lucFlHOFhzVlQ2Zm1aMGdKNWwvMjBlRFByWk1hMnkvWDJDQWFJZVBp?=
 =?utf-8?B?cjY4UlNpM0RCc3B0ZW5wWUJiN3NmbTJjc2pBSEZZYlRDM1ZsK3RGdHNRUzhp?=
 =?utf-8?B?TGswNjhMZXlIekFoYjNHUlBLS1Zpai9UeFRBcGdhOEdEUU9qdFNKejY3UVRF?=
 =?utf-8?B?SXZMcDRaTnN3NDE2dTVzcjJJZjJWMHpvZ1c5dE1WSjdXV3pWQTd4NUxRRDll?=
 =?utf-8?B?SHZmc2pyaEdmR1o0c1VMQnoxNDl2N21wN1NSSUFpOVpJcmRoTXFRVENnRmQ1?=
 =?utf-8?B?MThXZFFlSlp2VUdUS0RJL0QwVDh2MHZXL0lQSTE2aGtLcUQyNFdrRGd4bGZo?=
 =?utf-8?B?ZktxZGFLMlJURzlkUjB1c0JvTlAycStldExLOGNsQ2QrbGZmNG5zMlF3T25N?=
 =?utf-8?B?cUs1N2RTcXV6ZnRwT0pqQXRrcmw1SVBMMllTczI2a3AvYVZSTWpXNDFYVWR2?=
 =?utf-8?B?b2VjeVkzN3RabEJhSG8weTluc2dJalFQWWk0bTFRdEVPdmZmb08vKzAyMlQ2?=
 =?utf-8?Q?6VgfTMKAxOoHyu3pNDJEzSI=3D?=
X-OriginatorOrg: cornelisnetworks.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72858ef7-7852-46f9-0533-08dc227e564f
X-MS-Exchange-CrossTenant-AuthSource: BL0PR01MB4099.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2024 17:01:59.0136
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a4pFXapGDFusocdnuf3dLxX/ceuiwjZTSl9T5SLwtLVJp4zfxkTM7XGKPmNj5ZUF9yKAK9JCh+xemVgvc7+Eo9MFA5Qe96gJP0zoDWDlpli4uH5mAGiXBqWU7vx4aVAf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR01MB6394

On 1/31/24 7:50 AM, Leon Romanovsky wrote:
> On Fri, Jan 26, 2024 at 04:21:23PM +0100, Daniel Vacek wrote:
>> Unfortunately the commit `fd8958efe877` introduced another error
>> causing the `descs` array to overflow. This reults in further crashes
>> easily reproducible by `sendmsg` system call.
>>
>> [ 1080.836473] general protection fault, probably for non-canonical address 0x400300015528b00a: 0000 [#1] PREEMPT SMP PTI
>> [ 1080.869326] RIP: 0010:hfi1_ipoib_build_ib_tx_headers.constprop.0+0xe1/0x2b0 [hfi1]
>> --
>> [ 1080.974535] Call Trace:
>> [ 1080.976990]  <TASK>
>> [ 1081.021929]  hfi1_ipoib_send_dma_common+0x7a/0x2e0 [hfi1]
>> [ 1081.027364]  hfi1_ipoib_send_dma_list+0x62/0x270 [hfi1]
>> [ 1081.032633]  hfi1_ipoib_send+0x112/0x300 [hfi1]
>> [ 1081.042001]  ipoib_start_xmit+0x2a9/0x2d0 [ib_ipoib]
>> [ 1081.046978]  dev_hard_start_xmit+0xc4/0x210
>> --
>> [ 1081.148347]  __sys_sendmsg+0x59/0xa0
>>
>> crash> ipoib_txreq 0xffff9cfeba229f00
>> struct ipoib_txreq {
>>   txreq = {
>>     list = {
>>       next = 0xffff9cfeba229f00,
>>       prev = 0xffff9cfeba229f00
>>     },
>>     descp = 0xffff9cfeba229f40,
>>     coalesce_buf = 0x0,
>>     wait = 0xffff9cfea4e69a48,
>>     complete = 0xffffffffc0fe0760 <hfi1_ipoib_sdma_complete>,
>>     packet_len = 0x46d,
>>     tlen = 0x0,
>>     num_desc = 0x0,
>>     desc_limit = 0x6,
>>     next_descq_idx = 0x45c,
>>     coalesce_idx = 0x0,
>>     flags = 0x0,
>>     descs = {{
>>         qw = {0x8024000120dffb00, 0x4}  # SDMA_DESC0_FIRST_DESC_FLAG (bit 63)
>>       }, {
>>         qw = {  0x3800014231b108, 0x4}
>>       }, {
>>         qw = { 0x310000e4ee0fcf0, 0x8}
>>       }, {
>>         qw = {  0x3000012e9f8000, 0x8}
>>       }, {
>>         qw = {  0x59000dfb9d0000, 0x8}
>>       }, {
>>         qw = {  0x78000e02e40000, 0x8}
>>       }}
>>   },
>>   sdma_hdr =  0x400300015528b000,  <<< invalid pointer in the tx request structure
>>   sdma_status = 0x0,                   SDMA_DESC0_LAST_DESC_FLAG (bit 62)
>>   complete = 0x0,
>>   priv = 0x0,
>>   txq = 0xffff9cfea4e69880,
>>   skb = 0xffff9d099809f400
>> }
>>
>> With this patch the crashes are no longer reproducible and the machine is stable.
>>
>> Note, the header file changes are just an unrelated clean-up while I was looking
>> around trying to find the bug.
>>
>> Fixes: fd8958efe877 ("IB/hfi1: Fix sdma.h tx->num_descs off-by-one errors")
>> Cc: stable@vger.kernel.org
>> Reported-by: Mats Kronberg <kronberg@nsc.liu.se>
>> Tested-by: Mats Kronberg <kronberg@nsc.liu.se>
>> Signed-off-by: Daniel Vacek <neelx@redhat.com>
>> ---
>>  drivers/infiniband/hw/hfi1/sdma.c |  2 +-
>>  drivers/infiniband/hw/hfi1/sdma.h | 17 +++++++----------
>>  2 files changed, 8 insertions(+), 11 deletions(-)
>>
>> diff --git a/drivers/infiniband/hw/hfi1/sdma.c b/drivers/infiniband/hw/hfi1/sdma.c
>> index 6e5ac2023328a..b67d23b1f2862 100644
>> --- a/drivers/infiniband/hw/hfi1/sdma.c
>> +++ b/drivers/infiniband/hw/hfi1/sdma.c
>> @@ -3158,7 +3158,7 @@ int _pad_sdma_tx_descs(struct hfi1_devdata *dd, struct sdma_txreq *tx)
>>  {
>>  	int rval = 0;
>>  
>> -	if ((unlikely(tx->num_desc + 1 == tx->desc_limit))) {
>> +	if ((unlikely(tx->num_desc == tx->desc_limit))) {
> 
> Maybe, Dennis?

I actually have a patch that does exactly this one line change queued up to send
out.

The commit message for our fix is:
    If an SDMA send consists of exactly 6 descriptors and requires dword
    padding (in the 7th descriptor), the sdma_txreq descriptor array
    is not properly expanded and the packet will overflow into the
    container structure. This results in a panic when the send completion
    runs. The exact panic varies depending on what elements of the
    container structure get corrupted. The fix is to use the correct
    expression in _pad_sdma_tx_descs() to test the need to expand the
    descriptor array.



>>  		rval = _extend_sdma_tx_descs(dd, tx);
>>  		if (rval) {
>>  			__sdma_txclean(dd, tx);
>> diff --git a/drivers/infiniband/hw/hfi1/sdma.h b/drivers/infiniband/hw/hfi1/sdma.h
>> index d77246b48434f..362815a8da267 100644
>> --- a/drivers/infiniband/hw/hfi1/sdma.h
>> +++ b/drivers/infiniband/hw/hfi1/sdma.h
>> @@ -639,13 +639,13 @@ static inline void sdma_txclean(struct hfi1_devdata *dd, struct sdma_txreq *tx)
>>  static inline void _sdma_close_tx(struct hfi1_devdata *dd,
>>  				  struct sdma_txreq *tx)
>>  {
>> -	u16 last_desc = tx->num_desc - 1;
>> +	struct sdma_desc *desc = &tx->descp[tx->num_desc - 1];
>>  
>> -	tx->descp[last_desc].qw[0] |= SDMA_DESC0_LAST_DESC_FLAG;
>> -	tx->descp[last_desc].qw[1] |= dd->default_desc1;
>> +	desc->qw[0] |= SDMA_DESC0_LAST_DESC_FLAG;
>> +	desc->qw[1] |= dd->default_desc1;
>>  	if (tx->flags & SDMA_TXREQ_F_URGENT)
>> -		tx->descp[last_desc].qw[1] |= (SDMA_DESC1_HEAD_TO_HOST_FLAG |
>> -					       SDMA_DESC1_INT_REQ_FLAG);
>> +		desc->qw[1] |= (SDMA_DESC1_HEAD_TO_HOST_FLAG |
>> +				SDMA_DESC1_INT_REQ_FLAG);
> 
> Unrelated change which doesn't change anything.

Please drop.

> 
>>  }
>>  
>>  static inline int _sdma_txadd_daddr(
>> @@ -670,13 +670,10 @@ static inline int _sdma_txadd_daddr(
>>  	tx->tlen -= len;
>>  	/* special cases for last */
>>  	if (!tx->tlen) {
>> -		if (tx->packet_len & (sizeof(u32) - 1)) {
>> +		if (tx->packet_len & (sizeof(u32) - 1))
>>  			rval = _pad_sdma_tx_descs(dd, tx);
>> -			if (rval)
>> -				return rval;
>> -		} else {
>> +		else
>>  			_sdma_close_tx(dd, tx);
>> -		}
> 
> Same as before, unrelated change.

Agree. Please drop.

