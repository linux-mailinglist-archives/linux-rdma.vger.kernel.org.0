Return-Path: <linux-rdma+bounces-7927-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4775EA3E842
	for <lists+linux-rdma@lfdr.de>; Fri, 21 Feb 2025 00:20:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A58E3BE695
	for <lists+linux-rdma@lfdr.de>; Thu, 20 Feb 2025 23:20:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A92CA267384;
	Thu, 20 Feb 2025 23:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ahodI3Oj"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2046.outbound.protection.outlook.com [40.107.93.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5A4A1F4E3B;
	Thu, 20 Feb 2025 23:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740093622; cv=fail; b=ePemp3H+QPiS29kA0Mq5+DYJ9lIteFTNUK2lCyUeL1P4OxpPcZim0eZgeyxib200dSdZ+8aKJsOZPdCgaVX4q0dQENwcQaawUsphBgt7TZ8YWNwrRs41a7u0nBf8ACbwO333WEbAPPOTCxz2exnzmYk3IoqBR1HIvjBTyWPtsbA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740093622; c=relaxed/simple;
	bh=ypUEDTSugUC+oja31Dg/L6Fb+xD2jBAF+EVWCeX4Vgc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=t/xW/Bo2Pcohxi0iZHzJoo0genNZPJV2VS4/65sjOUUTjl0wdI47254K5FNVsgZe+kUp1LL4CB7eV7uAmjULoH/IiBrLc+MG5KgyLrPY+16vVz8fKOuhFxrnARpLXKuvg2Osm/h4u4jzvg3ANGBPzsstqJA91udeGu/viPj7uvg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ahodI3Oj; arc=fail smtp.client-ip=40.107.93.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E785116CV4C9DgqnJea5f3eZpn+ieF3pbgq571+Y+gAvQabOOfUqhVIo+64z/Cco60tT3O0RrthWgYUCBEuL1ILhGjREmBfK9ra/ByJ6958kSG7bVM7gWDbLMmHgmYWDASJ9nJHWBWouDxXdNGFbYiJl8K8hIk03flAducrKnuOIeaBw9OiJluxQ5UL9Fos4PgRvGyr2XIFLuGkwmIG3O+dForRGuLWDbBsZvcx9yByNUM0TC0EGoTk3axvZNR6tdW1Tgoitf8BZc5n+6oUpnvnwXqPRSk/kXsAZ9LhHPQQ0da/b/QC4e3VhS5fTORB7YWBuPzMnTf+q33lFW+mP+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XlUYBsyMRIwGafiC9+FeXNjGVhN5RqKLP0shDcP4Kdw=;
 b=mVRwcCwmUT9Va6kQWtaSoWuvYNX5FETT5kiBc4/62oGquUqmjto4C9A4ZF4jxf+GZiUKzbufRjuZhjk2vpDY0ufqpVKShWlavjmC01EWCfnOLNt3NMbOx233u7MKM6KYPK4FRtEce8fs+7pBz4JkdBZp5nl+v0fjUo7B/B1CJCqECmtctjM1QR2k3wxPDbjogr1GRbm+bX9mfarmlzaCbMBbxQ8+47rUY2MluE4wd6rHgLBqFZ37CvO7TeFerEuC1jgJBTI5VXWGNCb2i32yapUksSVk/mmgdVBxIzM8ovbzMKzdXHeoh87aNLB1m2vHwRE/WswU5oAhQXDQhpD37Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XlUYBsyMRIwGafiC9+FeXNjGVhN5RqKLP0shDcP4Kdw=;
 b=ahodI3Oj/AT+3vw9IwTcCbbgPesQ329qNILSK34+FklzKUIhoyTbDNIqS6xx6VZgkjJXkw3V1OvWAB4fSBEi8bWRgQABRycpPMFHRrLme5LCPzjxe3CohPemrLcqe2GZrPYB4/XLMRTSA0euqRBoZ2dQaqBrAEQF/gD1QPw8Hl0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6583.namprd12.prod.outlook.com (2603:10b6:8:d1::12) by
 SJ2PR12MB9086.namprd12.prod.outlook.com (2603:10b6:a03:55f::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8466.15; Thu, 20 Feb 2025 23:20:18 +0000
Received: from DS0PR12MB6583.namprd12.prod.outlook.com
 ([fe80::c8a9:4b0d:e1c7:aecb]) by DS0PR12MB6583.namprd12.prod.outlook.com
 ([fe80::c8a9:4b0d:e1c7:aecb%5]) with mapi id 15.20.8466.015; Thu, 20 Feb 2025
 23:20:17 +0000
Message-ID: <6fc8dae5-9bfb-4b74-b741-b85159a0daef@amd.com>
Date: Thu, 20 Feb 2025 15:20:14 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH fwctl 2/5] pds_core: add new fwctl auxilary_device
To: Leon Romanovsky <leon@kernel.org>
Cc: jgg@nvidia.com, andrew.gospodarek@broadcom.com,
 aron.silverton@oracle.com, dan.j.williams@intel.com, daniel.vetter@ffwll.ch,
 dave.jiang@intel.com, dsahern@kernel.org, gospo@broadcom.com,
 hch@infradead.org, itayavr@nvidia.com, jiri@nvidia.com,
 Jonathan.Cameron@huawei.com, kuba@kernel.org, lbloch@nvidia.com,
 saeedm@nvidia.com, linux-cxl@vger.kernel.org, linux-rdma@vger.kernel.org,
 netdev@vger.kernel.org, brett.creeley@amd.com
