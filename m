Return-Path: <linux-rdma+bounces-19715-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GFoqJ7Y58Wk4ewEAu9opvQ
	(envelope-from <linux-rdma+bounces-19715-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 29 Apr 2026 00:50:30 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CE6548CD67
	for <lists+linux-rdma@lfdr.de>; Wed, 29 Apr 2026 00:50:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9B9D130532FD
	for <lists+linux-rdma@lfdr.de>; Tue, 28 Apr 2026 22:47:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BDFD371D11;
	Tue, 28 Apr 2026 22:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b="LBwZ4B79"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F282D35836E
	for <linux-rdma@vger.kernel.org>; Tue, 28 Apr 2026 22:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.147.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777416456; cv=fail; b=aL9doH2mGkwcTiv3cTdVfEAlkrt7T3N+IOMHhsOXVYRRU+lHshgHdGXv3McO8JHYX8g7WbuJZVJ1LSKaxjKOtdaA8/TVWMwhQ4xWl7dL0LKZ2iXz6h4AsIlwzEwKjtQsfjU4pnjYr9S8ol2q/NYmnzbSoSTjamdofxAHxRXDRjg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777416456; c=relaxed/simple;
	bh=JpDy/kE2X6nx/lAVhJIOw5PMLgVYa60TtK+OEn2Ez6k=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=KmmTO7K8TjmSzJqbojlH3sqIRNe1zv6fg0qoML+mMpbWkTyG6RM9FAk/DeDG2VfWJIqt02OLAq7vakJk8C3d+6msamxJjLIGrjaumtd2yyTMTW6+GLs+pWS4Hcu16fsVkRTISr0C+kN9qb64gslKD77Cac8SSDURBIQjmPcfsuw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.com; spf=pass smtp.mailfrom=hpe.com; dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b=LBwZ4B79; arc=fail smtp.client-ip=148.163.147.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hpe.com
Received: from pps.filterd (m0134421.ppops.net [127.0.0.1])
	by mx0b-002e3701.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63SGcbBf3023034;
	Tue, 28 Apr 2026 22:32:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pps0720; bh=JpDy/kE2X6nx/lAVhJIOw5PMLg
	VYa60TtK+OEn2Ez6k=; b=LBwZ4B79BFuqRdonU1Jui3qAruzcXC4DGe/ii8hIon
	6fiy9wqLVD+9WeIDjIHTEA2x+/ngzSMs9ZQNa6cqCYWaSJH+ExuzclR6sJjmg9S8
	r/3u2i4IByynL4oUPdK5tqwpJo1VdZPC3amZ+SOx0feWr1dMuzD1Z2S6dpWchiC1
	EBKS9bId6mPCvswPvM7w8HFWn+XTxx5OtT8C1eKJu1HQ4SUg7NCULSYUMQWNuxhc
	fupSrwi1IZWFU/MUGGesAZvNzstUCuC1AlDzT4/WXveeHr55TTWF76g0xyZmTUcO
	b03TPgph9mGxRAf88Upgu8R06/Xai9K8TFPglqlyUItw==
Received: from p1lg14879.it.hpe.com (p1lg14879.it.hpe.com [16.230.97.200])
	by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 4du0k63bhh-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 28 Apr 2026 22:32:17 +0000 (GMT)
Received: from p1wg14926.americas.hpqcorp.net (unknown [10.119.18.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by p1lg14879.it.hpe.com (Postfix) with ESMTPS id 4166C2FCF5;
	Tue, 28 Apr 2026 22:32:17 +0000 (UTC)
Received: from p1wg14927.americas.hpqcorp.net (10.119.18.117) by
 p1wg14926.americas.hpqcorp.net (10.119.18.115) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 28 Apr 2026 10:31:59 -1200
Received: from p1wg14919.americas.hpqcorp.net (16.230.19.122) by
 p1wg14927.americas.hpqcorp.net (10.119.18.117) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Tue, 28 Apr 2026 10:31:59 -1200
Received: from BYAPR08CU003.outbound.protection.outlook.com (192.58.206.35) by
 edge.it.hpe.com (16.230.19.122) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 28 Apr
 2026 10:31:56 -1200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pczrv2yp2mauVeZDgZ+q+WoK4daBxmuZF0Grw8sGG6aJZSaS1fcLy+AcsrQ/YOssjE7sGrasAl/FbuYTvOTz+vSpiGcFb6+rv84RWfRR/ccO3YE3rb8i40isQD4zLWv3jS1D8dKg4ziC/j46P+tfhwl5rMKeGopL9Si8dFyqD8NwJPrtFxNFfD69pB2kecTm5vcHUrLre34el/fjURirxWlAn1Pim9bWukW+CJzW9EF4HllnG1sf1ZyxsI7OkOIYyA4V9xx0JAeuEj8Y6hrPB1pxUrDece7rAWbCTTZYltjuG8Be2xYGUakaiXm6n4b7pzwXtGXS0R0xRzw4zt29hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JpDy/kE2X6nx/lAVhJIOw5PMLgVYa60TtK+OEn2Ez6k=;
 b=X5ggLAeGrPmIFT4/8T0apO08hXyATtHpl3/MdL7adxNL+G1kLbbDmX/cm0cq2OK88EmOnRvYWgJczeYr+nhWNAFvOCBM1gM6hnMQuQLtblqOFcZojgRowrXyFewtQ1wH82VhasYz8/yjU+U8qhDLtp7LHSH4TB0F71WmRwrrw803DCjNqkVDDklFreOjLhCFYKv1NX0Vg34O8gsuQ5ZLq++vrf+5lWMx9GdMZpF/gfWLA89dBViLMQX5krj0lC1V2hNgyR3sIJOtpjmrbLADcPuBQgD6qHUTO7felA9xjiaj9V/RW7Pg551ryKF5Mz6/KYfSCT1BUlukXlMYE/Un/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from DM4PR84MB3970.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:8:225::20)
 by MW5PR84MB1913.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:303:1c3::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.26; Tue, 28 Apr
 2026 22:31:53 +0000
Received: from DM4PR84MB3970.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::d136:e75e:53c5:73d8]) by DM4PR84MB3970.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::d136:e75e:53c5:73d8%4]) with mapi id 15.20.9846.025; Tue, 28 Apr 2026
 22:31:53 +0000
