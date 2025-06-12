Return-Path: <linux-rdma+bounces-11239-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 616B6AD69ED
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Jun 2025 10:06:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0746C3A6991
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Jun 2025 08:06:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90D6B1AA1E4;
	Thu, 12 Jun 2025 08:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Krgx8yQ+"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2075.outbound.protection.outlook.com [40.107.101.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCE001940A2;
	Thu, 12 Jun 2025 08:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749715612; cv=fail; b=mnPiwBMoPgvVKTEw8trYAbnyw9amaYeJfi4fr0GHKtEjNelDFi+KazdTwfj0oqOiKadO1EL43TsyH7hKIMEpSc7DT+ST0dQKQZlz4UosLufd5dukqXEyQ9Ho6Sc7xa9LraXDWAdIc2pyOvLG/MyRvVTdiiQCwtSup7EPEisysNY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749715612; c=relaxed/simple;
	bh=edfQK1BAvKlzRVK4zy8TY+fwxeSs+hSk9QZ6if//hCY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Ws9xOM9Z1aaJkaHkJ4tP6MwxQ2VKq6qiINhdIrXyKY80nywNjTtf2IsNQdYJ3e8Yx9S5WgwH65m+b9bqi5+t5QB6TM1U7oIyM+yFu0505f3uZaUkmg4Lk7WDXbYx5FBjpDRaGcYRdTfh0cyjBBQ7DwzP6C6xzyihcQpMdD5cjAY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Krgx8yQ+; arc=fail smtp.client-ip=40.107.101.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GLJ90/7EF5Xohwd9nkKOT+LKJJvE+Fan0JP2HVgLMJQaqi6ohQ8biOiMkJs18MJUOrhJzKXcIjvO+lGrx55eFTGASdLoRnV3nxz61bUk/cKwHc4CFxelvgfFTfqiWX4hxowAFh4KxRLLeOc3wvGMBR2Q7zt2VZujBYU3RA/qnrr9PxqBq9yYmOmBAqdzWPKlTKRsYlauSAUcte3/+gRhufFio9GwYobQ/A6dkBIUTGW+YhMFcrHcuT7q1GmhirW7w6Rs+GyVN4dndLFluNB4QyaBac9xjgzslVJcw54jOzryKzuy8o+SR+ZyOYrd1niNxQU7nq33cHIKA6qWJflz2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tb949AcTpo6PeeXvx+sq32eKfUTxWLjIUJEARtlJyy8=;
 b=KPvtXh9/9qCHRvqdK2tbaWXevjzdlIGxV4eI22jc3QlZkI4LdNUrlX1La1gIySVuyR12PxtxQ4Isj47WynSIPonpOqcVPxI4Jq30jf1hnc9hFNwyhN9RjhhK9Doq467yPgTqpHqC/JFVwGGcbauJI++VVZViFTwBwks56UZJQJAkurTsXccbUMNs83GJlUPhalZbQicEE6dR9LJIahx9tTAT/3wCq98FyKnic05ky1YfrH2+1z+Q6R8nSAnuoWtv4Jlb/oGc53C1arO8Bjap12KhwrA18ADR/TEjrrp3AT/BOg1p/5rUxXqCwmDhpK4mzKXYUIhRUdRFXOhREbHjZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tb949AcTpo6PeeXvx+sq32eKfUTxWLjIUJEARtlJyy8=;
 b=Krgx8yQ+m8rn30mGmt18oxrQK1SPvWCbWJaHcXkVyj4uPRAF/mxSzVqu+4wBrXoCNITwmDUH+IoPShRjA0Nu93rf3tluZU0kv0sKMgpcK+U46BUtGBmyikDZDHOv9GcTc8WvE5EChoY9k3qq5Liyi7rxovuOngzLvk7U9UpBu9R157Gzje+7CpQQE/lwb1u2e3Bq9LSipiQhqOqmfl3qTOfqi1NmA8bqdNMij2zY/tFhtUDbYuhU6Ox4yvzKFM+Llf3HCB8HWpvQM/ei5AMDvpuhXcgAXDE4tEXC1PyMSRZpf5v9egtFtq5EvmULfcsGIajmnfAZI3B92u1F7eMRCw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA1PR12MB9031.namprd12.prod.outlook.com (2603:10b6:208:3f9::19)
 by IA1PR12MB7640.namprd12.prod.outlook.com (2603:10b6:208:424::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.24; Thu, 12 Jun
 2025 08:06:42 +0000
Received: from IA1PR12MB9031.namprd12.prod.outlook.com
 ([fe80::1fb7:5076:77b5:559c]) by IA1PR12MB9031.namprd12.prod.outlook.com
 ([fe80::1fb7:5076:77b5:559c%4]) with mapi id 15.20.8835.023; Thu, 12 Jun 2025
 08:06:41 +0000
Date: Thu, 12 Jun 2025 08:06:36 +0000
From: Dragos Tatulea <dtatulea@nvidia.com>
To: Mina Almasry <almasrymina@google.com>, Mark Bloch <mbloch@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Eric Dumazet <edumazet@google.com>, Andrew Lunn <andrew+netdev@lunn.ch>, saeedm@nvidia.com, 
	gal@nvidia.com, leonro@nvidia.com, tariqt@nvidia.com, 
	Leon Romanovsky <leon@kernel.org>, netdev@vger.kernel.org, linux-rdma@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Cosmin Ratiu <cratiu@nvidia.com>
Subject: Re: [PATCH net-next v4 01/11] net: Allow const args for of
 page_to_netmem()y
Message-ID: <4tr5zqwmunp6tezoxv37ujpoupi745byzoy32enbyzjicgyh7x@3eusjpheij63>
References: <20250610150950.1094376-1-mbloch@nvidia.com>
 <20250610150950.1094376-2-mbloch@nvidia.com>
 <CAHS8izOzZnNRbBvMohGzB2rxhuLun8ZcPKg38Z1TbXo3stqZew@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHS8izOzZnNRbBvMohGzB2rxhuLun8ZcPKg38Z1TbXo3stqZew@mail.gmail.com>
X-ClientProxiedBy: TL2P290CA0011.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:2::14) To IA1PR12MB9031.namprd12.prod.outlook.com
 (2603:10b6:208:3f9::19)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB9031:EE_|IA1PR12MB7640:EE_
