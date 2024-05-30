Return-Path: <linux-rdma+bounces-2710-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FF818D5453
	for <lists+linux-rdma@lfdr.de>; Thu, 30 May 2024 23:13:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E146A282327
	for <lists+linux-rdma@lfdr.de>; Thu, 30 May 2024 21:13:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70D52183077;
	Thu, 30 May 2024 21:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="njUvkqBK"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B11C047A5D;
	Thu, 30 May 2024 21:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717103414; cv=fail; b=aQMd9J8DQx05UJqcaGA9Tw+VpPf2lw6OOqDauWVoyW4ZM+5GmSAYkrLOh7EMaHZF2HSMV0Vu2sxMGMg7q5xLTKWIXu645q1mhwcJAtaO/Cp4kgrf6mhdegTGGjucyvrrN/kQhXXlmxEPmsLnjMwwyiyWHJdwmUO4qGSR2+nA6Bk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717103414; c=relaxed/simple;
	bh=6/5Kg5dAKq9n5TPyVQ+/cjPwOVYm4BRe4GZ1TnnurS4=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=dw78ZmUncOAaJQkN3wYRi5LB1CCp4U2OOGiWa/Rq6KkHH0y88m587ZnipMAMvQrs5rlPWrNmQk24gXuy9C/N/eUxazWWoztE3Mu8TTVqp/+LR37zDPcNsLKs9/VuPwnNtA8Kvtk5imxqH4JDF46OyHV6jrKXocY2Nploz+tiLBw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=njUvkqBK; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717103412; x=1748639412;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=6/5Kg5dAKq9n5TPyVQ+/cjPwOVYm4BRe4GZ1TnnurS4=;
  b=njUvkqBK30kENdQM7nYm3gfC6X+mcsiqRU70YTVBLUO1ckdw47lOjFnF
   i5pRnG/n+iWrAFid9RzMwrUX0x/7sojuvggeaeH2mb0Z6t5zhq2tDTOGo
   KiyTjgs9V8q/VlZPEynX589iOHrbq4ve/VPQAfGExugpzO66jJ3ISPsz4
   HRsPVW6v4snJKaaYCZy1jHFud7KuHs4sWs0P7VhSmvzDnJgC2SdS4jOof
   WIBqdN2g7myyFNVm5P9uXrX9OdQcbAByva2hIeTyHZL0jErtf6+eamqkv
   K0Mu7XEwkmgi7m8CNhri6OyGg+nzT3vskeC73TI6WQRtpieR//V1Gk2p3
   A==;
X-CSE-ConnectionGUID: TtpIIhbjQEeBhrRT8G41uA==
X-CSE-MsgGUID: K/UbffjMQrycILre9kTYfw==
X-IronPort-AV: E=McAfee;i="6600,9927,11088"; a="13444892"
X-IronPort-AV: E=Sophos;i="6.08,202,1712646000"; 
   d="scan'208";a="13444892"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2024 14:10:12 -0700
X-CSE-ConnectionGUID: CUQKqDIVTo+MJHhjPvIkNA==
X-CSE-MsgGUID: eDSrodYkR/+a/lMhadnE3A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,202,1712646000"; 
   d="scan'208";a="36524557"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 30 May 2024 14:10:13 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 30 May 2024 14:10:11 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 30 May 2024 14:10:11 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.42) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 30 May 2024 14:10:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KFaVdKwVxteH//2smA8TtL8+TdrgtQIzyt6MNVNpbO9o77rrHWSVCruX5aXCeQPD6GQdt0864LiyVVCrClfUB2BpIpTVcJHbWrUvmoMbmXndSsIUZ51Ywhvc4hfIVHSzoTZVDs7yQSrdjGQrBNwgZdzRbAsZlv5jkniJfbU48WQoxCS137Lb7wzNq3921rQ31sLebHYBDgDmzaekCVLtDxTWHhIwsqAKJlQrKbldfcpNRhpBmJi3LrFjadiCAhTfHypZG5pQmjEkZzrKmAazcq/jAP56CrUwsj/jFGgzx5EgW4uKgln0Qc2pdGLJ1AWddiHtTiK7SRU9k3qTON4Pnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lTet/daHBNrsWAfl1+6+ValQRpUcNbOknijpcbZykzs=;
 b=aVA6T3JWWUvh+c2Pup+xauBFFTgiMK6aPIyjdAeyIxq/mH61sR+PyT74qOf/kbuTE2OjF4enOYAYSjPsutV28Ia21n+1m8KSmK08aD8tP94CkFjlgTdG/68bhTuVB3cVEWqD5+cEahG6FXzEf0QvA90Wc2hdUZL+tuf1M7o06+LPeE7Q1Jd0mAzhyvXadixEjKNzXx4HkwmfvVDTD4/HWfaB1R8j7Bkay4m/SwravoK/nWLnRV6D/6tgjK2gUyXGQ5Vn6l+WGB92A6oScFRyzxof0ual/3dFpAkKApp/1EkKwK9TKxH5xC2PghjhB64xM8zJMyWnd+zZpJfO7G2NvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by SJ0PR11MB5895.namprd11.prod.outlook.com (2603:10b6:a03:42b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.28; Thu, 30 May
 2024 21:10:04 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%5]) with mapi id 15.20.7633.018; Thu, 30 May 2024
 21:10:04 +0000