Message-ID: <e41b13aa-0cdb-4b07-97d0-cd6a6a0cbf07@hpe.com>
Date: Tue, 28 Apr 2026 16:31:51 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-next 0/4] Introduce Completion Counters
To: Michael Margolin <mrgolin@amazon.com>, <jgg@nvidia.com>, <leon@kernel.org>,
        <linux-rdma@vger.kernel.org>
CC: <sleybo@amazon.com>, <matua@amazon.com>, <gal.pressman@linux.dev>
References: <20260407115424.13359-1-mrgolin@amazon.com>
Content-Language: en-US
From: Doug Ledford <doug.ledford@hpe.com>
Organization: Hewlett Packard Enterprise
In-Reply-To: <20260407115424.13359-1-mrgolin@amazon.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------VWlObPURnJzrWVZFFRP0r3uf"
X-ClientProxiedBy: SN7P220CA0012.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:806:123::17) To DM4PR84MB3970.NAMPRD84.PROD.OUTLOOK.COM
 (2603:10b6:8:225::20)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR84MB3970:EE_|MW5PR84MB1913:EE_
X-MS-Office365-Filtering-Correlation-Id: 87209915-f3ea-446f-7434-08dea575f2ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: z7pRjDQHUMoJ2q5i61612QUM0n42dDaTL0NkvNr4UEEspFHBrT2/pN8uPsqxHNignjzG6e7eLwK0E6aclrFnehpybK6bnfKr6CgHT/EtzWuAHzM7PlvG9Z3xZ+5eRnZCLbz/32zEMzge74zAR8f8rAK4LIsNDvTAgJd4JssttKzkSnMK6rUw7W5Vb1YgG4UMYwmryMB/sO9qdaJBTjrVhf6unf4lPRIzWZtR2fkpLWA/uRV/6712ccLFZIcyxg/AMceUCPAHOo58P8b4YGip8ryxSwe5aq2/cZzEh33B/jlfle0QPc49EiJT5F0ujO5MuPKcdoV8ZL7d1IP1ZFjxOwyLlckt6nsBK91mZW02HbinE3+MAIfDP6Z72w1wprNYlAF3b1FEXNFClgByTsNe5LGMDl4OYLJhpBDPuk/0+zlE31sVAX7C15D+4vjs7Q1LwEKKKBP2NK9w0HotUuJ/wIzKxl8j4Z5FYIOUTjIvDLsHHt5fQD/B1mhr+jb5TO5aNJ/CfzHT8k5Z3zNbxZ8OUixdR2WPLdkH76AEzTnxjrLWwGmqfvhOY4+zAT8VY0RFbZZAquX7zo83zz1lBUAPa49qu43PcNFz0JQU6XftML0nnuwHqfLyQg2bwR1WlFJNtPQeQ3f6YslrNzWlIS3PMgZ1riVvIWzHP6K4V/e+KWynw5XqcxBoJnqlcPaAqCFwR6QZrLY7cCNovb7J5bWTRFofsAIxO5Fy7Wr59bc2bfY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR84MB3970.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R2JrVllWY2tRbXAzNnUwRkpNc0JzaWsyOVhKeEFub0RGYXkzOEhMbko3UE16?=
 =?utf-8?B?bFMvVHRvalBROWdnNVkzN2NGTC9ZUVI2eTZoY28vMEhYVEVabGN5L2xwUW8r?=
 =?utf-8?B?VG95NzA1N0JSNEhycjZmK3EvTnZiSG9mR3BYOUwwNUZiVllUSTVBUDBMNWVD?=
 =?utf-8?B?SW9WYjViSUFwV1kzY29BT3MzRmVRdGdSd3YxM3M2bUVtNlR5NldzZmF5THdx?=
 =?utf-8?B?NmVEYkxqb2pXVGpYSzhuaDhLbTRzeUtabmNZU1Z2enpOdHhjUlNET0VOMnQx?=
 =?utf-8?B?cUNJM0c3S2IwRWIrNmd6dEZ0dEpRQTZkY2RkWmJYd2dZQ2l1VFRSOW4xcFAw?=
 =?utf-8?B?ZmNHOW1SZXRhNms3L0FqUjFJUjVVS3R2RmZydDlEbHpwWEhXakJQUE5NeDJ2?=
 =?utf-8?B?bG1pWTArWDFrcEp6Nzc4RVlINStIQkdoeE9TbzVLWHdkU3ZianQxTlFFUkQv?=
 =?utf-8?B?VEpkWTMyenpuMHpDZFlsdFN5bXh4TWErTUw4VXB6eXJUaVdDRmI0ZU05UW4r?=
 =?utf-8?B?UnhYRFUvQ1UvQU9vYzBPZ3ZJSDhaSG5ueTdteis4K0xxMTlwMWtHSUxVcGFK?=
 =?utf-8?B?L3JuY1FUWjI0VERMdENHd09odzY4STV3dlduNEtJdldVbHBrbUxuWWVMS0Vo?=
 =?utf-8?B?YkVTd0hJZWlHTFRDNVBjRGd0ZWNpS0d2VDVudHlsdVR2NExaTEtEYmZDQVV3?=
 =?utf-8?B?OGp3Sk5ncnlnRENTYk1Xc1JxRjg1MVpselAzK1dEWnB1ZjkvSU0xVHlxbm5p?=
 =?utf-8?B?Ti9iWmJ6bFl0ZXVBY2JHMExQaXBSSEluZ0FVaXVidXZ0c2ZqeEUrSlIzTGIv?=
 =?utf-8?B?SE40elRnUlNPcXNHSVBNQlRZcTVuN3ZWWVpBeitTdmQxS1NBR2xzZ0ZNcWtn?=
 =?utf-8?B?OXVKY2RheXJjWVlGQkpIcTFNbGJ4NWMzdHNCb2ZuUWxkN0hwY0xQR21teWl6?=
 =?utf-8?B?MmtYTWRDU0R4QXNYaVBoVzNweEtoWXI0YjRnV2dlRmh4ZHp6UFVFQmNyd0Zi?=
 =?utf-8?B?dTZmNHZTeHI4Nk9yRXpQUzV1dWhubXdmN1pwdGNsRWNQTXhUZ1F2WXJIdnJW?=
 =?utf-8?B?Y1JwV2RIWStiYjBLU3ArTlFqTGphZk5yekxxQnYxWFkwZ25WWGhyNFNYRDZI?=
 =?utf-8?B?QmxEOGFUaVBPaHhsNnJyMHdaMU5TLzFoczRlOG03d25kTnYvQkZnTWIzaENv?=
 =?utf-8?B?ZXR3blp5K0dqM0p0eVRMT3oydENVTHhaVlJ2c25wMWhNdzhjOEtCeWR5dEFv?=
 =?utf-8?B?QzEvT0dnN1p0UXdEUDZMRnN5NlN4TXFJMWRYMys5NzNReTZrM28zK1F3NFJu?=
 =?utf-8?B?bWYxa3V4T2w4MWxjdkV5VlZGazNYbG9RbzVZUjJHUTh0NU54cUxYQStYMTRR?=
 =?utf-8?B?Y3RRZCtocHRKRlR3T3BQUXZuREYrMElITWdZNEtudEI3V2IvNTVGcWQzZ2hN?=
 =?utf-8?B?VExVOU1EbDY1YU5LTksvaGxncS8xdUFmWXk1QklkZVI3M1ltd21pdGlBS2dH?=
 =?utf-8?B?aGlUYVFzU21zTXIxT09EMGtxay9sV2srUGE4ajJNdFVjQVJ3M1dtYzVGeFRs?=
 =?utf-8?B?U0JFdmdmdGxDUmMrNzdoc1RuT3RmOFhiMXFaZkxMa0pZM25pQmd6NmhvNEFK?=
 =?utf-8?B?K3cxTVhNTWtHRXZocHN1K0o3bm1LWFlzR2ZZWlRHd2dqTTBqbzZzcyt3U1VD?=
 =?utf-8?B?TkZsbTdqTysyQ0FiSXNVbHdPemNvN0JzNHp0ODFxbUFYYkNaN1J5L2MwZStD?=
 =?utf-8?B?RzlWNWJ5ellhOWJleXBQSmxxOEFqM0pqVS93Skp1Z1p4cjlFODQzUmZTdEl0?=
 =?utf-8?B?UHBnaFArVXZQRmVKcWFIc2x2ZGZsZjdOWXhTWHlMMG1GT0dlcGZMb2lYZ3hj?=
 =?utf-8?B?Ly9sK3BGYlYrQWRRM2VJVkFZdDlZVFJDZVR3S0N0dkN3TDM2d3o3TGNDeVgw?=
 =?utf-8?B?OXBLT25yMXQwTS80MUtVZ2F3c0pyb3JyMTludmJMWnNUT2EwOCsrWjdkYUxK?=
 =?utf-8?B?YVE3anNUY2ZFUGlkT3VkT3hLNERkcXd6cStyV0JhbzR0TTVZR3MzdGZ0SkJR?=
 =?utf-8?B?UG5JUXU0dEU4Sk11UGJTM3FQK3o2aUkvQUQxVnAyd0NtV001b2xXTFUvWFBQ?=
 =?utf-8?B?OGlTTSs3a014L05NT2JmbzRteUdWYlFvZm1wK3l6VlgxWHV0YmM3TG5UalAr?=
 =?utf-8?B?aUdDVW5sdWlIK3JGcSswTzdadWZTNHFnTWpYSWRQYTRrbDlDb1diVTBNb2JC?=
 =?utf-8?B?YWtDM0JpdUhhdE9DWGxWSnhablFNWlllWmhlbG9SS0dyQTl2UDNibUQ0ZGJl?=
 =?utf-8?B?VEpTVGJsVXMzMm9GcGtSVGRySlVmL2NXSEdoMG1KSkloMVp4NHlvdz09?=
