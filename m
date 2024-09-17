Return-Path: <linux-rdma+bounces-4979-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 506D297B548
	for <lists+linux-rdma@lfdr.de>; Tue, 17 Sep 2024 23:35:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 74F9C1C21A6D
	for <lists+linux-rdma@lfdr.de>; Tue, 17 Sep 2024 21:35:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCC931862B9;
	Tue, 17 Sep 2024 21:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cornelisnetworks.com header.i=@cornelisnetworks.com header.b="C1Io+qT8"
X-Original-To: linux-rdma@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11020142.outbound.protection.outlook.com [52.101.85.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 850D71531C5;
	Tue, 17 Sep 2024 21:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.142
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726608924; cv=fail; b=tB1J1hGb5ekXqEp8zbs03fkh+Ry2vJzOdgEvzRNsjt+ZaVprJjwy4Cu2zEvGyO/25mV0VvVwcamF/MG8Bs4KaGLKBBozL/nOoHxTMJ7qE3JuZDkMWo4bCOENo3mTA88zQPaLEVNR3shgOHKTeE13dHanCQFGDHOz2zI3qI9ku20=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726608924; c=relaxed/simple;
	bh=xhOithsnpCrNUb5SJpcGnFx4RefmCZvGqvRWuuswjOQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=HmHAwVXPry//PDPQSl45Yo5B7QYjfOkWlodh+ltYmjbFD/fHDaozkO2weWF7plz5DYwR7ifp3k17L263ScyIshhGAZporQnCjTxxXZx3gaT4N93zTll7gLmudUWKKw/toG909/kaP6ya+pk5C524UxsUvYB+qLRfvCospViEWNI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cornelisnetworks.com; spf=pass smtp.mailfrom=cornelisnetworks.com; dkim=pass (2048-bit key) header.d=cornelisnetworks.com header.i=@cornelisnetworks.com header.b=C1Io+qT8; arc=fail smtp.client-ip=52.101.85.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cornelisnetworks.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cornelisnetworks.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GUQL9yFsYqZGaETz4FGfGFcsL3iUL/QtwjBbXUinU0f0opahW4InQH+L9BsludFvJc+k7KDm9OR+4EhmlWAHo0bwi+jw01DYTdR6HZXc47Shfq/RnI4e07OHEzBh6HnE1HjaqjpWjC6k/3ZkFq+3yvxxmzjeUAlk4dmdrroigb2OZYL/POclbiDLyIpMCMqlfvgBWQujj8qV+buBmLf+WuAbh7vE36rMadH4njRcahi5P3/liPhUxfOiH0+RY8LXHi6kxqevtAjnoKAj5qhhdPyuIr1RIek6c5sD4zFP9qWk4hTVZ/YB5XOylUP+6sCtZmeFTlztTvIZuPWsR7ArfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H//5Rj28x7tyzPfdhHXZ+Puwbu1SNy/pQr/RavkdOg4=;
 b=cZyvWN+OcdLNl0tdLDIxjd4CP+eBz4FFYE/n6Mz0aFWITnwuB2iJfHqLV0l4yhhjFP24vViULG3l/xnrUY+VdncQpF5KZZw3C9EjixiAtQFOYkWQwREHwBpOM29W1tR4qacaLh7rMRRJkF7hAPEQ70mze2V9SqJJsmf3hPud/1FIBDLEsx39ZTvlD1wurFd5M7frX9RCQg2pmPSIPgbgKOMzO3tW2MtPEyUVG37jcBXpUB9BQv5mVBSX+ZKbRhgldFfmxImLlu5N6nkSH6ty8UGQmor30cOjdk6p3GzzR+Y2iFjde/RCLOyYFxZnAZA03cjBct928ugC4LwIe8Cm8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornelisnetworks.com; dmarc=pass action=none
 header.from=cornelisnetworks.com; dkim=pass header.d=cornelisnetworks.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornelisnetworks.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H//5Rj28x7tyzPfdhHXZ+Puwbu1SNy/pQr/RavkdOg4=;
 b=C1Io+qT8rr57947NR024T5NMWv7EWetKF/fPwvSViev+mQhgLLxcbjPe+uCEAHTJ5Qrt6ErOjS5KFGORqaGTIbdOjBz92QQMAH9cRqT8CAL7GVFrao7Uy/FOcawdEpSfHeFtj2qIUoJsmNA3bLI8v6OgAhn1LX5SJTp7jrWlM5+dOohVEQ2966LAN+31ALsXk1HzGoHG53naRTYg4JFwmKvRqopkC5nsvMouTTug7Ep8rP1qac+P97OBJfcNwyJGubyyv4d0J3glceg3zD64YlhE43M0TJUIfrIBKf6mwBovTUPpfNU6zXUDRzMzHDYEHJBk87YaIRNoigmzTg7AKA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cornelisnetworks.com;
Received: from PH7PR01MB8146.prod.exchangelabs.com (2603:10b6:510:2bd::18) by
 CH7PR01MB8978.prod.exchangelabs.com (2603:10b6:610:249::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7962.24; Tue, 17 Sep 2024 21:35:19 +0000
Received: from PH7PR01MB8146.prod.exchangelabs.com
 ([fe80::2972:642:93d1:e9d4]) by PH7PR01MB8146.prod.exchangelabs.com
 ([fe80::2972:642:93d1:e9d4%5]) with mapi id 15.20.7962.022; Tue, 17 Sep 2024
 21:35:18 +0000
Message-ID: <350493ca-53ee-4e37-9e18-c63657878f73@cornelisnetworks.com>
Date: Tue, 17 Sep 2024 16:35:16 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: How to create/use RPMSG-over-VIRTIO devices in Linux
To: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Bjorn Andersson <andersson@kernel.org>, linux-remoteproc@vger.kernel.org,
 OFED mailing list <linux-rdma@vger.kernel.org>,
 "Dalessandro, Dennis" <dennis.dalessandro@cornelisnetworks.com>
References: <cff37523-d400-4a40-8fd1-b041a9b550b5@cornelisnetworks.com>
 <70cf5f00-c4bf-483a-829e-c34362ba8a70@cornelisnetworks.com>
 <ZuBiLgxv6Axis3F/@p14s>
 <aff4e2e3-0cb9-4ca3-84f7-2ae1b62715e4@cornelisnetworks.com>
 <CANLsYkyuB=BsswRmbSbjDNMqz0iGHrviLMGfNJLx-HJ60JeEMA@mail.gmail.com>
 <591e01eb-a05b-43e6-a00a-8f6007e77930@cornelisnetworks.com>
 <ZuMEW9T2qSTIkqrp@p14s>
 <d8a4001c-d8c7-457a-a926-1d03e4f772fe@cornelisnetworks.com>
 <CANLsYkw-5i_4=UXwtG_SfR7rkjKEz3ieSOP2s4SOCozkWMct7w@mail.gmail.com>
Content-Language: en-US
From: Doug Miller <doug.miller@cornelisnetworks.com>
In-Reply-To: <CANLsYkw-5i_4=UXwtG_SfR7rkjKEz3ieSOP2s4SOCozkWMct7w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: CH5P223CA0022.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:610:1f3::12) To PH7PR01MB8146.prod.exchangelabs.com
 (2603:10b6:510:2bd::18)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR01MB8146:EE_|CH7PR01MB8978:EE_
X-MS-Office365-Filtering-Correlation-Id: 4528d739-4bdd-4029-74b5-08dcd760a028
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WkhSSGExMkIvY0xqQXJveUNIMjk3UXNNMjhFM3MyRHhJbkZCMFY2bVlOcDJm?=
 =?utf-8?B?TllhV1VHSUZVclJYTjlZK0trR2VPaHhzVXB2QXJKMWNUUVZnbDRBLy93aEVE?=
 =?utf-8?B?VnM1cFdvWXdaaDBWb0dZbkpUSVlnb2d4ZndtQ25HZ09jVGNzeVBqL1BxTXdm?=
 =?utf-8?B?ckRUKzRURHh2TFQxdEFoVVNEc2d5VWMyZEFJZytLODVrQWlhcWxRYi94MDJ1?=
 =?utf-8?B?SzhOZHVHYzgwQVE2alFYWDd5TzN5ZmtCK2QreThNT3lBcDlERDJHM3puSHlB?=
 =?utf-8?B?REZja0Y2aFdZbDlqcFF6U254UzNINmZvaHliTWd0S3JqQzJkcG1saXEyTWds?=
 =?utf-8?B?TytiK3k3YzBMSE9VUS9KQVVMTnBCeVlyMEtNMkVNVENPTEF6MGEvZGJRUXhy?=
 =?utf-8?B?bHFwUnNMMHlmWllPTHVZQnVmVGswYUNoLzdmNm8zTDlXbHFBaDNNbkgvSzdh?=
 =?utf-8?B?RFllVXlINHJ3QmNMMTVvc29PNzdmR21mN0dXcE9uVXJ6M2ZaNzFlcTlkRHov?=
 =?utf-8?B?dHZxdEVDWngrZWpnVG11LytQVXh2Y285RjNkTmRCTVkvbzY4MmpKRitqWVpr?=
 =?utf-8?B?WkxVZFlKZ3Bxdlhma2JENFBkMlR5bzJJTkhXRFlRSCtqVlQwZ1NRUTFzZmVs?=
 =?utf-8?B?Q3lLcjNiSXpCaE9xemtWaFYxeDdlb2xFdFRhWDV6K0tBcG1TcWN5MkRkbmZy?=
 =?utf-8?B?Nkx2UG5PaGtUU0RubW5MamlMQitqVkFCbS9xL1RBZUlUa250cUs5emJWZTBo?=
 =?utf-8?B?VXF6M0QwN3ZFdXVRRFBhODFQMzBEZS9SeFFsQlhBSHJEUnFBajh3bzMwMVVq?=
 =?utf-8?B?TENCMzBzTTVWNTEwR0gzVStFKzhIaWNxUHN3MXpzQzJoQU82eDRlUDY5TmUr?=
 =?utf-8?B?a1M5WEpvM2J3RkwrVzNiUXIrSjB3R3lSR211MGljU0lRNEU2NndYcmw4cnhY?=
 =?utf-8?B?cmFWWHRLeGVMd05MMEQ2K0JBV1h5Z1N2OE9ZRWV2Mzgxcmd3K3VxWVFreHZL?=
 =?utf-8?B?WlozZXA0TkUxOURGZFkvZ0d3NkdoUzM0Qno2NUVmMk1aUVdZYVpwc2JhcVNC?=
 =?utf-8?B?YTB1N3d5UTJHTHkreWZtNlhIQ1dFb2NiTFpxZTdobUF1K0xKaVpxMnVrOTRB?=
 =?utf-8?B?NjZtRzlzSldSMDJydjJFVXQveFh4L21ZbzJwSFZ5bnF6Z0FBZUZnTWx6N0dj?=
 =?utf-8?B?aTVTT0x5eGtwY00ra1lZcTdNZEJmc3AwOEN3TktTcUdkMFZYMVp1SzJMeU5o?=
 =?utf-8?B?dW5UZGp5bUVSbW5SMkZuK2ZCeUVoQ2pkQWNIQ0E1SnY0Mzd4K2plY0MranZX?=
 =?utf-8?B?ZWg3a1huTTdaSFNLK2NRMTJkQmxUUG5WRmwwZXJmbUtIUEY3MkxVTHUybFQv?=
 =?utf-8?B?c0VUU0Q5bFBzSy9TQ3I1ZHNYZXpnMmFvOTZKVm1IaXF6WHlyektqa0dBeXpD?=
 =?utf-8?B?OG9meE5pY0Zyc0h2ZkhQNVF4ZUJaamZvaEsyM1RPNzdJQnNlSktDUG16Vk1U?=
 =?utf-8?B?MW5YVFMrMWtHbmJsT0poNlNJSzlYQXZFY0pTOVNkckRudzNzbGpVckNKN1R4?=
 =?utf-8?B?Sm1LNEVJSU9sRmx5UnRTSDhCQ0djWHZzMkJMdDN2UFZMQXpXWlBpODhKUHdM?=
 =?utf-8?B?bjkrbTFWYm95YnQ3b2V0Q2Y5YUxwUmo4YUw0Nk1MUUYzVGRzSjlsVi9qbjJX?=
 =?utf-8?B?Nk5rVG9jVVR1VEhMb3htRTJZUkFFYlZPM0tQaGxUZENoS1dTNGxISWxrK1dF?=
 =?utf-8?B?ZUFKNjNZYzBVa1VJbjFvYWNpNzdSMkN5TDNvb3ZtYnZFeEZKVDdzaXNzVDc4?=
 =?utf-8?B?SnBVZnFTM0hLbklDakZrUT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR01MB8146.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OFZ5RUZXMk1oa2ttZG12RTJOMStaNzZhR2xzY0JzYklmRnVLVGozMCtKUXdX?=
 =?utf-8?B?MS80QllvTm9sSnZjMGZ1S1Y2RThuRCtjU2swT1RLaFZ6K0owQkxLY0pVZGw5?=
 =?utf-8?B?M2lFWk9RaTBSalJnQVJzeW1EMlBJSXZuVDJtTllIclp5Ukx6RHZCRXM3Rk9J?=
 =?utf-8?B?aExSUEtVTTJVNThabzVrQ3dKbmRMMklsSnRnUVk5a0ZTT0k4ZXNzK3o4NUZZ?=
 =?utf-8?B?YXE4ZytSandGOFcwZmpsMnNpS3lZRXMyc0s4ZUoycGxleTFKN0pVTHg0WC9j?=
 =?utf-8?B?T1h5cGdmc0IwWVRUSENtTzJHWmZta1BKZklWbDk5NjIyNzNLUDRhVCtZa0lW?=
 =?utf-8?B?NTIvMEZWbElvVmJ2T2xWNWdYSnVyRjNrNjFRL2tGZFdQWCtqaHoyNCtqZWJ6?=
 =?utf-8?B?QnpuSWJHYUVxRjFJK05iWVRMODdxNEEwTXpodUJzNWRnWjZFSHZoeTg1NDAw?=
 =?utf-8?B?SXVLYmI5WE1jNXRmSjNJUzhjQU9IZi94OVUxclZYYUpPa01pWlBZeWlxR0hi?=
 =?utf-8?B?TTVOdis5MmlrS040RldzMnhGaTZXUkpEL3lGOG5qcklKMTBIaElhd1paOFUv?=
 =?utf-8?B?STJPRVByZzgvbEVGK0gwLzY2NDlxRnBXSGJ3U3I3ZVBTNHFUZGxSK0xKeHJR?=
 =?utf-8?B?MTFaRmh1d1kyOThkd0NJQU5BWDFzUUtqOVoxZ2NTVHl4SkoyTzc1UjFPT0kr?=
 =?utf-8?B?Yk5lR0JEYzArNEZaMVpyS0N1TVJYV1NUYmF6Q29uVTlrZTdLZXc0SE9EUDF0?=
 =?utf-8?B?MU1iUm82RnU0OEc3Q2NLbURyU3ZncUdGWldBZDY3T2dqSm9zNGF2V0FlelFQ?=
 =?utf-8?B?WWNDSXNmNkJMSEs2cjJEU3N5WEVIV3FLSjhTVEN2SXc5MWVXcjdrTG9qb21h?=
 =?utf-8?B?Q0xMTks4Mm5GZDRETnpjckRUektrSURaZUtwMjlNb2EyZ2FKOWE4RE04Y2Iz?=
 =?utf-8?B?dmE2Ukhobi9RZ0M1OVRQL0hEWDNtUVQraWFaa0l4RG02MHZlMFBaV0QzeEZl?=
 =?utf-8?B?WkxPWUFxVmpoRG1jcXVPbi9iczZQQms3eUZBbXVOQU5iZWl6T0REajZPbytj?=
 =?utf-8?B?SVdRd05Delo0azhMaHBQSlc5Q0M1S3IvK2lUVHdaM0JrUHQ3UU1NWDhTbm1j?=
 =?utf-8?B?WWZzQm1VMHFiY2RmTncvQXk4SnE1ZkUyZ2Z5UnoxYVc2c3FEc0RTc2hCT0gv?=
 =?utf-8?B?NHZVdENzWTVXMmE1MTB1MS9KVUJWa1RLelNMUStNWTRpTVhYTE5ycEp4YVRN?=
 =?utf-8?B?UWtXZGd3ZTZvQ0VBZWxBN1Jabm40SlVVRldha3pWcWVnT1E5K0ZwRVVRZGM4?=
 =?utf-8?B?aWxXZzJGTmZoeDd2N1l3cWpBeURCQXMxbHJPVUp3MkZLNkpNVVhpVkpoTFN0?=
 =?utf-8?B?aStJc1NIcE40TmJQcDRIS000amx3SU5odHd4MVk3MVVpeU5WSG5xVW80QVBU?=
 =?utf-8?B?aVpPbXVXNlpQeDRDQmZRMmZrN21jbHhyTmJ2U1lQUWlpZzNGV0wxOGdnR2lZ?=
 =?utf-8?B?cERzNFl2bjlQaFd1MHcrclp0b29TRlRKN3NFMER2bkRsbXpiaDVjelhpazlq?=
 =?utf-8?B?ZHgwQ29hbmRndUVBR0tJWmJoZHdjSTNrVXZrcGQvU3kxQ2F3VkV1NS9FM1Ur?=
 =?utf-8?B?LysxakFXZEJ4TEN3NHBPcG1GOW1lbUJsNFMvMEg3WnI0cmtsb3hYb0lWYWhI?=
 =?utf-8?B?MVFtZ0d3NVJtUXplcUJpY09SZlVydGszMmNtL20rc3VaaVZ6Q1hjanJLVXpJ?=
 =?utf-8?B?QUVTT3A3b0p3blR5RjMyYmV6RzNuVkgxYk4xZWpTb3RJMkMvb3dHRms5MWRu?=
 =?utf-8?B?Q0hESXhYcHlxbWJ0WVJvZ3pHUGRQR3oxbWs2bTRnYmM5bkpnb2NFN0JqVGtG?=
 =?utf-8?B?SW9FMmtGTUE0NWdyNnRkenBhRzgwa0hoanF3MWZIK0xSR3p5U2JiNWN3SFQw?=
 =?utf-8?B?ZlRRUUlQZ1c5Z21oQmtxWUpNMDBtbytsQ3BkcUo2V3lFZFJBbCtOajgzb3lY?=
 =?utf-8?B?WHp0NXJlcklmT0dZS2dYSTE1NnVXelFEcWNmM0Z2MnhOU2RhQ3BsellRK0Zu?=
 =?utf-8?B?R0trYWZ6Ui9sYnYwU2V4NGZaWGpKdjB1ZTJBeDVCMEhNeEtpd0NBd3BwWkM0?=
 =?utf-8?B?REtneS9wa3RqY0lpejNYUFpnUEFLRFJuejR5Q0NKdEFORHE2UjRWRTFiNXNI?=
 =?utf-8?Q?agQbEiVJ6kM0wTDl80301gg=3D?=
X-OriginatorOrg: cornelisnetworks.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4528d739-4bdd-4029-74b5-08dcd760a028
X-MS-Exchange-CrossTenant-AuthSource: PH7PR01MB8146.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2024 21:35:18.5219
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SqvMlJuagG63hUK0rEuS5sJcHer/wITLJYdUEvsQUDGRNTTXQWOzKCNG91YhvVAoV99+0AIrTPIhW7j7Rd8YFUyUAqnpMJwwW6leWFnSEHw0YpLeNCCm8piPpfWW6yeK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH7PR01MB8978

On 9/13/2024 9:39 AM, Mathieu Poirier wrote:
> On Fri, 13 Sept 2024 at 05:46, Doug Miller
> <doug.miller@cornelisnetworks.com> wrote:
>> On 9/12/2024 10:10 AM, Mathieu Poirier wrote:
>>> On Wed, Sep 11, 2024 at 12:24:07PM -0500, Doug Miller wrote:
>>>> On 9/11/2024 11:12 AM, Mathieu Poirier wrote:
>>>>> On Tue, 10 Sept 2024 at 09:43, Doug Miller
>>>>> <doug.miller@cornelisnetworks.com> wrote:
>>>>>> On 9/10/2024 10:13 AM, Mathieu Poirier wrote:
>>>>>>> On Tue, Sep 10, 2024 at 08:12:07AM -0500, Doug Miller wrote:
>>>>>>>> On 9/3/2024 10:52 AM, Doug Miller wrote:
>>>>>>>>> I am trying to learn how to create an RPMSG-over-VIRTIO device
>>>>>>>>> (service) in order to perform communication between a host driver=
 and
>>>>>>>>> a guest driver. The RPMSG-over-VIRTIO driver (client) side is fai=
rly
>>>>>>>>> well documented and there is a good example (starting point, at l=
east)
>>>>>>>>> in samples/rpmsg/rpmsg_client_sample.c.
>>>>>>>>>
>>>>>>>>> I see that I can create an endpoint (struct rpmsg_endpoint) using
>>>>>>>>> rpmsg_create_ept(), and from there I can use rpmsg_send() et al. =
and
>>>>>>>>> the rpmsg_rx_cb_t cb to perform the communications. However, this
>>>>>>>>> requires a struct rpmsg_device and it is not clear just how to ge=
t one
>>>>>>>>> that is suitable for this purpose.
>>>>>>>>>
>>>>>>>>> It appears that one or both of rpmsg_create_channel() and
>>>>>>>>> rpmsg_register_device() are needed in order to obtain a device fo=
r the
>>>>>>>>> specific host-guest communications channel. At some point, a "roo=
t"
>>>>>>>>> device is needed that will use virtio (VIRTIO_ID_RPMSG) such that=
 new
>>>>>>>>> subdevices can be created for each host-guest pair.
>>>>>>>>>
>>>>>>>>> In addition, building a kernel with CONFIG_RPMSG, CONFIG_RPMSG_VI=
RTIO,
>>>>>>>>> and CONFIG_RPMSG_NS set, and doing a modprobe virtio_rpmsg_bus, s=
eems
>>>>>>>>> to get things setup but that does not result in creation of any "=
root"
>>>>>>>>> rpmsg-over-virtio device. Presumably, any such device would have =
to be
>>>>>>>>> setup to use a specific range of addresses and also be tied to
>>>>>>>>> virtio_rpmsg_bus to ensure that virtio is used.
>>>>>>>>>
>>>>>>>>> It is also not clear if/how register_rpmsg_driver() will be requi=
red
>>>>>>>>> on the rpmsg driver side, even though the sample code does not us=
e it.
>>>>>>>>>
>>>>>>>>> So, first questions are:
>>>>>>>>>
>>>>>>>>> * Am I looking at the correct interfaces in order to create the h=
ost
>>>>>>>>> rpmsg device side?
>>>>>>>>> * What needs to be done to get a "root" rpmsg-over-virtio device
>>>>>>>>> created (if required)?
>>>>>>>>> * How is a rpmsg-over-virtio device created for each host-guest d=
river
>>>>>>>>> pair, for use with rpmsg_create_ept()?
>>>>>>>>> * Does the guest side (rpmsg driver) require any special handling=
 to
>>>>>>>>> plug-in to the host driver (rpmsg device) side? Aside from using =
the
>>>>>>>>> correct addresses to match device side.
>>>>>>>> It looks to me as though the virtio_rpmsg_bus module can create a
>>>>>>>> "rpmsg_ctl" device, which could be used to create channels from wh=
ich
>>>>>>>> endpoints could be created. However, when I load the virtio_rpmsg_=
bus,
>>>>>>>> rpmsg_ns, and rpmsg_core modules there is no "rpmsg_ctl" device cr=
eated
>>>>>>>> (this is running in the host OS, before any VMs are created/run).
>>>>>>>>
>>>>>>> At this time the modules stated above are all used when a main proc=
essor is
>>>>>>> controlling a remote processor, i.e via the remoteproc subsystem.  =
I do not know
>>>>>>> of an implementation where VIRTIO_ID_RPMSG is used in the context o=
f a
>>>>>>> host/guest scenario.  As such you will find yourself in uncharted t=
erritory.
>>>>>>>
>>>>>>> At some point there were discussion via the OpenAMP body to standar=
dize the
>>>>>>> remoteproc's subsystem establishment of virtqueues to conform to a =
host/guest
>>>>>>> scenario but was abandonned.  That would have been a step in the ri=
ght direction
>>>>>>> for what you are trying to do.
>>>>>> I was looking at some existing rpmsg code, at it appeared to me that
>>>>>> some adapters, like the "qcom", are creating an rpmsg device that
>>>>>> provides specialized methods for talking to the remote processor(s).=
 I
>>>>>> have assumed this is because that hardware does not allow for runnin=
g
>>>>>> something remotely that can utilize the virtio queues directly, and =
so
>>>>>> these rpmsg devices provide code to do the communication with their
>>>>>> hardware. What's not clear is whether these devices are using
>>>>>> rpmsg-over-virtio or if they are creating their own rpmsg facility (=
and
>>>>>> whether they even support guest-host communication).
>>>>>>
>>>>> The QC implementation is different and does not use virtio - there is
>>>>> a special HW interface between the main and the remote processors.
>>>>> That configuration is valid since RPMSG can be implemented over
>>>>> anything.
>>>>>
>>>>>> What I'm also wondering is what needs to be done differently for vir=
tio
>>>>>> when communicating guest-host vs local CPU to remote processor. I wa=
s
>>>>>    From a kernel/guest perspective, not much should be needed.  That =
said
>>>>> the VMM will need to be supplemented with extra configuration
>>>>> capabilities to instantiate the virtio-rpmsg device.  But that is jus=
t
>>>>> off the top of my head without seriously looking at the use case.
>>>>>    From a virtio-bus perspective, there might be an issue if a platfo=
rm
>>>>> is using remote processors _and_ also instantiating VMs that
>>>>> configures a virtio-rpmsg device.  Again, that is just off the top of
>>>>> my head but needs to be taken into account.
>>>> I am new to rpmsg and virtio, and so my understanding of internals is
>>>> still very limited. Is there someone I can work with to determine what
>>>> needs to be done here? I am guessing that virtio either automatically
>>>> adapts to guest-host or rproc-host - in which case no changes may be
>>>> required - or else it requires a different setup and rpmsg will need t=
o
>>>> be extended to allow for that. If there are changes to rpmsg required,
>>>> we'll want to get those submitted as soon as possible. One complicatio=
n
>>>> for submitting our driver changes is that it is part of a much larger
>>>> effort to support new hardware, and it may not be possible to submit
>>>> them together with rpmsg changes.
>>> The virtio part won't be a problem.  In your case what is missing is th=
e glue
>>> that will setup the virtqueues and install the RPMSG protocol on top of=
 them.
>>> The 'glue' is the new virtio-rpmsg device that needs to be created.  Th=
at part
>>> includes the creation of a new virtio device by the VMM and a kernel dr=
iver that
>>> can be called from the virtio_bus once it has been discovered.
>> I don't completely follow. Is there some KVM configuration option that
>> causes the virtio-rpmsg device to be created? And then our host driver
>> will need to be able to respond to some notification and dynamically
>> adapt to each VMM being started? I'm not getting a clear picture of how
>> this works. I'm also not clear on the responsibilities of our guest
>> driver(s) vs. our host driver. For virtio I saw there was the concept of
>> a "driver" side and a "device" side, and the guest seemed to be creating
>> the driver and the host created the device. The rpmsg layer seems to be
>> more complex in that area, so I'm not sure what actions our guest driver
>> with take vs. our host driver.
> KVM has nothing to do with this.  The life of a virtio device starts
> in the VMM (Virtual Machine Manager) where a backend device is created
> and a virtio MMIO entry for that device is added to the device tree
> that is fed to the VM kernel.  When the VM kernel boots the virtio
> MMIO entry in the DT is parsed as part of the normal device discovery
> process and a virtio-device is instantiated, added to the virtio-bus
> and a driver is probed.
>
> I suggest you start looking at that process using the kvmtool and a
> simple virtio device such as virtio-rng.
Looking at the virtio-rng code in kvmtool, I must be missing something.
That looks like it is userland code and never calls into the kernel to
actually create any sort of device for VIRTIO_ID_RNG. It appears to just
add it to a private device list, and I'm not finding any place where
that list gets turned into real devices.

Are you saying that the virtio device on the host is not created until
the VM boots the guest kernel - meaning the VM kernel/driver must take
some action to cause the device to be created on the host? I was
expecting that when the host boots our driver would be creating some
sort of device or entry, and when guests boot our driver there would
register and get matched to the host device. It would really help if I
could see an end-to-end example of this working. But I need some help
identifying the various components involved.

Is it going to be necessary to modify the VMMs to get virtio_rpmsg_bus
devices created?
>>> Everything in the virtio and RPMSG subsystems are aleady tailored to su=
pport all
>>> this, so no changes should be needed.  As for the VMM, I suggest to sta=
rt with
>>> kvmtool.  Lastly, none of this requires "real" hardware or your specifi=
c
>>> hardware - it can all be done from QEMU.
>>>
>>>>>> hoping that RPMSG-over-VIRTIO would be easily adapted to what we nee=
d.
>>>>>> If we have to create a new virtio device (that is nearly identical t=
o
>>>>>> rpmsg), that is going to push-out SR-IOV support a great deal, plus
>>>>>> requiring cloning of a lot of existing code for a new purpose.
>>>>> Duplication of code would not be a viable way forward.
>>>>> Reusing/enhancing/fixing what is currently available is definitely a
>>>>> better option.
>>>>>
>>>>>> Our only other alternative is to do something to allow guest-host
>>>>>> communication to use the fabric loopback, which is not at all desira=
ble
>>>>>> and has many issues of its own.
>>>>>>
>>>>>>>> Is this the correct way to use RPMSG-over-VIRTIO? If so, what acti=
ons
>>>>>>>> need to be taken to cause a "rpmsg_ctl" device to be created? What
>>>>>>>> method would be used (in a kernel driver) to get a pointer to the
>>>>>>>> "rpmsg_ctl" device, for use with rpmsg_create_channel()?
>>>>>>>>
>>>>>>>>> Thanks,
>>>>>>>>> Doug
>>>>>>>>>
>>>>>>>> External recipient
>>>>>> External recipient
>>>> External recipient
>>
>> External recipient


External recipient