X-MS-Office365-Filtering-Correlation-Id: d90ba37d-bbeb-4416-a676-08dda98810b4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?U3UvcFk2VEpPMlI2OXZkMnBQNHFqSU9zd3hQaGMwRU1OR0hKOHNGczM4aVkw?=
 =?utf-8?B?ZzcwTzJtOUlXSlRwQisrYkZJanA4aVlzUk9QK2FBckl3K3VGbCtxR2ZGbWVG?=
 =?utf-8?B?RVlORzNTbjZ3bWdxNWVLMkV2S1JQUFFlUHc0YUNTdXpSZEdNMjBSdkUwVWtN?=
 =?utf-8?B?Z3VFcEw5ZUxkR3M2TXh1bXRmaFdPUFZhUjJGRUZCUUY1T1FwOThJZDQyMW1p?=
 =?utf-8?B?QmVxdmNwUHN3Y2EwcFFxZ1JueTM5TU5nSldGVkVWQllnNVF1WFpWNlEvK3BY?=
 =?utf-8?B?WTJacXZkTVJPcmFmQ01pL2JJZGRxUzlZa1NIcTF0dlJBVzJxMXVXTzliRnZX?=
 =?utf-8?B?cFNIR0psTHNNeFdqZVlIN1YwZDJKMDlGdVp4K1hxT0dXbkJoTkZ0OXI1NnpP?=
 =?utf-8?B?S2h5eGtKK0o0ajJOeUN1ZnowU2ZvMUt5TEJGMG5pK1dZV0V6clF6VmNUSzM5?=
 =?utf-8?B?TXNFYVBQRytUZFdzZzNBWXoxNVpMeS9sRFVzRnVvLzF5a0dKODBVNEltcjM4?=
 =?utf-8?B?NjFBMHBCUGtOQ2o5RjZ5TDU2SnYrUWMwWGFhRzNnV1NZTExQNWg3aVBIeXJN?=
 =?utf-8?B?SmpnbGpuU3ZheXBEamgvMVpZMktPWXR4M0dqNitXc0l3YTRJSjgxK296TG1R?=
 =?utf-8?B?RUFlS3VYMEJJdXlDTGx3endkRVVya0dnNHVuVnF3VlI4b2FHS3ZqZTZYbnVV?=
 =?utf-8?B?R0dWUDlHa2tGOGJnMXpnRzZzNEJRc1FsOGJ3K2ZucGpFTmRvQVdOanhldFVa?=
 =?utf-8?B?OEpiOE03b2pwa2hVMU56YTZlZ041Z1JjMWNVQWo5UUp4cllMMFVvUEJlSndv?=
 =?utf-8?B?QzcwWUpmTkRKb1NwNk53V08wRk1SS1phV1o3STBDVjZGRGRwWC9keUtyQVJC?=
 =?utf-8?B?bE5keGYrV2hYYVpJQk92OHo0czBuNnByWUlRR1hrL1FPWmRnUTNwQ0pJeWpK?=
 =?utf-8?B?NHFOVVByM0t3OEVyL2FpTWE4YkEvWEhIMSsraGwxS2FVTE40OVZyZ21saVYx?=
 =?utf-8?B?d3F1MUxHUEtlTlFVbUZYcHMwZVJMd1RpYXlubmZSZm5uenI4YlFwa255VUpx?=
 =?utf-8?B?eXo0U25qRWFPbGx6aWVKS3FUWjFhdHllYVlJbElWVVdFY2R0eGxlUFdsa1NO?=
 =?utf-8?B?S2FYU3YvTFpZcUhvcWN1WGFpaTdxTFdLSmpZeUF3Sm54MFFOVnhyNGRiVGlj?=
 =?utf-8?B?K1VlNXFCRDR0SW1QSkxOcllaV2VFbmlWby8xRzVXdGUyVXBsVmdWQ28zODU4?=
 =?utf-8?B?UTAvamc1RUY0YkNtN2NBRFROQVBrL053THJteFpCUFh3N0V2QWFoV3VvWk9M?=
 =?utf-8?B?dVlUbFlwcU1PMlg5bkkrci9XRFhEanJqa2JKQ1VZczM0eVNramtycWt4VHN1?=
 =?utf-8?B?QXpIQ01rZHdBYXVseFk4YTlPalJBT281TnUvbUFpNUFmTVY4ZU1saU1nUzlT?=
 =?utf-8?B?QVo0Uy9GSDI3SktEV3I0SnA1QzhTYkc0bkQ1bkpKOG5tM3JyeURtRllQYWo4?=
 =?utf-8?B?NVZMUUphazVHWlMzeEVFL1hwdTkweXdJa1p0eTQ3VDc5TDQ5Um9ORnJWR0sx?=
 =?utf-8?B?THBscjhQMTFKTHY0eUp5S0NTV3RNS0pvZjhSdi9uQ3VyZzZMUlJIbkhwcUFO?=
 =?utf-8?B?TjlxT1RXOVhRbks1cWQ3TWUwbVg1YjhNSE9qLzFDNmZtTDYxWi9EeHlpdFVi?=
 =?utf-8?B?K3EvUE1oQjMwYnU5RktxczllenpuQ0xQanlqL0xqYktMNHhBaGszd3VJcXFT?=
 =?utf-8?B?Rjg2eUNlTjQ2aW9qaWhaT0FaTUo4WjliUzB2YWMxbEdhajNLQW5lRjhaMit2?=
 =?utf-8?B?VnZ1MEU0SEthY01iODhJSis1Rnpmdy9LZ0R2bDM5Y2VXeXd5ZllDc0lkdHNi?=
 =?utf-8?B?QmlNRlBUK3lZaEdZLzg2VHdDRlhQQVVCMHpjS3VrZmQxbjdKTlRIL1VNSVdT?=
 =?utf-8?Q?e9OTUx9xOlQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB9031.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bnl4cFM1K1ZmMlFJMGMxNVF2NHJ2YzNEQm1YVFN0dUlNbDhLdklYaVg4ODJo?=
 =?utf-8?B?cTNMc2JiUzBrTFFsbW9KcGxkU01XcTRwMm1hK3lvMXlEdG5zWDUvUUJKU1Iz?=
 =?utf-8?B?a1VYTXVNRG5xbmhNa0xxRDh4Sm0xK3ZQV0JTVkFsUm9iWmpzUGVmd1ZVS3VI?=
 =?utf-8?B?NU52SHcybUdvYkRteTE3b0pid2RxWUx2TWZTNXdSeFNxNG1ac2hWTm9NdUta?=
 =?utf-8?B?S3cxNDR6SDVOVXF3eXN3aXZqclJVYUcwR0lkWllxSkJxWXJacXlsZzVLZDZj?=
 =?utf-8?B?VGJZWGdaL2VuOHJWMVlEclYrYjF0VDNHRVJIckhLMXBwb2VPL1BUdU1FZlZi?=
 =?utf-8?B?bmFleVFDbWE1Tm01cmJFQS9sQ3RWd2hNVEJmeW5DNjBrL201c3lDVWpOTkF4?=
 =?utf-8?B?Qzc5NTNDY05HM0hJbW5JKzlBamZPZUNlNnU3K2hGajAwa2RSLzR2L3V5Vi9X?=
 =?utf-8?B?MTFkRHJ5Q0UzbHNCZExoRCtDQ3JyWERzL3Z3UVhwNXdzZWNYa0RiUERlSmhv?=
 =?utf-8?B?MllRaTRXL3lJNXc4eXB4RXFrMlZDNkdPVzdyeUVhUTdCTlE1NFdPWHcyc2tj?=
 =?utf-8?B?UzBNeTVNY0ZwMk03cWFGY1JvLzcrUTNxeEFSRTJGQnM0K1lFYjZ0TWZRQmt0?=
 =?utf-8?B?V0xpWlYxemhEZDJwY29wT2NvUk4wRThOVzZZTXdjNXpNRnRQUVdwdGl0OUsv?=
 =?utf-8?B?dmVZSVJ6bStKOXRlUDJkSnFJSlVYVmVuV2ZuejhvL1BwcENZSit1SnhLdTBn?=
 =?utf-8?B?Z0c3ditWeDRPTFNhMXB0a05Yb1RJaGZTWnNLZTk4a1NOa1kzSERXdnh2aXVt?=
 =?utf-8?B?cHllU05wUmxHZUJNSWlwVDJsR2dDWnQ5MjZmZWRZRENTQnNjdTlIS2ZRYkI2?=
 =?utf-8?B?UDFZK3hZdEEwZnM1QllUTzh0UlBIU25OcFNvTXZFVVhMQTJiQmk4VTc0Tmda?=
 =?utf-8?B?ekpPWmRCc2JDeE4zSTFlN3piL09Xc2lvaG5KNGMrUTBOb0p4bTFObm1rWHRq?=
 =?utf-8?B?cDV6REh2T1RNb1dEK1RBcTlDRkQ3bmhicGRnSWNsaW5KK252aWdnVFlDdUU4?=
 =?utf-8?B?ell6cXozcDVKKzlOZHJiYVBJRFpQeEdhK09TQng4T1VEL1ZGemVUV0tqSjc4?=
 =?utf-8?B?YzB1WGJkdE8wN1dITUJ2OUNCQTgzb2Zkbkx2N21FRHJUVThIL3psNEgvLzE3?=
 =?utf-8?B?RDNNZzdRZDVUN1JjUmpUTWhBOG9CaEgzZi9rYnRGTTlFQWQ1Zi8rMnFyZGtp?=
 =?utf-8?B?NVZJRW0vUmE0eGcrWURONjZla1psTWFmRU9YOXNtWE45OXIxcTRFMUxFYWpH?=
 =?utf-8?B?c05aMFpWU1EwRWpCeElXQTduS0I5QitYL2FhWmFpZ3ArVUNqeUc4RGF0cW5K?=
 =?utf-8?B?am9IZHFVS3EvRTF5WEZrUU9rd1RyTmxXenA1UjNxWjhHdFNVazdyVTI1MEtw?=
 =?utf-8?B?TDhUUFNVRStlVTJaQWVrNHVGTzhWRzZmYlRqN1c5RGkzRWFHOXBFWmFuTCtv?=
 =?utf-8?B?OElNV3VEL29JemtoRGp2Zkg1N2Y0S3JBejhzcWQzN0tzRWlvMHJyT0R3ekNL?=
 =?utf-8?B?YkxyS3V0aWpGblcyT0xHcTRxdEttWTFCNm1OS1VzbVdCdExtZG1DV1Nidk5a?=
 =?utf-8?B?S2RIbTVabWNONUdZajFWNVVxVzB5VFBTVWFIKzREUzVSZjU2SThYZHhvcTVC?=
 =?utf-8?B?bWZYRDVkeUJ5dnVKSUxDaHJmQVo0Uk12cjZOUXMxZTdiK1QvMXlmcnMwbjlu?=
 =?utf-8?B?clc1SGVLL2ZxOVNrUU12Si9yMXY5RmluL0JVMm9MOHNjVm92THZ0d2puU1Ra?=
 =?utf-8?B?TnhOWUQ5VWNOdkJZQlBwdE9HVzN3MkhBYklXYWhseE12SGI0ekpsakJrclFC?=
 =?utf-8?B?RTREQkdOR1hqSTYxTXlOVE9meG84dDVWd1ZrNHk3dURaV25vMVE4V2ZXdkx4?=
 =?utf-8?B?NUxsNTYxRko0Y3pjQ2VIdVZXbWRRZmc1NmZ1cnJ3U3ZROWRNMk0xOTUzTkxO?=
 =?utf-8?B?dEJYQmptcW1RTUhwUUZFcmQ5Z1ExNTdqNHFyNDB2alBtbjdYTm9NMTEvbEZB?=
 =?utf-8?B?N0VJQmVJR3RFUnBMUzJCV3pNQzUxZHVEajlTZUNxOUJGVU1oeXExSEpUUnFS?=
 =?utf-8?Q?gB7SemmW81SZKbz5+wk9BFzHk?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d90ba37d-bbeb-4416-a676-08dda98810b4
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB9031.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2025 08:06:41.8603
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1ZJL1B5xKP2UzzrV+hA5wSTjY03VYfKsW6D1FtYGppH89ChWxhATkEWx4miLW4M30Yc7PTNHXDiL5s+Z0PDTZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7640

On Wed, Jun 11, 2025 at 09:52:47PM -0700, Mina Almasry wrote:
> On Tue, Jun 10, 2025 at 8:15 AM Mark Bloch <mbloch@nvidia.com> wrote:
> >
> > From: Dragos Tatulea <dtatulea@nvidia.com>
> >
> > This allows calling page_to_netmem() with a const page * argument.
> >
> > Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
> > Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>
> > Signed-off-by: Mark Bloch <mbloch@nvidia.com>
> 
> This is slightly better, it returns a const netmem_ref if const struct page:
> 
> https://lore.kernel.org/netdev/20250609043225.77229-6-byungchul@sk.com/
> 
Agree. Saw it too late though...

> It's probably too much of a hassle to block your series until
> Byungchul's change to this helper goes in for you, so this seems fine
> to me in the interim.
> 
> Reviewed-by: Mina Almasry <almasrymina@google.com>
> 
Thanks for the review!

Dragos