X-Exchange-RoutingPolicyChecked: GHWlyXjr8hVtPMB8hkSLD8tPl5WjVwhymp7MUaPd4FqUbV5GH6/+6ECZRormhN/sUZBxAqhU4oLjcUfuCwwdJP56m4GkM6M6n+l+Dq7Q6XL5Ef3s7SK52PbSkXiizGTfsvdV1kx8SLQCAgEuBaHgTstO/vkYQsGhEmdMoO3dSyHQNiXbiK0cZf43r0m8dMYW1jBPTUjwmATbrxvEgkKvqxTVlo6iUJsc9GFWrlBO8fmc+/U6Ra/5YBcGyiJCuAgRWp9gk6imZ4tBSVRl+VOxqb3YZSMa14bqX3BWISh2X5X5TM4OrDo9OCvavRFEpA77zSmWuSry0k+8V+XM5zZDWg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 87209915-f3ea-446f-7434-08dea575f2ad
X-MS-Exchange-CrossTenant-AuthSource: DM4PR84MB3970.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2026 22:31:53.5131
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ig/CuuzfyRoT2Y7XpV0IUhqDVTOjJhjBxVQCY2E5P9bb7aXU+YHIDmFDMbcNsZgLskS/s/P60Qd/cQlh4Yf9/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR84MB1913
X-OriginatorOrg: hpe.com
X-Authority-Analysis: v=2.4 cv=AMcw+Mbb c=1 sm=1 tr=0 ts=69f13572 cx=c_pps
 a=5jkVtQsCUlC8zk5UhkBgHg==:117 a=5jkVtQsCUlC8zk5UhkBgHg==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=A5OVakUREuEA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=gQcMVamqm3wCPoSYhaRC:22 a=ay80y3fxfMS_JZZz1qJy:22
 a=NEAV23lmAAAA:8 a=MvuuwTCpAAAA:8 a=iKYkvkK3r5EP3qKlx9kA:9 a=QEXdDO2ut3YA:10
 a=_m93DWyjFHePNbkuFXAA:9 a=FfaGCDsud1wA:10