Message-ID: <b69ba9a0-3054-42f4-8476-8782f56db4bd@intel.com>
Date: Thu, 30 May 2024 14:10:03 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v6 2/3] net/mlx4: link NAPI instances to queues
 and IRQs
To: Joe Damato <jdamato@fastly.com>, <linux-kernel@vger.kernel.org>,
	<netdev@vger.kernel.org>
CC: <nalramli@fastly.com>, <mkarsten@uwaterloo.ca>, Jakub Kicinski
	<kuba@kernel.org>, Tariq Toukan <tariqt@nvidia.com>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
	<pabeni@redhat.com>, "open list:MELLANOX MLX4 core VPI driver"
	<linux-rdma@vger.kernel.org>
References: <20240528181139.515070-1-jdamato@fastly.com>
 <20240528181139.515070-3-jdamato@fastly.com>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20240528181139.515070-3-jdamato@fastly.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0174.namprd04.prod.outlook.com
 (2603:10b6:303:85::29) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|SJ0PR11MB5895:EE_
X-MS-Office365-Filtering-Correlation-Id: a7af10cc-982e-4949-405c-08dc80ece08e
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|7416005|366007|376005;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Y01aVFk4ckx5ak1LUnRReGlaaTNOUGx6L2lsUGRpWEFhbk1id1YxYVhramVT?=
 =?utf-8?B?NGVWaTBIb2JuV2ltNjJLRkFnNjhZclFwZWRaUzhseEZFcSt0RHFYbk1tS3FY?=
 =?utf-8?B?cmJzTjl5aFp1OTRMd2w4dThucC9QaFJ0Z3dwYjdEZngrTDExZ2hKM2dDQ3Av?=
 =?utf-8?B?YTM0bmdZbFFWYkUzTVBVOGlZZ0VIKzdiakdlaUxQNUNVTFkxRUdPQTBQM0Ni?=
 =?utf-8?B?VklhR3Nhc21DUDlrU0ZhWjBIQnk2WFJsMzAvS0Npbk02RTFmN0JxUDlwSnIw?=
 =?utf-8?B?eHlPRDV1SjAzMFZuSHNVbDJxNXVUU1VVWDVOZ2wvS2V0TGhDK3Z1YnJocTRX?=
 =?utf-8?B?Q1REQVhhVllXd3labmhMY0J4a1ZwUHpNQzJYWkowc2ZBa0ZKMlB2WFc1Z3Nv?=
 =?utf-8?B?alUyVWUyS1hqVWtNK1I3elkrQ1RRWU1NeFp6aGZPbkorTXFsNGFCUC9lZFIv?=
 =?utf-8?B?a016TWFnV000SGQ3ZzZNclZuRUNYVlRYVmdSYm9FSklqVUg1YllVaWV4VTN3?=
 =?utf-8?B?dEhtZStIYSszcDhvQ2trQ1lGNUZVcGxFVFdmdDdhUm9QOERiWlZrWndHYnhC?=
 =?utf-8?B?QUJ2L3pHdjEvTk1aOG1sSDZFaGxtbWJ5VGgxSHFrOElpckdQWVBDandwNXlM?=
 =?utf-8?B?YXIxb0pzVnhUWUJtSDFoaVNIU09jZmQ3SkFTVWlUZWUzUExFT0VmSU5jbTM1?=
 =?utf-8?B?bTRWeGcvbFY1QWRGdzFWWTlkOG5WYy9PWERmNllHazZoeDNTOXorRUp1bGUy?=
 =?utf-8?B?a0ZvZ0tlQVVRZFc0VWZDWGkzMGt6VzdocHFrN0tYblVDazg3eFlxTnk0U0NE?=
 =?utf-8?B?SWxHUDRwZmJMVUo0Qm1kdWZwSnJnS0VVYVRMSmZtOW04L2F3aHlEV3FsK0ZM?=
 =?utf-8?B?VEx6WlpDU3hIeW5KYjVzUDBGTmhyTTBtVXJjRGRTdWcvOHJicldzSEErUkw1?=
 =?utf-8?B?aXUvZXcwL0JvQTFmdjlJRGk3dDkzVW5BYUFOcWI4TEtjL3hoMEpSTVhDTWsv?=
 =?utf-8?B?Z29MbFhoYUppVnZNbjRGUFkzdFlqS21OT2tJbzVWZ09nTDJMSjFOcDhWRW5y?=
 =?utf-8?B?a280aE8wb2JFZ1RnNzFMa2dYYjZ1YTJreHVtcUNjeEhwTDRmL3l0a3ZzNGZp?=
 =?utf-8?B?LzdTQUxFNkI4M2xLNTllR093NEg0d0YvRmNqZ1RaN3p3UTVmeFRYWXBKaHdw?=
 =?utf-8?B?elFMczdiazdyaTdnZFRPVW9adVJ6ZDhiRERrU0l3aTVDNUIwaURlaUMzMmtl?=
 =?utf-8?B?T3F0eG1BbzVqSDJ4YWE5bnNZWUJJSVRrUWhrbHlMTmxVREJLNWlJdkFqSUoz?=
 =?utf-8?B?RDZhNExha1BENXFIdzhPU0NVcmxzYnM5MkhkTUpMa0ErT1lXNHlhckV1NURJ?=
 =?utf-8?B?c3ZmdmNFb2YvOU9kTkRVeTVkS3M2L081Y0JvUjU0dTdqR1FrWEZqbGV4MEky?=
 =?utf-8?B?R2pka084UG53VGpTS1AwSit6NVpHeDBhY0tMVzNCWDBZTEVualRwL3RZc3ZS?=
 =?utf-8?B?K3NIcWJvZHRWN3djZXdpY0szR3QvSkZrdU1YQ3dmTTF0QXVRNUZwZzZSa3pS?=
 =?utf-8?B?WFJWdFFleE4rRVhzcGtxNjF3a21Td3dmMUtyRnQvOUxyTWpMTVdMUFZ4UFQr?=
 =?utf-8?B?dzZOdFNXcE13bEtjS0JLN0tHTTV2S1BiSEFkS05UUjZXSHE3YTJYUnNiTjlT?=
 =?utf-8?B?TUJKcDg0MGNQR3N5SzQzVnRvM0tMVlpubzlmeXRBK3pmSnY3RlBRemJ3PT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(7416005)(366007)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cldTTks2VlluSmRWL0p4TmJiemg5eFFVNnF1NEZqVEk2elFTK3VUV1p5YzN4?=
 =?utf-8?B?eUNWUkJXbnFrMnFsdUU1QjY4cUhuTjE1dUwwZ2ovVnRHVHNPemZNVWk0WGs4?=
 =?utf-8?B?dXNRWEE5VVVabVhYbmg4VlNWL2JQRXV5QmdCaXp2b0JYTG9xN0thQ2VZZ3dI?=
 =?utf-8?B?RTAyeXpiQS9BSGVlcTVYMFk1NUdhQS9rclJxMXFJNXB1ZUhpUnJoYkttSHVJ?=
 =?utf-8?B?Z2pWaTdodWRNQStJb2hWSm9oTXl6ZzluV3hBSlBMT0lLY1dpdXY3Z2xCRjNu?=
 =?utf-8?B?aWN2M3lNWHk1MldiOE1xYTRXQTFLQ3dPMU1oMjNhQkczNjU2YjFKemtlWlBh?=
 =?utf-8?B?Tk81dTMzZUQ3QURhRmhhWmhiNnVaSDFiR1E2Yi9RMHlOOEhrR1h3VDdHUEh3?=
 =?utf-8?B?YnhuUXF6MWJET2k5QU9BMG9DM2lKc0lrSUlmUnEvUWViOUN2bW9JRURoNndk?=
 =?utf-8?B?RXBjY3l5cmk3eFRDdVhYMzY1R0svQ3ppUzhxYUFPenpPdzk5ZVFsb0pKRVJI?=
 =?utf-8?B?UUd0OTRLM2NmOStmQkx4V3h0dllmQ2xuTXo0VHh2VThtZmV0bHlld1V4cmNo?=
 =?utf-8?B?eFpObzBkei9jVEYvd0J5cGpKb3Z6V2kwUzd5aC9CUHBRWVdVKzZXN2pvSlBo?=
 =?utf-8?B?K0F3SWo4SVFUMy81b1ZCRHd6L1A4YUdEQXkxZFZrSUJHQW14OWk5VTZOWW9V?=
 =?utf-8?B?WlEwOWx1dE90UVVXM1diZmRqbDgyd3NoS04ySEZuWFBMaURZZTVQMUJDVXBj?=
 =?utf-8?B?MEFuSXdnYkhXTHJBTDZpOWduOTZTNFBZekx6cU9Ib2dCdUMzME14M3ZaTlVV?=
 =?utf-8?B?aXZhcFhRMEI5cE9XNFFweVZVMlRyZ2VJVjBkMTA2SFJzMlFwSGc2elVaUkg1?=
 =?utf-8?B?bGNKUW80UFQwbzhuN1ljMHIrakUrdmZuTEZybkREK25Vd1JLek1UWmNNV3M1?=
 =?utf-8?B?REkzdkUwV1MwNXhhcHpNcHVmejZPVklwNDhwdUNsUFVKUTRBUzNJR3VROWdy?=
 =?utf-8?B?RFg3NHhQa1N0RkhJSERBdzk5RkZ2dVNlZkdWZ3JKcXd5Q2t3NktaR3hQY1dR?=
 =?utf-8?B?aEpDeTkxb2hZYmxLU0pmSVF6RG5iYlMxTENNd3pXZGVSTUpaZEhKeFFGNi85?=
 =?utf-8?B?REVSbFVGTjE3UWR6cHpRTkptbk5Ec2h6NG1XKzJzaHMyaGg3V0pnd1Q3OGlW?=
 =?utf-8?B?ZHUwbmJTVStEZ0ZoS0pNUFJiVmtXZG5iY1VIM3hwRklkcWJHVEE4cDl2MldB?=
 =?utf-8?B?VHZXb0tJMG5YZURKbFVHbnZPRjBBYUhPdktvNW5BeTRBaUN3cUZSQ29pQklI?=
 =?utf-8?B?TndWT3M1VmFyZmNacWoydXY0MDRMWkd1QU91dGEzTEJ0azM1dzFjeVV1c3Zn?=
 =?utf-8?B?bXcxRnZLTmYrdEhRdzF2SGFRR0RoNjFZZnRUZGp5OXA3SyswVFF2VlZWNWNy?=
 =?utf-8?B?NXV6d2xlM1VGS2lwRnBtQUExMi9NR25Ja0c1VmhrTDhSK08xQ1VIR214TWlH?=
 =?utf-8?B?WURFbnA5dFBqcVZQQ3hHQ1ZjTW8zdUlpdHdyelY1dHNmem01T0FaL3ZtNUZx?=
 =?utf-8?B?UzRWeTNuVXVxeEo3aEVTK2JOdEttb1BGL3pCMEJCTXAyZVZBeCtTUXdKTEVC?=
 =?utf-8?B?TVZUYmRzUFBmMjdqNHpmNC81M1RlZ29zQVlzamU0OEh0OVlzc1liWXdyWDhU?=
 =?utf-8?B?RU43RStnYVJVM2hQZWNDUHVGWVRRR3VrQjB0NEFvRWd4MFI4NDduWjRuaHRM?=
 =?utf-8?B?RkNFRk1IdEl6UUszdXNLNVhqT1JZWTAvU2ZxZkNxZTdmdUcyRXdDRWZqZ2N1?=
 =?utf-8?B?REY1SmVQSERVRThXQU9rSUJDZ1VmRXB2MXBHaUthdDQrQi92dk4rdDZQOHhp?=
 =?utf-8?B?ZGhwWlR1YnhiMXFMN3lDYXAxanBZdXJUU0ltNGhqMUkvWGRFTHRSdlNZczVq?=
 =?utf-8?B?cHJoRmJYZ1NVT0hqMm9hL3lhRjJPY1RNZk1VRFdJdmlzQUp4aVZtSGNYb2JK?=
 =?utf-8?B?c3oweEI3Ujc2UVVFaERzMVZ3L1JMck1wSm5zbVVnOFlPcVBRYU0waVRCS0V2?=
 =?utf-8?B?M1dPd2JPQmFzZkczN3l4U2s1MERlR1ErWEp6dXJUVytqL3NhbVhSWm8rNE9z?=
 =?utf-8?B?UjFQSGpSVmdmdVhSM2lsWXVhR1EyWEs0RVBsa1NLdVEyNGcxNWV0QXlJS2lU?=
 =?utf-8?B?Tnc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a7af10cc-982e-4949-405c-08dc80ece08e
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2024 21:10:04.8606
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 74o01S5UURb24F2MtGkjyeD5IDSJepXEG2vh3C/DzBjyYVberjdCSLIWou+x5ohgcAC352DjWCUltJaiClH8iuQt+4TQfFG9ugeqC6nsBq4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5895
X-OriginatorOrg: intel.com



On 5/28/2024 11:11 AM, Joe Damato wrote:
> Make mlx4 compatible with the newly added netlink queue GET APIs.
> 
> Signed-off-by: Joe Damato <jdamato@fastly.com>
> Tested-by: Martin Karsten <mkarsten@uwaterloo.ca>
> Acked-by: Jakub Kicinski <kuba@kernel.org>
> Reviewed-by: Tariq Toukan <tariqt@nvidia.com>
> ---

Straight forward and easy implementation. Nice.

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