References: <20250211234854.52277-1-shannon.nelson@amd.com>
 <20250211234854.52277-3-shannon.nelson@amd.com>
 <20250218192822.GA53094@unreal>
 <604b058d-88e8-436d-abf7-229a624d9386@amd.com>
 <20250219082405.GC53094@unreal>
Content-Language: en-US
From: "Nelson, Shannon" <shannon.nelson@amd.com>
In-Reply-To: <20250219082405.GC53094@unreal>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR06CA0006.namprd06.prod.outlook.com
 (2603:10b6:a03:d4::19) To DS0PR12MB6583.namprd12.prod.outlook.com
 (2603:10b6:8:d1::12)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6583:EE_|SJ2PR12MB9086:EE_
X-MS-Office365-Filtering-Correlation-Id: 542eceb0-186f-4b86-a6fc-08dd52052334
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?d2plakdlS0VDQlRocFhWclNaaWlSZUNCY01wcm53N3poclpnUlFrS1FFb3hk?=
 =?utf-8?B?OG5RcWVZYzYzMkhzempsbEF2WlRmL3UrdDU3MC90ZVEwTkR1MGFQY1Z0Rm5I?=
 =?utf-8?B?RlZMMDFPeGxmajRlQ25uU1FKVDNsV2ZBUSs5bWJiUDVadFJPNUc5WGN1VUc1?=
 =?utf-8?B?RjkzU0JidnBnYVJuN0J3MUh3UDdPYkhuRXNYaXJmbUFzeXlkMlJRYk1EbFFa?=
 =?utf-8?B?YmJLckFtM0FCemF1cmV5eUlvVHN0cmExREQ2ZzdmRGlBa3JhTFhaV0lvcWg3?=
 =?utf-8?B?SjIydjdYMVJ4aTBteWJHdGlYNmpZZ3ppZFhlR3FoUnM4M2dpQ1luTXFDOW5K?=
 =?utf-8?B?QUpUQ1VTeXpkVlNYVkttTkk0dlhpZ1RNUGI2RjkxSmpQbmxMS1JSaXlYL1pF?=
 =?utf-8?B?ZFdLcHBFaGM2Z0REc1FuNGg3dmtpZjRkRkNiQ0E0UDJxemQydkY1V2d3Y1Y0?=
 =?utf-8?B?UnhRb2pBanpKSXRDWjV6cGtocUJxWE40ekpmVisrV3VHeHo4ZDFrQlFYS0dJ?=
 =?utf-8?B?RWNOazlLd0cvUGxoUzlmMUJUelgvd05tNEg0Mlg5dVJSR2I0Nkh4Y0llWlFK?=
 =?utf-8?B?SE5QNDM0Y3NIbDRkRXdVakJTNmJYVGRKOThkaXE4M0xiR3FabXE5Mmh1eldC?=
 =?utf-8?B?VnVrWGVkZUxIdFVyTUV6QlY1NWxCRzVNb0t2MEZSSDRYT0JnR3BIL1JIWGFh?=
 =?utf-8?B?UE5uZUJoWVkxTDVOZGlRV05sRXlBZGhIbnA2cExCYW8wNnEwMGtYNW9nVDZ3?=
 =?utf-8?B?dm5DdFBQMU5KdzA0VGVMM0E1RU9GcDRoQys5eFphZ1IreWR6eFdwczZlcjJz?=
 =?utf-8?B?UVl0eXYyY09SSU9yYzlra1dQdmRjcm05R1JyQkNJQit1Nm9OK0VuTzArNElt?=
 =?utf-8?B?TWdmSmg0a3pGTTVQZGFTR2JrK1gzUzVxaVh1MGllRWJqcytDVzlSU21vUkVj?=
 =?utf-8?B?cWQ2SWo2ZUp0Q09IU0lYUGRySlhEbm85U2dsK0RIc3dycDhpRmtpNmRCZU1R?=
 =?utf-8?B?QUpaQ2luTTBycE5hUGE0SnFNMmpzbW1GcGhENWRMNlZmcDFjTWk4UHdvV3ln?=
 =?utf-8?B?K2JaclFnL2dBcVNSZFF1M200OEJFeEd5RWhmREJyQmRpTUxJTFFnK0pYTzc5?=
 =?utf-8?B?eDlHd0pYeEZzVnppY2dmemF0N09NSmRQT2JuZkcxL2tGQXZoMVRtK2NtbTBa?=
 =?utf-8?B?T2ZNdXNNYlZKQTZvUFQyRE01Qmlzbmo1WTh3SnVaM2ZrZHNjS1JLRTFuckVn?=
 =?utf-8?B?bmxTL251aVkyeVloY2FLM0hhQ2lGb1dwOEgrZGNPaHBrM2FIZHNjOGkyWDJr?=
 =?utf-8?B?dHNQaC96QzlHWG9uNXExVThjcnp2THh5L3ZrYzd0L0grcHBhWlZHYXE0QmVC?=
 =?utf-8?B?bWV2MGxGRTNCQTYzYnV6elBCV2JIYnVPZ2F1Uk55ZTlvTnZDbHU3andPcWx6?=
 =?utf-8?B?RW5xRTMzaFh3Y2I2czIvc2ZTb0ZzdUxmeVE2ODF6Sm93NHg1ZDZMU0xXVVA0?=
 =?utf-8?B?ekkzRlBDSkp3S2dOOGpRZlRiSHpQYzNRY0tMeUtOUzJXd2xRZWZyQUlPTno4?=
 =?utf-8?B?OURGOXlFb3JhTnl5aDgwbGJFTmFSTlVkS1dSSGoxRHMzT25SbDlGbEJqc0pM?=
 =?utf-8?B?OFdEUU9YWm5CSWdHOVFqdDZpQzJINzI0bzlFbEhndjFSWllJNHJXbHhVSjJx?=
 =?utf-8?B?aENNWVVWUjJDRTI4UXlSbjA0cFlSZ1d1Y1kwWWhUYXRWQ3pBWUZtMkFldWdr?=
 =?utf-8?B?RkZmOEtuYlorbS8zSTc0endmL3cxaXlXNVBjTEYrZmluUGg0OWNLNk9LWjM5?=
 =?utf-8?B?RnQwbXFhYVRUVTVNZE91Z05qWVFhc2NLUzZNNDd4bWhWVmc1bndicndNeHov?=
 =?utf-8?Q?u58276BdG065M?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6583.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MlRvNFBaMEx2ZTFBK28rVXI5WnpjcitLc1VhZW9POVhTQUNiSm1BeU40RmtR?=
 =?utf-8?B?TGwyWEw4LzlSTDFjc291cFNabWtwelg0c1RJK2NURW1FVW9pZnRyajRXYVpW?=
 =?utf-8?B?bys5ZWJWY1JWWXdSTXdkQWZ0RXFnb2o4NWpQcDA0bmJlbWUwdFVyT2hNdHQ4?=
 =?utf-8?B?bm1vUnJPVWJZM0RFT2t0RjhVTzkrRVYvUE1iVkV1MUxGTG9va3crNFhCVVoz?=
 =?utf-8?B?UzRCS0tSRTdQMjFDc1lNVE84bmF3bklVeXRjMzNrWlJleWpyaVZvS0V4WWg5?=
 =?utf-8?B?UlJVclgzcWJoNXhzREJqbjBlOHJlRTRRNG03bWFNYnZMN3VpRkhYUTNKVjRn?=
 =?utf-8?B?dk95M0dVYmRrNlkzVEpFTjVsdDVkUVdzMzJDK1NpVkcxVldIWnVzWXdPS045?=
 =?utf-8?B?bXBZR29STDNOQ1duZDJXQXdXdWxxNndkdXlFdjdRU3ljRm1CZlhoOFY1cXBj?=
 =?utf-8?B?WFdmRi9nZlFRS0tjZm5WS3pSdVgwVGdEL2pQakNZZEFqMktMZ2NmaDlTME1K?=
 =?utf-8?B?VytBMWVvc2dqMUpKenRwV3B1UGM3QWdSdVhSUnQzREIyNjI2S1E0SHVVVzBk?=
 =?utf-8?B?Zm8vbjE2TmpKSndORXl5MCt1SVRxWTR6eTZQSnRBZWxZb3U2akFOaEd4SWxK?=
 =?utf-8?B?aDR6b0U3NlI2ck0vUEV0WDF5R2xtVmp6SndaaXFtUW9jV210amZpWmY1Zko5?=
 =?utf-8?B?N3RJSnFIV0dPS3hqN20vY2FydEc2SzVsRWozdFJFN1dmSlE0MkZaYWNMcGY4?=
 =?utf-8?B?MUgvekhDRkVrR0NUYlV6aHdXSmNFRzRxUjlXazNhMm5kOVBkaWJxMHJvNDNX?=
 =?utf-8?B?ckdpbnprcExQSXhqdVJ2Sit3RU0va3Z1aWF1djd5T1ZZaHFvVjFQTFM4RjBO?=
 =?utf-8?B?Tk5qY1lxWjNQSjN1azU0K1JGN042bGdqZ3haWlNUaGtHdkhmaTBydFMvMnVU?=
 =?utf-8?B?eXJaZ0dvMFlRc2JVY0dSSi9nUUp0Wk5DNCtpVC9SWVMrRHVBUWZxcUZVR1pz?=
 =?utf-8?B?cnZiUit6V21PNHdpRU5QWS9pN2JORGNtODRkSENsTEN5WTEvd3k3dHRkSHZN?=
 =?utf-8?B?djE5RVVHNm5jaEVGbS9Sa1pkbVRaaWg1YWdyTzJDWXV2QThsSlVBeUdnVVR3?=
 =?utf-8?B?MWtwd1JEZWJhTk9wVzhxMTZ0UERiQ2FxZW9QTnA0Sm5aaHZKc0lIcTFuWWtD?=
 =?utf-8?B?RlpyaG05alZKdGU1VDkwOEovZGYvS3hxamIvTDhZZG12cFF4bXZ3bE9KZlov?=
 =?utf-8?B?Z2RwakZiWGptNXJpS0NkUThJVnBIUS9qQjIwQVRESXdEWDlZMTBTK1R6UTR0?=
 =?utf-8?B?ODhBNGxJQkJDWkdhVDlIZGRBU0RwdVF2VnQyR01ZNS8rd05hd092VFN3S2hF?=
 =?utf-8?B?YitHTFl3WEN5MFFTRzVJcU5jTTBpZ3JrM2tRMkxwY2dpWG83ZFoyYVRrUU4r?=
 =?utf-8?B?WGFNUHQwdTg0cVdrdHhsaDNrcWE0OUQ3NFJyS0RzbEs0RXpIMWFmaHl6MW4y?=
 =?utf-8?B?MjRMRmZsQzdaVzJyU3M3c3dUMjdJZTE3azZjbCt1azZDTW9jc1Z0UnJTVDBZ?=
 =?utf-8?B?UFN5aFdVSTdwS1VLQVVGZ0ZLRWhsK1ZrNnhMVGZVZzY5anI2V2cwMW5QVTJr?=
 =?utf-8?B?ck41Q2h4VXZIZHRQL0ZEcG5nZTE0OVJORWV5ZHB2dS9vUHRTeWlmNTNhYlVK?=
 =?utf-8?B?RzBYWnFXdWYvZWV5cjNsd2FROUdsNXJWUGlvcEUvMnJiM0w2ZUplNk5IbVAv?=
 =?utf-8?B?VVZoNVB5RHFWTUxqQVBWazhHcnc5N09UNVNmM1FwR3FjMmRCdFFTS1RZa1Jz?=
 =?utf-8?B?dEc5VUpvLy9MdW52S3pQTlVkb0FUVVhpaWFzSjRCaWc1TjZGM3VpSXNmdXVY?=
 =?utf-8?B?Rkg5bkJUcWErNGFIR1pGbjBIZG5UWDliem13Z3dGb01zcDZ6Z2l2VXEwWk5E?=
 =?utf-8?B?amtMZ3dEOXpodGhIdm0zQUJ0bGxmZS9CdFZoQ0lhTW9JZlcrSmVwbExnVlhV?=
 =?utf-8?B?MWZyS3lLZUpybG1ZbHBHSlQ2NnYxdWczaGk1cVowc01yNGN4R2VQZHVPZG0z?=
 =?utf-8?B?SndwMFRySFNQRHBkL25idHBQeisrNkZYTWZnZ3dYQzJSL1E4VzhYY3h1NXNI?=
 =?utf-8?Q?9mJ3P1s0lhUECV8jbjpv/kCJV?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 542eceb0-186f-4b86-a6fc-08dd52052334
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6583.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2025 23:20:17.7466
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2TCx08ircJbvK6ogCBxyOYqAAWGKqzItvSVodO9RZr8mBIafMpw5ICOUGv9Ke6BqwOZsYwciyMri6ehr8rr0pQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9086