X-Proofpoint-GUID: TM_5OMjizE7SR0oiKahmq2r5Ifc2zqAK
X-Proofpoint-ORIG-GUID: TM_5OMjizE7SR0oiKahmq2r5Ifc2zqAK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI4MDIyMSBTYWx0ZWRfX5MGkg0JlKwks
 wHQf9OM+Cfav3pLGa6vzqsPcTbntEKVBJmCsPELrWxWYAD78fI6vxBRy+r84N6b/KxkQ149Vck7
 5LrVzyoCEvN++V/2X8PEN73WtWQ3D03SeEbY5utmK5Fqh8yS5vyX5z3nQm2w7hgkq7UwD8cOdCb
 ZrpdrW2252Ou8TyuZQi7em6A1z4hWEYyYFGto7/V/IWpv17cOaDDF+AYND4uY/nM9zCo9ftUqcj
 KOjj/L9j8jrE6HcbEGJ3flsxUf4Xucdv5lmJCywu47sf6BHUm+Vr6Z/D/dtkYZJ7yqRtNL+WK8p
 NwyEgrFFmwIiNOcfmN+xgykbvxiXsAq58iJkDF2AWpvRZwlUCgOFECNE5FdvSOo/KJK4dVn9WBD
 Vo7BtkvdBA4uDgpLAZQ858PBzkFZwNXYzHjCzLD+43EEpUygYY5z05bO523i5cKZHI0jXV8fi/U
 NJRy7xFJflcTDuDSeCA==
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-28_05,2026-04-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1011 spamscore=0 phishscore=0 priorityscore=1501
 bulkscore=0 suspectscore=0 lowpriorityscore=0 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604280221
