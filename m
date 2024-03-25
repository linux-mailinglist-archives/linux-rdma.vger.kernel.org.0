Return-Path: <linux-rdma+bounces-1541-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 823C088A838
	for <lists+linux-rdma@lfdr.de>; Mon, 25 Mar 2024 17:05:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F2191F673FF
	for <lists+linux-rdma@lfdr.de>; Mon, 25 Mar 2024 16:05:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9646B136653;
	Mon, 25 Mar 2024 13:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cornelisnetworks.com header.i=@cornelisnetworks.com header.b="GmuOPr8a"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2107.outbound.protection.outlook.com [40.107.220.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3156512839C;
	Mon, 25 Mar 2024 13:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.107
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711374426; cv=fail; b=HU+duy0q4cHkKfpua2ShmftxW2Kp0dLfYByOc7IFsi28Xm4Gujzw+iXXkpqM+6URp9jRN9S7GiaB7UlludDrCse3bTVutPanvsayywbMTDYMm20GGRxZFdjhzMrypHNRGWWeCaEUuPLjIobK9x68FgC6o9JI2Fxr2YiHEA3iObs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711374426; c=relaxed/simple;
	bh=eFF8r3iZ9fQHzHtuPCgBh7wcp/WMvetI2RC9M58ZYXA=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ccOQxDUCyAIjNmvnHWPoa1uzWGbCiiG3knqo//4WZoZllTmfcjG8c0eizBUzoVx34N0+lTHGeaIQi4rny0Y1okCN4Uo9KGcQ/XaHmPkoMIz4CJbdNc5q55uXCTM2pC4q1oBYCPH8nDQdHEdwr+BWMJND5oFyEb7Z9HLTaw9VOXY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cornelisnetworks.com; spf=pass smtp.mailfrom=cornelisnetworks.com; dkim=pass (2048-bit key) header.d=cornelisnetworks.com header.i=@cornelisnetworks.com header.b=GmuOPr8a; arc=fail smtp.client-ip=40.107.220.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cornelisnetworks.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cornelisnetworks.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RAd831rZwBlK+Nb5AHmIs1ML3uhZeRW/iv6ish8XAMns3u8y145+gvLT8daRUCRHsQY4ob29QyCly0mATER4ZOoN8zbGjsQgmDhjZ+g3xmh19W/C8P0zCHqLbGQDR3vyzvqz0mWCAlgO909zEtv0pQS003QXt7mew4Qv4nPVfR+mr+ucjluzz0RgHfM2PaECbFtkegXFHRXyBMEih6CCUdXkrt7rOojeK/91Uqxw7kgK2qlowtfmQVP3iizWXGGSpxvkVKxXzSe4Kv0BK7lw3dX8j51w3omDB/ncFEjNoIfttn5N6f4h4GICq6MO3jTG+irHqJk9KYDKpOFtmkTLvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EtKTjqfzBfJ/mUo5n+Ev3i9rSz1iq25WuXMTngbMyoY=;
 b=fFDtPPFYKbD14mOLHgJQsyqUvaVeboQwE3Whhhx6Xx+3OzQ3ipKxijAZvV8NLU+jaV4uFfn2835KJAtGxakYy2ThEvSETkqSVXx8O8CAD7xZz8OJYDpZ3x0Opg85W66o+UTfNGTHc6zKGyz7LmZJk1h7i1y7gsowDamCDbEgmP4pRtlmsfi2W0c2ZrIxlF/PLjksIvseOaxSQjfVY6uh8xDaDcfX4WvzFggfJYG+JfYC5D1mxjf+skFbSplBoNTvdwvV2+gL86f7KBvX7ZIQKmrNw7yeroDqYpHfTeB07ImRGkAmWY1xujxVfjDqJk9i3t07BjvYzSSZuLF/fPYL9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornelisnetworks.com; dmarc=pass action=none
 header.from=cornelisnetworks.com; dkim=pass header.d=cornelisnetworks.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornelisnetworks.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EtKTjqfzBfJ/mUo5n+Ev3i9rSz1iq25WuXMTngbMyoY=;
 b=GmuOPr8ad8xws6G49w1uMUE7Z+Gp98dHen+AtMNXEji6auXF46zhGKUaNQ1RX861AWPALnCsDiBrCM2v9fHpqbTyYCp3n0ZA12KbVD92jAkynxb7eUmB+JD+PU5UWdgHACmnHDcmNI+iKXtWHSw7dOlHEVlcuCt/u2LTCyiZ5fvFQy/uyq+SxWRua9etBGuAwW/087iCvncTudKie759wQYNeDLJAnvplmqzib2FW2SrUJGSzKwv17KTpeFnbf4055xgrD1+QeMEKEArzL+RF8bpozxlWYwVSEybHf/xx+JNZdarE6OJuDFZb0jYi63jj8BoMoEuxHCaVJqN8VNwSQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cornelisnetworks.com;
Received: from SJ0PR01MB6158.prod.exchangelabs.com (2603:10b6:a03:2a0::15) by
 PH0PR01MB8071.prod.exchangelabs.com (2603:10b6:510:29a::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7409.32; Mon, 25 Mar 2024 13:47:00 +0000
Received: from SJ0PR01MB6158.prod.exchangelabs.com
 ([fe80::82ae:ed8b:de46:cff2]) by SJ0PR01MB6158.prod.exchangelabs.com
 ([fe80::82ae:ed8b:de46:cff2%4]) with mapi id 15.20.7409.028; Mon, 25 Mar 2024
 13:47:00 +0000
Message-ID: <16813060-e834-4cb8-bfc2-0a3cbb45420a@cornelisnetworks.com>
Date: Mon, 25 Mar 2024 09:46:53 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/28] infiniband: qib: Use PCI_IRQ_INTX
To: Damien Le Moal <dlemoal@kernel.org>, linux-pci@vger.kernel.org,
 Bjorn Helgaas <bhelgaas@google.com>,
 Manivannan Sadhasivami <manivannan.sadhasivam@linaro.org>,
 linux-scsi@vger.kernel.org, "Martin K . Petersen"
 <martin.petersen@oracle.com>, Jaroslav Kysela <perex@perex.cz>,
 linux-sound@vger.kernel.org, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org,
 linux-serial@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>,
 platform-driver-x86@vger.kernel.org, ntb@lists.linux.dev,
 Lee Jones <lee@kernel.org>, David Airlie <airlied@gmail.com>,
 amd-gfx@lists.freedesktop.org, Jason Gunthorpe <jgg@ziepe.ca>,
 linux-rdma@vger.kernel.org, "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240325070944.3600338-1-dlemoal@kernel.org>
 <20240325070944.3600338-12-dlemoal@kernel.org>
Content-Language: en-US
From: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
In-Reply-To: <20240325070944.3600338-12-dlemoal@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BLAPR05CA0031.namprd05.prod.outlook.com
 (2603:10b6:208:335::12) To SJ0PR01MB6158.prod.exchangelabs.com
 (2603:10b6:a03:2a0::15)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR01MB6158:EE_|PH0PR01MB8071:EE_
X-MS-Office365-Filtering-Correlation-Id: 42ae3e1e-fceb-42cf-81fc-08dc4cd20b7b
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	NkdFG2JtQIPC2noGgsf3qA3K2S3VQ6ZTduSZrbsO5FfDV2KGzUjx7uW93Qbn8N/nPfL20kikHzvoJ6pdKyi5l+jOuhGO8O2tDGlrswreJw8D96/C9WFDnEdj7ZQmB9qCczjUtwCrm5rCfvJX7/84i1u6YmqdGeSrK9FHNwHXbQJ8v1AdMaxUluLQYQa3Y+RS8w+raygaGtzEkBdtMEuZ7jpCNNeZaMbqaZ54vDCv7tNfENR/V1d57gRebGgkIvLh2z4W/I0WWK+ncQnLLYND1URfKUt7GuMhskaatFaO/QiwAS7NpdSgjRX3EoicQpmeiMx5SPZkJhHk/tR4eIUEymEgR9mEuo+M1/Ym9hu8kOaQuF2DtIhZa4+sdl0ULi5lyaPMQRRdM3Y4j2ayr8F0O7SW1qXvoI31xMTIEH2c8aQkK64tFcE9NnKMyssuPV4FOvPe9GY0Vr+yFkwVV6/gc3N6MlXgismrn54GqlgcCb04ZELAj7gvpYsqdZHwUdD1XljSpSbnd0Z5kfAY1mSEMxDQMhdJF3Ox7yh/fuPpNMdyED1OfhbQ0abj5pUua+0AWfnrX5pAYHxiY1+LaJXHyFxxWieoKR4VUAdG62lAJl3jtWtAuk2+/MXFLsTOeWzSW3k8Oi6UUrV8jJ2Z75qWAD3+8Vp76yJbhGBHYmLkXLlZXxaETp1Uj6/AIxiGkwI5HqPm1Fjak4NGVZnAubOx4mlgERlQfzvWA1bAm9My1O4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR01MB6158.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(52116005)(7416005)(376005)(1800799015)(38350700005)(921011);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RHkzMUlYMWswaGs5b1o1TDJUa0NvZWdXWlBYRTlVSDQ2cVgrUmQwNzRTWVJy?=
 =?utf-8?B?RXZXU0FIMytIcStzNHpYcWtnUTZyM1lEWFpscmNLUHRzUkJMT0VxUVJwZnI0?=
 =?utf-8?B?eUh6L2NpeWhtK1Q2U05vUVZZaVF6VjlEMCs5QkFaTDVqU200Rkw0MU53WmFS?=
 =?utf-8?B?RVpkUmFDKzdaalB4b3lUazhFNHpUWW4vOFFlVmVKQTdGMURKY2NQVXpRTDZN?=
 =?utf-8?B?UzJGODlUbjQrSGFLLzVOMTBnQjBKOG1LcHBOZTMxdUxnRnRqRWtvUVNxUWtn?=
 =?utf-8?B?UFFLblhzU1FXU09QNUNhbDlEUFV4ZmlFMFQ4MmVRa1NpWkVyYkt4S3FiSDFj?=
 =?utf-8?B?VS9XcE5RaU1YVDdPVnRkMHBmSUdvT1ErL2ZjTzJNSG1hNmQrQWs3ZkM4QVZP?=
 =?utf-8?B?c0NlVC9kdWVDaGo0UGdoWjR0OUJ6S2VFU3c1ZC9oLzBmOC9XbCszdXRyYy9B?=
 =?utf-8?B?N1hGZ3JtYjdXcHNwQ3YvZGFYazdvejJRWlk1WkdPSzBsN3dkMjBjUGc3eGFP?=
 =?utf-8?B?UEFJQXB3eXN0RW9TeGdpWFNSRm1GaUs3NFk4TWtRM1hUVnV3eHJ4SkdmU1Rh?=
 =?utf-8?B?TkZ3OFo4aHNsSHp1aE02TXRkcExZSHJnd0x3eEszRG5XdW42ZXY4b0V3VU9j?=
 =?utf-8?B?Q3NlRkQxZjZTZ25Fb2NEL2RCeDFjaVJhODdUQmpybFFud3hCUVVlRG1JVUxB?=
 =?utf-8?B?RlZDYWpiUlZWRWVLN0VseDQwUkJLM1dzbmhtT3dQVDlYK1QyRlAxMVBXUkFv?=
 =?utf-8?B?cWRxU0VscElWTlBRSjBqbnpiVmx3QjZxUWZnajJMTkQvT0Z0STAwZFd3M3Ju?=
 =?utf-8?B?aUNBYXRLZVlVbnQ1ZVJWV0VSVkJodzFURS95S1NjaGtlRElqZjVmNnYzZkp5?=
 =?utf-8?B?TzRsZTFBaEUrblFEOEUzTHBETEc3UFYra2MxZVVWdzdITFh0SElwWXMrSHRC?=
 =?utf-8?B?dTl3dlZWMWpNS2ovYnB6VVZYa0J0K3lOSDgvU2pyR1J6cTZPYmEzNWxzM3l4?=
 =?utf-8?B?amdhSWNZNlVicklJTm9Kb3ZRMHZFYWVyWlh3UzU4WUx1N0xaQTNYRGRrQTFC?=
 =?utf-8?B?TzllWlFMU0dhanQ0SUNLWWN1VGVUdlRWUVBrbVNrNlRXZ2xDZzRpODJmL2pP?=
 =?utf-8?B?NWJvSGN3WkM2S1JFK2gydW9FTmQ3cnd5QU9lOW9VbUJNZjB4NEE1Q25SS01N?=
 =?utf-8?B?YkFCMEJMa3F2VVBJd1MzZ1hlWisrSDgxVFBvSGdRMEpUYlBRVnFQZUVDbERE?=
 =?utf-8?B?YW0wOTdpK2E5RnNOM2UvMVBjaUQ3YWgzNHdlWktzUmc4a1dqaGx3c3QzYkJz?=
 =?utf-8?B?T3V4eXRoTitmZjUyTXhsMzdlU0szOHlXSVdrS1dEUFJpVHp0dk5rV091WXB4?=
 =?utf-8?B?MTJORnNodHNna05ST0tONVloRldpSHAvL1JrcnJUMkhOUy8zU000TTQzem9P?=
 =?utf-8?B?NE10SlJsaDZYZ01jTENjRyt2WE1rWWRadk5XVXp1cE9mWmE1YVdTb2xDRHJZ?=
 =?utf-8?B?N29wSkhSb0VmUXdHWjY0L2xNQU1lbDd1VjNzYkEvOEQyZUY1TFhxVTNZWUx5?=
 =?utf-8?B?UTRXRlNUSmtIaTdYQzMwQlQvdW8zNjdHTTdZaXVVbjVZeWg3N21WSGVwOXNC?=
 =?utf-8?B?OVhvbFc5QVhvYVYyNmtNbkh3K2hudGczL0RUM2hkcXlQeWVMYU1qSXVMTG5R?=
 =?utf-8?B?U01mN1N1d0lwYkI0TFdwR25SM3NPSkdMdzJ3YjlDbzNJUFdiMkdWeFRjc2Vq?=
 =?utf-8?B?R1B3MGNLUHVsTmE3M0VSTjg1dW0wMjh3WHp4WHJVd0FpcmczMjlyRnowUDJD?=
 =?utf-8?B?ZUFiWTJmWkNUc1lpV1V6eVdwWG9oMWVrMU1UaExlYUlIV0R6dmNoMk9kVTNO?=
 =?utf-8?B?L0FwZFVCUld5cHdIS0c4QmpDYUwxSE1YbC9QV3RIQzdHR2J3YitiMzdiU1Np?=
 =?utf-8?B?SGx5SElPY3hWUGEybTgxTU8zYysxVWhLU2FpZ1RXQXl2bVMvaEdBQ252Q2E3?=
 =?utf-8?B?OFZRYUY5TFpTMUxJSm5tbTcwYVRZYjBvSy9VcGxmZ3RCV2daYmJVTzdGcG01?=
 =?utf-8?B?bmtjcDFWdmJqQVZXbzhBZjA1MjZwT2NnelhPSldQNlkxUC93RUtZV2ZYRkEv?=
 =?utf-8?B?eFNFUzI5aVFvZERyc3owTkRqVDRKYzRlSUhYaVhrUkx5dlgzaUtGeVFrZlkv?=
 =?utf-8?Q?+4xMh1KdZq/OddTOpQzB7oM=3D?=
X-OriginatorOrg: cornelisnetworks.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42ae3e1e-fceb-42cf-81fc-08dc4cd20b7b
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR01MB6158.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2024 13:47:00.1417
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sqZwRkWUtVGu0ChU6OBr/yiUAaKxJRx4qWvv1S3q66D4Gp4TguQjV33ceWB18OvdVcQfPL2njTbR4mOjMdntI4DB4T6rhRGXtYC8Zd5VcAOC0AVHG9Oam4lowIB5EWVM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR01MB8071


On 3/25/24 3:09 AM, Damien Le Moal wrote:
> Use the macro PCI_IRQ_INTX instead of the deprecated PCI_IRQ_LEGACY
> macro.
> 
> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
> ---
>  drivers/infiniband/hw/qib/qib_iba7220.c | 2 +-
>  drivers/infiniband/hw/qib/qib_iba7322.c | 5 ++---
>  drivers/infiniband/hw/qib/qib_pcie.c    | 2 +-
>  3 files changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/infiniband/hw/qib/qib_iba7220.c b/drivers/infiniband/hw/qib/qib_iba7220.c
> index 6af57067c32e..78dfe98ebcf7 100644
> --- a/drivers/infiniband/hw/qib/qib_iba7220.c
> +++ b/drivers/infiniband/hw/qib/qib_iba7220.c
> @@ -3281,7 +3281,7 @@ static int qib_7220_intr_fallback(struct qib_devdata *dd)
>  
>  	qib_free_irq(dd);
>  	dd->msi_lo = 0;
> -	if (pci_alloc_irq_vectors(dd->pcidev, 1, 1, PCI_IRQ_LEGACY) < 0)
> +	if (pci_alloc_irq_vectors(dd->pcidev, 1, 1, PCI_IRQ_INTX) < 0)
>  		qib_dev_err(dd, "Failed to enable INTx\n");
>  	qib_setup_7220_interrupt(dd);
>  	return 1;
> diff --git a/drivers/infiniband/hw/qib/qib_iba7322.c b/drivers/infiniband/hw/qib/qib_iba7322.c
> index f93906d8fc09..9db29916e35a 100644
> --- a/drivers/infiniband/hw/qib/qib_iba7322.c
> +++ b/drivers/infiniband/hw/qib/qib_iba7322.c
> @@ -3471,8 +3471,7 @@ static void qib_setup_7322_interrupt(struct qib_devdata *dd, int clearpend)
>  				    pci_irq_vector(dd->pcidev, msixnum),
>  				    ret);
>  			qib_7322_free_irq(dd);
> -			pci_alloc_irq_vectors(dd->pcidev, 1, 1,
> -					      PCI_IRQ_LEGACY);
> +			pci_alloc_irq_vectors(dd->pcidev, 1, 1, PCI_IRQ_INTX);
>  			goto try_intx;
>  		}
>  		dd->cspec->msix_entries[msixnum].arg = arg;
> @@ -5143,7 +5142,7 @@ static int qib_7322_intr_fallback(struct qib_devdata *dd)
>  	qib_devinfo(dd->pcidev,
>  		"MSIx interrupt not detected, trying INTx interrupts\n");
>  	qib_7322_free_irq(dd);
> -	if (pci_alloc_irq_vectors(dd->pcidev, 1, 1, PCI_IRQ_LEGACY) < 0)
> +	if (pci_alloc_irq_vectors(dd->pcidev, 1, 1, PCI_IRQ_INTX) < 0)
>  		qib_dev_err(dd, "Failed to enable INTx\n");
>  	qib_setup_7322_interrupt(dd, 0);
>  	return 1;
> diff --git a/drivers/infiniband/hw/qib/qib_pcie.c b/drivers/infiniband/hw/qib/qib_pcie.c
> index 47bf64ace05c..58c1d62d341b 100644
> --- a/drivers/infiniband/hw/qib/qib_pcie.c
> +++ b/drivers/infiniband/hw/qib/qib_pcie.c
> @@ -210,7 +210,7 @@ int qib_pcie_params(struct qib_devdata *dd, u32 minw, u32 *nent)
>  	}
>  
>  	if (dd->flags & QIB_HAS_INTX)
> -		flags |= PCI_IRQ_LEGACY;
> +		flags |= PCI_IRQ_INTX;
>  	maxvec = (nent && *nent) ? *nent : 1;
>  	nvec = pci_alloc_irq_vectors(dd->pcidev, 1, maxvec, flags);
>  	if (nvec < 0)

No problems here.

Acked-by: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>


