Return-Path: <linux-rdma+bounces-7512-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A510FA2C2F6
	for <lists+linux-rdma@lfdr.de>; Fri,  7 Feb 2025 13:46:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8EFC93A0674
	for <lists+linux-rdma@lfdr.de>; Fri,  7 Feb 2025 12:46:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C424F1E04AD;
	Fri,  7 Feb 2025 12:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="OpUBZATo"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2080.outbound.protection.outlook.com [40.107.94.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03E49944E;
	Fri,  7 Feb 2025 12:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738932390; cv=fail; b=O1ZTDruaz6cUlDLm3itwQntI1Xg/RLNsYecJtlU0pvEOSzliq4k+md+uAerhGZSVvNmkWX/BRdEhEzRQJ9LEfOP/WH35Kp3jVI0Dvvj+zhEWTbqHa2LlF2EnKI0GMA6SAqOUTRDMpy9RsJ8lnswBGLpzxMJkacyVQlqCLyAmX3s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738932390; c=relaxed/simple;
	bh=9OKl7WsOAz6gNx27cUjylrkfwQQTarImZRLLchV2EtU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=bj1gNV5Gbx6LEsNxHFN89I4oHn9a3CXcWdl92USzMpbllEQu33aUQM5pm6zf+opy9bzHGOIwqFO9vsQuyVqyTrprdk9batRSqkn9wchouVdrTUBmasIwG+ifXOtCa+HIbzob4UvuF01F5s6UGu4k9X+sWiev/f2fgJy5Fjf3Cko=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=OpUBZATo; arc=fail smtp.client-ip=40.107.94.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qtSltzqGlzrux0HpyZdb4Knd90rjdumIhI1prXTVG/2tcePdn8lavhWSAjE98kQnrd4D6jU6zN1VmZFf/ruF7TQ9S+NfN0yHOFLSaL943klX01bT4KR4/12pPMznYuaoKx6MJBhRc9SInjCotziKxn/jz3jqEgBdeEayGsMWFoTDz38AYeGQAPM2LA3+RciaWhgwJllXXVPzu77ZXgFsHQM4nkOUrhvTuBOU6kQqxT8FCse2n68hI721JoyHUOgPexiN5jFyLoCQc+iKXyWHnXAuGdrDatplCR6+n6y18QbUY5NP/AgZtAP3yQG2ofGzcHofQxdPSnOOB3mZWdlpew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kC4Gnt9sj+tMLZtr5hpHtWytzWBgXbBPignuMv9hlDs=;
 b=ew2+UMd9ASduNxvzFnxGZeLgqSbsdZjvlaAdMOwGfgQ992fEAZktdZsGoMXYJqnON5+gt8Jja8GgyB/UwUHj1cwqyU3If4W5xRDRL0q/A/eWanCN2i5kOsvtMb5PVyj4J9S5XqdqbP4srRU+H9hsnKwVcjvU8dyU6TlDQa7w8D1JIAUbSk9k1ZPAwBBC77KnC9SSapOzz2yKlKHm5UZzhNaFdiu+cVdM58pirU3h7WlCPnz+QDF1z8lB+QJY420QPcdrlMC9YGwRuMpGcOWck/3TPywioswpDFukeRYPyQ9xcVyy4Q7P2g15Q9zfqto4sMdFc3/ysg35R0bcQZGOqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kC4Gnt9sj+tMLZtr5hpHtWytzWBgXbBPignuMv9hlDs=;
 b=OpUBZAToXEV40RolmkDo5pbi7BI3S7orDiOYyc8RTu/G/0SZfHGaqgRsl3CHgd7WT1MNwTzq9AzGTX9IM8SanFz207UT5B1IV3zaq+P66wih4DTdlIKahb/C6pLrEyKfwqrBYWqijOT0AjlLraOkaYy6t/8fLeSZ9TYzc0+vuzvgL8OTFh4dYRykT7PSsP4QbW85nglke0lILFzmKcb3n7m9Jcui5KSEoPaKUjexf2vqmx52/8nHhyjXPT8lURfz9dJH+EOMV/ySO3ZbMbEnFyds59tse+36Pi4T9gAINNQvXtc6PEWFiWTJSiZ9DDo1btSltyqwpkcjvmwwgrSZTg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by CH3PR12MB8512.namprd12.prod.outlook.com (2603:10b6:610:158::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.11; Fri, 7 Feb
 2025 12:46:26 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%6]) with mapi id 15.20.8422.011; Fri, 7 Feb 2025
 12:46:26 +0000