X-Rspamd-Queue-Id: 2CE6548CD67
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[hpe.com,reject];
	R_DKIM_ALLOW(-0.20)[hpe.com:s=pps0720];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MIME_GOOD(-0.20)[multipart/signed,multipart/mixed,text/plain];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-19715-lists,linux-rdma=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_SEVEN(0.00)[11]

--------------VWlObPURnJzrWVZFFRP0r3uf
Content-Type: multipart/mixed; boundary="------------oZBAD0AF9lYLDov0Ro2Q7Apz";
 protected-headers="v1"
Message-ID: <e41b13aa-0cdb-4b07-97d0-cd6a6a0cbf07@hpe.com>
Date: Tue, 28 Apr 2026 16:31:51 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-next 0/4] Introduce Completion Counters
To: Michael Margolin <mrgolin@amazon.com>, jgg@nvidia.com, leon@kernel.org,
 linux-rdma@vger.kernel.org
Cc: sleybo@amazon.com, matua@amazon.com, gal.pressman@linux.dev
References: <20260407115424.13359-1-mrgolin@amazon.com>
Content-Language: en-US
From: Doug Ledford <doug.ledford@hpe.com>
Organization: Hewlett Packard Enterprise
In-Reply-To: <20260407115424.13359-1-mrgolin@amazon.com>