On 2/19/2025 12:24 AM, Leon Romanovsky wrote:
> 
> On Tue, Feb 18, 2025 at 12:00:52PM -0800, Nelson, Shannon wrote:
>> On 2/18/2025 11:28 AM, Leon Romanovsky wrote:
>>>
>>> On Tue, Feb 11, 2025 at 03:48:51PM -0800, Shannon Nelson wrote:
>>>> Add support for a new fwctl-based auxiliary_device for creating a
>>>> channel for fwctl support into the AMD/Pensando DSC.
>>>>
>>>> Signed-off-by: Shannon Nelson <shannon.nelson@amd.com>
>>>> ---
>>>>    drivers/net/ethernet/amd/pds_core/auxbus.c |  3 +--
>>>>    drivers/net/ethernet/amd/pds_core/core.c   |  7 +++++++
>>>>    drivers/net/ethernet/amd/pds_core/core.h   |  1 +
>>>>    drivers/net/ethernet/amd/pds_core/main.c   | 10 ++++++++++
>>>>    include/linux/pds/pds_common.h             |  2 ++
>>>>    5 files changed, 21 insertions(+), 2 deletions(-)
>>>
>>> <...>
>>>
>>> My comment is only slightly related to the patch itself, but worth to
>>> write it anyway.
>>>
>>>> diff --git a/include/linux/pds/pds_common.h b/include/linux/pds/pds_common.h
>>>> index 5802e1deef24..b193adbe7cc3 100644
>>>> --- a/include/linux/pds/pds_common.h
>>>> +++ b/include/linux/pds/pds_common.h
>>>> @@ -29,6 +29,7 @@ enum pds_core_vif_types {
>>>>         PDS_DEV_TYPE_ETH        = 3,
>>>>         PDS_DEV_TYPE_RDMA       = 4,
>>>>         PDS_DEV_TYPE_LM         = 5,
>>>> +     PDS_DEV_TYPE_FWCTL      = 6,
>>>
>>> This enum and defines below should be cleaned from unsupported types.
>>> I don't see any code for RDMA, LM and ETH.
>>>
>>> Thanks
>>
>> I've looked at those a few times over the life of this code, but I continue
>> to leave them there because they are part of the firmware interface
>> definition, whether we use them or not.
> 
> How? You are passing some number which FW is not aware of it. You can
> pass any number you want there. Even it is not true, you can
> PDS_DEV_TYPE_FWCTL = 6 here, but remove rest of enums and *_STR defines.

When pds_core starts up it gets ident/config information from the 
firmware in a struct pds_core_dev_identity, which includes the 
vif_types[] array which tells us how many of each PDS_DEV_TYPE_xx are 
supported in the FW.  This is indexed by enum pds_core_vif_types.

> 
>>
>> You're right, there is no ETH or RDMA type code, they exist as historical
>> artifacts of the early interface design.
> 
> This make me wonder why netdev merged this code which has nothing to do
> with netdev subsystem at all.

The pds_core was originally brought in for supporting pds_vdpa and 
pds_vfio_pci.  At the time, it was essentially following the example of 
the mlx core module; at the time there wasn't any push back or 
suggestions of a different place to land.  Maybe further fwctl and 
"core" related discussions will suggest another approach.

sln

> 
> Thanks