Date: Fri, 7 Feb 2025 08:46:24 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Andy Gospodarek <andrew.gospodarek@broadcom.com>
Cc: Jakub Kicinski <kuba@kernel.org>,
	Aron Silverton <aron.silverton@oracle.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Daniel Vetter <daniel.vetter@ffwll.ch>,
	Dave Jiang <dave.jiang@intel.com>, David Ahern <dsahern@kernel.org>,
	Andy Gospodarek <gospo@broadcom.com>,
	Christoph Hellwig <hch@infradead.org>,
	Itay Avraham <itayavr@nvidia.com>, Jiri Pirko <jiri@nvidia.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Leonid Bloch <lbloch@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>, linux-cxl@vger.kernel.org,
	linux-rdma@vger.kernel.org, netdev@vger.kernel.org,
	Saeed Mahameed <saeedm@nvidia.com>,
	"Nelson, Shannon" <shannon.nelson@amd.com>,
	Michael Chan <michael.chan@broadcom.com>
Subject: Re: [PATCH v4 10/10] bnxt: Create an auxiliary device for fwctl_bnxt
Message-ID: <20250207124624.GP2960738@nvidia.com>
References: <0-v4-0cf4ec3b8143+4995-fwctl_jgg@nvidia.com>
 <10-v4-0cf4ec3b8143+4995-fwctl_jgg@nvidia.com>
 <20250206164449.52b2dfef@kernel.org>
 <CACDg6nU_Dkte_GASNRpkvSSCihpg52FBqNr0KR3ud1YRvrRs3w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACDg6nU_Dkte_GASNRpkvSSCihpg52FBqNr0KR3ud1YRvrRs3w@mail.gmail.com>
X-ClientProxiedBy: BN0PR10CA0019.namprd10.prod.outlook.com
 (2603:10b6:408:143::8) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|CH3PR12MB8512:EE_