--------------oZBAD0AF9lYLDov0Ro2Q7Apz
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gNC83LzI2IDY6NTQgQU0sIE1pY2hhZWwgTWFyZ29saW4gd3JvdGU6DQo+IEFkZCBjb3Jl
IGluZnJhc3RydWN0dXJlIGZvciBDb21wbGV0aW9uIENvdW50ZXJzLCBhIGxpZ2h0LXdlaWdo
dA0KPiBhbHRlcm5hdGl2ZSB0byBwb2xsaW5nIENRIGZvciB0cmFja2luZyBvcGVyYXRpb24g
Y29tcGxldGlvbnMuIFRoZQ0KPiByZWxhdGVkIHJkbWEtY29yZSBpbnRlcmZhY2UgcHJvcG9z
YWwgaXMgbGlua2VkIGluIFsxXS4NCj4gDQo+IERlZmluZSB0aGUgVVZFUkJTX09CSkVDVF9D
T01QX0NOVFIgaW9jdGwgb2JqZWN0IHdpdGggY3JlYXRlLCBkZXN0cm95LA0KPiBzZXQsIGlu
YyBhbmQgcmVhZCBtZXRob2RzIGZvciBib3RoIHN1Y2Nlc3MgYW5kIGVycm9yIGNvdW50ZXJz
LiBBZGQgYQ0KPiBRUCBhdHRhY2ggbWV0aG9kIG9uIHRoZSBRUCBvYmplY3QgdG8gYXNzb2Np
YXRlIGEgY29tcGxldGlvbiBjb3VudGVyDQo+IHdpdGggYSBxdWV1ZSBwYWlyLg0KPiANCj4g
Q29tcGxldGlvbiBDb3VudGVycyBjYW4gYmUgYmFja2VkIGJ5IHVzZXItcHJvdmlkZWQgVkEg
b3IgZG1hYnVmIG9yIGJ5DQo+IGludGVybmFsIGRldmljZS9kcml2ZXIgbWVtb3J5LiBDb21t
b24gY29tbWFuZCBpbmZyYXN0cnVjdHVyZSBhbGxvd3MgYW55DQo+IG9mIHRoZSBpbXBsZW1l
bnRhdGlvbnMgdG8gc3VwcG9ydCB0aGUgdmFyaW91cyBkZXZpY2UgY2FwYWJpbGl0aWVzLg0K
PiANCj4gQWRkIEVGQSBDb21wbGV0aW9uIENvdW50ZXJzIHN1cHBvcnQgYXMgZmlyc3QgaW1w
bGVtZW50ZXIuDQo+IA0KPiBbMV0gaHR0cHM6Ly9naXRodWIuY29tL2xpbnV4LXJkbWEvcmRt
YS1jb3JlL3B1bGwvMTcwMQ0KPiANCj4gTWljaGFlbCBNYXJnb2xpbiAoNCk6DQo+ICAgIFJE
TUEvY29yZTogQWRkIENvbXBsZXRpb24gQ291bnRlcnMgc3VwcG9ydA0KPiAgICBSRE1BL2Nv
cmU6IEFkZCBDb21wbGV0aW9uIENvdW50ZXJzIHRvIHJlc291cmNlIHRyYWNraW5nDQo+ICAg
IFJETUEvZWZhOiBVcGRhdGUgZGV2aWNlIGludGVyZmFjZQ0KPiAgICBSRE1BL2VmYTogQWRk
IENvbXBsZXRpb24gQ291bnRlcnMgc3VwcG9ydA0KPiANCj4gICBkcml2ZXJzL2luZmluaWJh
bmQvY29yZS9NYWtlZmlsZSAgICAgICAgICAgICAgfCAgIDEgKw0KPiAgIGRyaXZlcnMvaW5m
aW5pYmFuZC9jb3JlL2RldmljZS5jICAgICAgICAgICAgICB8ICAxMCArDQo+ICAgZHJpdmVy
cy9pbmZpbmliYW5kL2NvcmUvbmxkZXYuYyAgICAgICAgICAgICAgIHwgICAxICsNCj4gICBk
cml2ZXJzL2luZmluaWJhbmQvY29yZS9yZG1hX2NvcmUuaCAgICAgICAgICAgfCAgIDEgKw0K
PiAgIGRyaXZlcnMvaW5maW5pYmFuZC9jb3JlL3Jlc3RyYWNrLmMgICAgICAgICAgICB8ICAg
MiArDQo+ICAgZHJpdmVycy9pbmZpbmliYW5kL2NvcmUvdXZlcmJzX2NtZC5jICAgICAgICAg
IHwgICAxICsNCj4gICAuLi4vY29yZS91dmVyYnNfc3RkX3R5cGVzX2NvbXBfY250ci5jICAg
ICAgICAgfCAzNzkgKysrKysrKysrKysrKysrKysrDQo+ICAgZHJpdmVycy9pbmZpbmliYW5k
L2NvcmUvdXZlcmJzX3N0ZF90eXBlc19xcC5jIHwgIDQ1ICsrLQ0KPiAgIGRyaXZlcnMvaW5m
aW5pYmFuZC9jb3JlL3V2ZXJic191YXBpLmMgICAgICAgICB8ICAgMSArDQo+ICAgZHJpdmVy
cy9pbmZpbmliYW5kL2h3L2VmYS9lZmEuaCAgICAgICAgICAgICAgIHwgIDE1ICsNCj4gICAu
Li4vaW5maW5pYmFuZC9ody9lZmEvZWZhX2FkbWluX2NtZHNfZGVmcy5oICAgfCAxODUgKysr
KysrKystDQo+ICAgZHJpdmVycy9pbmZpbmliYW5kL2h3L2VmYS9lZmFfY29tX2NtZC5jICAg
ICAgIHwgMTA2ICsrKysrDQo+ICAgZHJpdmVycy9pbmZpbmliYW5kL2h3L2VmYS9lZmFfY29t
X2NtZC5oICAgICAgIHwgIDM2ICsrDQo+ICAgZHJpdmVycy9pbmZpbmliYW5kL2h3L2VmYS9l
ZmFfaW9fZGVmcy5oICAgICAgIHwgIDYyICsrLQ0KPiAgIGRyaXZlcnMvaW5maW5pYmFuZC9o
dy9lZmEvZWZhX21haW4uYyAgICAgICAgICB8ICAgOCArDQo+ICAgZHJpdmVycy9pbmZpbmli
YW5kL2h3L2VmYS9lZmFfdmVyYnMuYyAgICAgICAgIHwgMTc3ICsrKysrKysrDQo+ICAgaW5j
bHVkZS9yZG1hL2liX3ZlcmJzLmggICAgICAgICAgICAgICAgICAgICAgIHwgIDI3ICsrDQo+
ICAgaW5jbHVkZS9yZG1hL3Jlc3RyYWNrLmggICAgICAgICAgICAgICAgICAgICAgIHwgICA0
ICsNCj4gICBpbmNsdWRlL3VhcGkvcmRtYS9lZmEtYWJpLmggICAgICAgICAgICAgICAgICAg
fCAgIDEgKw0KPiAgIGluY2x1ZGUvdWFwaS9yZG1hL2liX3VzZXJfaW9jdGxfY21kcy5oICAg
ICAgICB8ICA2NSArKysNCj4gICBpbmNsdWRlL3VhcGkvcmRtYS9pYl91c2VyX2lvY3RsX3Zl
cmJzLmggICAgICAgfCAgIDkgKw0KPiAgIGluY2x1ZGUvdWFwaS9yZG1hL2liX3VzZXJfdmVy
YnMuaCAgICAgICAgICAgICB8ICAgMiArLQ0KPiAgIDIyIGZpbGVzIGNoYW5nZWQsIDExMzEg
aW5zZXJ0aW9ucygrKSwgNyBkZWxldGlvbnMoLSkNCj4gICBjcmVhdGUgbW9kZSAxMDA2NDQg
ZHJpdmVycy9pbmZpbmliYW5kL2NvcmUvdXZlcmJzX3N0ZF90eXBlc19jb21wX2NudHIuYw0K
PiANCg0KT3VyIGhhcmR3YXJlIGRvZXMgaGF2ZSBjb21wbGV0aW9uIGNvdW50ZXJzLiAgSSBo
YXZlbid0IGR1ZyBpbnRvIHRoZW0gaW4gDQpkZXRhaWwgaW4gdGhlIHBhc3QsIGJ1dCBpZiB0
aGlzIGlzbid0IGFscmVhZHkgbWVyZ2VkLCBJIGNhbiBkaWcgaW4gYXQgDQpsZWFzdCB3ZWxs
IGVub3VnaCB0byBtYWtlIHN1cmUgdGhlIEFQSSB3aWxsIGJlIHVzYWJsZSBmb3IgdXMgdG9v
LiANClByb2JhYmx5IG5leHQgd2VlayBhcyBJJ20gYXQgdGhlIFVFQyBGYWNlIHRvIEZhY2Ug
dGhpcyB3ZWVrLg0KDQotLSANCkRvdWcgTGVkZm9yZCA8ZG91Zy5sZWRmb3JkQGhwZS5jb20+
DQogICAgIEdQRyBLZXlJRDogQjgyNkEzMzMwRTU3MkZERA0KICAgICBLZXkgZmluZ2VycHJp
bnQgPSBBRTZCIDFCREEgMTIyQiAyM0I0IDI2NUIgIDEyNzQgQjgyNiBBMzMzIDBFNTcgMkZE
RA0K

--------------oZBAD0AF9lYLDov0Ro2Q7Apz--

--------------VWlObPURnJzrWVZFFRP0r3uf
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEErmsb2hIrI7QmWxJ0uCajMw5XL90FAmnxNVcFAwAAAAAACgkQuCajMw5XL90S
Dg//ZUi054sLRvwjnU35Wki+Ma41+myrPGbmc/e5EFfHgmbwpY52EBFMCkNYUMksuBkuQJA9e8nS
0NhO2rypoLG0rriqCQXWeYzNF6Qr0CfvcBFEF9in+T5i2CXnm6HvEz7yls1xc+cfQqjtdR6ZhVF5
ep/lreLsRy5xeKFt90x/ieZ+sUfpp5zthyygijxm6YCJyBrdEmkyINR/fH9boMWtaWBkr6h7UlPF
XU1QocWd381l+AxTGpw5dB+hak58KXYXfjnTBwbr6H5NpFRGUtnotbljQarB5Mo9VSdUScnq6MaL
pcwFlvhkQTBHUKNHdOKiFfTsSSNi4muO7TDYbTRnGGOeU8S7dKpQ6+CZMrQYGCFC3OCTemrNJSBC
iQq8N21bzN0RcXspb24bwmYfFTuc0wI4ARip8raPnLrmw5TP5yEzc4p0wswRG2zq88LD4hs9OcU6
UWn/pLYvnXSBZgKKBzO1drtOcnpjiDkY63CeGupgv26z2x2nBoe/x/VTgmwJoumTNETsU7zFfyDE
cRYeqlPRuILKpnkwhM/CpIDqIPd5AglhnDzInFl5ip9qLOveBmuuHKPyUgWAwbRl+7QCf2TD0xtN
G8m4KG1j7qVEldUgPPK1sJRiALxJF+Hr1lGRJNO/4MK8FjtFGBrVO+ND5aKGxp4f7qQoAbx1ntgJ
zAk=
=LYDb
-----END PGP SIGNATURE-----

--------------VWlObPURnJzrWVZFFRP0r3uf--