X-MS-Office365-Filtering-Correlation-Id: af5a0f4a-0941-493d-abc3-08dd47756f1b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZEZMNFVvOHRWT3pML2dOTndyK29zdWh0N0hSY3ZHc3hCMTgxSWZMaWhwMk9G?=
 =?utf-8?B?OFJ2KzhudlBpd0dqVUdPT2YvVktqd3BUeUkxeEdBSGNYMTY5VjMvaFk2R0to?=
 =?utf-8?B?eDllbXVaWEJDWFA2UlJabHF1UDMzdGZZZDNoekd4ZmpOb3JNUzdwdDA0cTB3?=
 =?utf-8?B?U2RpbXI5aVpIVFJFOWg5N2thdVZ4UERHRTZvZm1UMHdHYTJ1YndRYmxiQllI?=
 =?utf-8?B?dHZvQTlVTFNnSEYxeGtYdmwyazdwMnFVTVZldDNNRCtSMFA0cFlIMjNvcjBa?=
 =?utf-8?B?bGhTUkdQL0pqbUN5OEhrd1Q3Q0VKSXBIV29aYjNRSEpya2wrZ2xwUTFOS0Zq?=
 =?utf-8?B?N3J5dUR5MnE5QTF6S28zclJYOHk4WXVyY2V0QmoyS0o2R09xQmRqZkdwRkJt?=
 =?utf-8?B?YnduZ1JWc0tNUGJMVVR0RVlEVnAxTWVyYjFJYkRrdnZlMFFiSlgwdG45Y09u?=
 =?utf-8?B?TklvcGMvWkFiTnd0MnpCQ3ZyQXo3cnpoM2ZYTjdtRjc4eUNLVy9QbHFPUTl1?=
 =?utf-8?B?WjFnUkNNWmt2Qm15dzZlVE11V3VYNVRpbFN4SFQ2UmFzQXNCS0s1UjVFN2Uz?=
 =?utf-8?B?NHNQc1JIREszekVLTTNWQy9RYUNXdjhZd0toaXZ3N3BlYVV2MjIrMHhsaUNF?=
 =?utf-8?B?ZU5YN0hVTVp4akhhdUtMMkpBNXZ2QVZRSXdrUlFMcXE5WUxZa2diaDBwcjdV?=
 =?utf-8?B?QysvV28rVXUvOFFCdVlmSEFWOFFuM25UT1dWQjhlS2oyUUo0YTNzb3BqemY4?=
 =?utf-8?B?UmRLTWZlcmhuVTFLVFJmY1JKVjA4QXFmZUVjV2dva1pZTitGS0xqRzZBNHFq?=
 =?utf-8?B?R1NiOHJnZnoxKzhUVCt4YWkxVVIzK2paNHJ4aEJSOHM2YXdLaC8wQTFCcndF?=
 =?utf-8?B?UE9qZVJqZFA1dzc1S3FCQ2pxaFM5a1BNYk9ZbkRsSzFydW10TjdJbTd0YkJx?=
 =?utf-8?B?YkgzUWxWdFQ0dTJ6Q1l3Rkhjand5VEpiNm5ZOTdDU3Z3YUZDTmM5NDdzWFZj?=
 =?utf-8?B?YTVOV2lkcTlsUG4wNmxFU2lLQXBseHJUWnpnQ2NuUGN6S2ZGNEN1dkNlVnJF?=
 =?utf-8?B?cnFjZjFLdmptUzk4M0Z5U3FEQlRKU2pYNzFlYUI5Y2JkWS9yVE5paXhMemZx?=
 =?utf-8?B?T3VxSjlFa3RuaUh0S1p5cUh3Y0dHSGQyam1qb2NMdWUxVXFUWnJsLytCUGVt?=
 =?utf-8?B?b3BsVlBVT3MwNzk2OWhkSVFZMlRlVVRRb1d3aXdLdnFNbC9HZEhYc1E5NkdC?=
 =?utf-8?B?SWlidHltbkYrcWVJMEJtZldRMHRHWHRQWndvWC9yaHh4RDYzTlhNQk1meVNG?=
 =?utf-8?B?amdadWZJdDNQM2UxY0dQclRSYTBXNk42aWlTQkZkcXFzVWw2RnF1eXZ2dXBH?=
 =?utf-8?B?dTBQNFhJYjR0SW0zeFhTaWw5MVdNSkRMZ04weVZyMXpsSitOaHZoUGw5bkhj?=
 =?utf-8?B?eUptSHpYNjZla0xMcDMzTEJUM2h6S1hPMXpwd3VzOFltQ0NlZ0ZZcDZiT29C?=
 =?utf-8?B?UnBLTTBseWlRY25JdVNGVGRuYU4xNlczU1RUZTlLVVNyeFhHZ2xsQTFOOHow?=
 =?utf-8?B?RTJlNHBkQnJpZjAySDdZS25nQXg4QXNmSHJaOU1yVExBWnc1Q0ErU3Z3bHBq?=
 =?utf-8?B?ejhIcm45Ly9rakhETDVUN3RjeHk2c3VEN3ZrS1Y5WXlaRWY1d2FNdVc4YnNu?=
 =?utf-8?B?M3htdWxrOFBLNVRvNU11czV3aW1OdzdwYnVLOHNCaml1VXV0WXEvYUxVMjVv?=
 =?utf-8?B?cWkxWEdmSVNQcVU3V3IxV1lCOUwyNm9OejNZNjU4dnNyeTI2Y2J6QmprU2hp?=
 =?utf-8?B?eXVHZGhhSzNHY1A4U2ZpeFlwMHNJTmxVMDNETjFsRTdHK2R6RFN5YXQvcm9r?=
 =?utf-8?Q?w0zwpTFh0SuCh?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VjBoMEh0b2lSQVJDWjJXdFRBbkREOUpXRnFuVnNvQnV4MXJBVU82U3prRW81?=
 =?utf-8?B?UzVxWWZOZjNOb0VyRzMyZVpJdUEvRzhpM0JGcndidlo5ZTFjRW9tTzJpK2Nl?=
 =?utf-8?B?dHlQd2ZaYVlNUXZPaUtKLzAxSTdLenhkOEU5QjBXMnpONTVERUlzc3prZzJQ?=
 =?utf-8?B?ZktQcFQrVnROcldhQ0YwdHd1WkE4aGhuZ0lhaWJrR21zZ2JhLzFxVGdLT21x?=
 =?utf-8?B?V1ZPdGMxalVrZi91MWM5bDRETkFneDM1YmpyVHAwWE44aW5WQ3JKQjJQTGlF?=
 =?utf-8?B?MzF6ZEQzN3cydHJjT0pacElmT1dGaUxzTng3L1BYVTdmN05yVFNTYmg3cDdE?=
 =?utf-8?B?a21PMjRFUHlsUWhrRGFVTEJnK3BjMVdRM0g2cVBJVklROThkcmRjdEZJQ29C?=
 =?utf-8?B?bDExU284WkRGV0I1eHFFbllWc21lbnBNVmZpR2dRb0twaFhJa0dmamVyQ0tS?=
 =?utf-8?B?VGhQYUJ0YVp2OSs4R2xjZEk2YW5kOE9Vam0zWEJQaHFKY216blM5Q2Z5T1d4?=
 =?utf-8?B?NjQ0Q09MU0hUdjVNMkpaSWhkaDc1aEozN2RrdHgwaENKelpyT0w0UXVkL3NM?=
 =?utf-8?B?ZWJPSW8vWklQRnJKdnBMS0V6REdGdFBIZFF2M3l6bEFWd2Y1ajdwbGZxdUpG?=
 =?utf-8?B?c01XTHlaV1VaUVlqL2JqTG5aVDhjNmlaa2ZESmlKMXJIUzJaazBrYXVza1Yw?=
 =?utf-8?B?YXd6TE9nYSt6aGZmUHVKc2RsRjR3Q1ZZenA1QTk0T1lxL2hXYkZQRlJ3Sjhi?=
 =?utf-8?B?M2xhbmhtUUZrWjJMeXpuMWJWZkxrNW1jaDJlaG94dHdjVnB2eTgyUm8rQXlw?=
 =?utf-8?B?WEloMHRUNWpnd2lQeTM5SEZOQkdhMFZMVnM3YnNwMHpaMjdTbjNqYlFlS0dV?=
 =?utf-8?B?dUt3azNWM0EwM2M3SVJMaXZoZk51UlFDeXVBeUtYNVM5aGVyQ2dsVzREZ3R2?=
 =?utf-8?B?bnlQOTBucjlYVjgyZ2dVWERTbFA0UThDRTBNc3BrQ1ZvWFhMTm0wWFFwT2Jw?=
 =?utf-8?B?bHpMNVl1WStETjl3SkJDUGVkclRmTElDZXRBUjhseDIxSmxVbzVrVVQvelBy?=
 =?utf-8?B?dUU2UEFVZ1E2UDBkNTY4R2pjZHpsWUJaY21sZTA0S012cjV4MXlKbFVaTHA0?=
 =?utf-8?B?bzVvemZTdFA5NHlxbEx2QWpjd2x4TE9seXBOc0ViSmFVeERCdHVya3EwN1dl?=
 =?utf-8?B?KzVuak95Ri9zRlNPT1VmZVdLVnpPMW4reUJaOFBXS2tQR3M3ZEZSaWxFcnM5?=
 =?utf-8?B?a0p4dzZLbk1naGdxNzVEbklVNTFPVERMNEhqc0FsNVdzRDE1MDZXOFFSUUQ3?=
 =?utf-8?B?Z296T0Z6eFJQM2U4MjlJYU00S0RaY0dJOUMrajZHcDZDcjNHY3dUSWdiMkcz?=
 =?utf-8?B?QWZHcVE4dERranlMNHRVZFVucFZjZDBYV01zL1EzVERVcmNzUWE5Zjd3Q241?=
 =?utf-8?B?OGxqUTdFMERYVkhodzBYb1M5WFJrdFMvcEVzODVqYTRvL0hQOVlNTW9jVHVM?=
 =?utf-8?B?aWF0eGVMVE1BMTlIc2lVWkMza25kSVBaZWJzOXhoSlFLM0NvUGRlT3BmV04w?=
 =?utf-8?B?RURXcVlFRlVaaThQWDgvemRsNjhzVEQxZ21lbUxGaUcwZXBIZjRJTDlIT2xX?=
 =?utf-8?B?dTN4TjRmaCtwZUlMcWpDdjlmeGtZZ3Y5cFBpMHIvMTBsZU1kQmVCS1o2SUFs?=
 =?utf-8?B?QWxRS3R4VURacVd2cWxyMEhrZEc1aEhuMUM4QkwvODFCbDlweXBHZ1R5TExx?=
 =?utf-8?B?OWNRdlI4RXFsOUdVMXZMMklYYlQ4MGpzRndYRDN1T0daM3U4blUwemhwaEFG?=
 =?utf-8?B?RkRwcUdITmovWm94Q0UzRFA4dHkvd0ZYbVFCcnd1cUdKMDJJb0N4TG5uUTRT?=
 =?utf-8?B?bW02TjZid095NDhadDBWQzJoamZ6OU02RmlmVHdRQWxVcHdwaHhMTlFGR3F5?=
 =?utf-8?B?L2JPZ0YrS203NkEzTlJna21kd0V0OW5QTWk2d1o5TTJia2c2ZlFLOWNkbWlH?=
 =?utf-8?B?V1RKOGVLYmFhUEs3a0MrMUNkMzcrcU5BK2JaOVR1Zms1K2VHRXgzQTE3Rkht?=
 =?utf-8?B?bGVTa3hQWlhnMm1ZMWtsSjlaSGwvTVE0Q2U3UzNjOGg2R1g1N2xSZFI0K0Vp?=
 =?utf-8?Q?wGnc=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af5a0f4a-0941-493d-abc3-08dd47756f1b
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2025 12:46:25.9643
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0E5+aMkuoX0k84mGVJfijimn+CtXli7rhsMRcTdO8ViMQf1vc9Wy8EvFxhqBFzDV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8512

On Thu, Feb 06, 2025 at 10:17:58PM -0500, Andy Gospodarek wrote:
> On Thu, Feb 6, 2025 at 7:44 PM Jakub Kicinski <kuba@kernel.org> wrote:
> >
> > On Thu,  6 Feb 2025 20:13:32 -0400 Jason Gunthorpe wrote:
> > > From: Andy Gospodarek <gospo@broadcom.com>
> > >
> > > Signed-off-by: Andy Gospodarek <gospo@broadcom.com>
> > > Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> >
> > This is only needed for RDMA, why can't you make this part of bnxt_re ?
> 
> This is not just needed for RDMA, so having the aux device for fwctl
> as part of the base driver is preferred.

Same for mlx5

I have to apologize, somehow the bnxt WIP patches got included here,
I did not intend that, it was late and I'm juggling too many things
this week.

Jason

