Return-Path: <linux-rdma+bounces-5028-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A54DE97D682
	for <lists+linux-rdma@lfdr.de>; Fri, 20 Sep 2024 15:56:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D9D9E1F21927
	for <lists+linux-rdma@lfdr.de>; Fri, 20 Sep 2024 13:56:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CD1917B402;
	Fri, 20 Sep 2024 13:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cornelisnetworks.com header.i=@cornelisnetworks.com header.b="f5kzQne9"
X-Original-To: linux-rdma@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11020079.outbound.protection.outlook.com [52.101.193.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39D81156F2B;
	Fri, 20 Sep 2024 13:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726840578; cv=fail; b=CH2wLSyHqyqBBtCN5YI2W7Ypq70PjtRPgJEEo/M9cy6H7KKLfFFsZcZ3AP7C3RZhsSdasmsPi9HnCQDuKFvhKEijbzrKbfsXbKganFhXhPobikU38S0MuOgw0qtZOsKnMzcK8DqdmkDvsxeMTLANI3AnT3F9pK/DXDp/a2UeZGk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726840578; c=relaxed/simple;
	bh=1jXkFggpOXV8s3D3ppPxUTc0TpExtXmYM/C3C0V3OIY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=EOFOlQ6l4DjyZ0+sfeGIM9tHGy65HrnCyq71iPG/0itIAMN4iX4TQpd9OPIuQ4a8D0d37suU3ss2D6flmSxFZBCoefbS/M5ktQt7vvRncz62UD0GXwQsEPrnKgtXtQoLy2Demh31m8ZBprornpPweHo0UB/Fp0dwreGMhLco+gc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cornelisnetworks.com; spf=pass smtp.mailfrom=cornelisnetworks.com; dkim=pass (2048-bit key) header.d=cornelisnetworks.com header.i=@cornelisnetworks.com header.b=f5kzQne9; arc=fail smtp.client-ip=52.101.193.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cornelisnetworks.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cornelisnetworks.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QNNpMnsn3oECTZBMuYC2COOHNypAAK+G8+8eJXaUAgsCnu1MOaKAsJeutvOOzkVPdSpkzmWkGi/spBRewlAcllJGiPyn13D6VXgmqPcmpfHPzAv/+3Z+HqJ+z8MW811qcOpJBCM3ga47vZU9mZerYpHpvIOUf0zPQUBY6AJScCwPtswQ7eIlmJYlht1BruerzNUiJJNSY/4iyqzgASNcZyQKNG22TlodPPUGLXe1LNG918PhfbtoWTUIM2HbxMvH0V+vqDzFlig/FYtX3ux5/oHA8oKFRgARdvrRYBGJ1pf8cIPxyRmaTv6bDcJRQ9mmUxYSuqqnvx4i/ISRMSrFQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CkKJZdSXWXO+kNRusshUCfH65XNgIWZnIrNZof8ofWA=;
 b=Hr4xejwnL/cyrLlvP8qneIRpYG3C4OeWUwmuf5fhuiadhl6925BBSRQQxvs/Vuaprfe08pIBk3GyP0d4xPPb/TeXnvDyOQ+NjX8q5hV4aKYJRBOjfXZimtdyyszx5eEc+1LMkFI2QuU7jq4wuHH/p4jmochHjO5EjnA7JgWbOQysUMGrPAkB8zE5FqfnMSRQUEXbYzVXpyzXMcdwAdewsUDbAiTgQ7v+tOVKk3Ss4xyQl502QfQ2WNhpiCyt0RWyakqm23GVPnqzbZ5Uvvcho4b3bkg0f6TUOrUHoIsmdUF2M5gfrv4Pqk9sXTsXHf8rTvwSawex0goEbdtF7Ohvqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornelisnetworks.com; dmarc=pass action=none
 header.from=cornelisnetworks.com; dkim=pass header.d=cornelisnetworks.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornelisnetworks.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CkKJZdSXWXO+kNRusshUCfH65XNgIWZnIrNZof8ofWA=;
 b=f5kzQne9cGM/HKEJqUFfBwWmpgdIRMfMiSaZRrEl+lfChy1JcVzidkuQZXAPVNIkm5IUa5oSzNxfDFSg/qVaJSP3RoO0sWnetqZdhRvKSbZaJuBQ+35aVTPdvJHJYuEt4+TPAw+IcCrssAu4puwTiGmCS+DXayYwDnZlPrpGyKAz8891TPaCBzdizM9joAhQzQVzgXX8KBjwaS2/SxS/wnOWCaB9hyMWEG2+302aWaKFjol4OHJ4oEMCdudRIRorfDfEAkNbGR/xUrVJ9iFiiDadgCFOYheKttTgFBKN2P+jWGXsp65ODij6rfQd7KW80bN9j7sMNAYEtrF4NR5XXw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cornelisnetworks.com;
Received: from PH7PR01MB8146.prod.exchangelabs.com (2603:10b6:510:2bd::18) by
 BL1PR01MB7722.prod.exchangelabs.com (2603:10b6:208:396::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7982.17; Fri, 20 Sep 2024 13:56:10 +0000
Received: from PH7PR01MB8146.prod.exchangelabs.com
 ([fe80::2972:642:93d1:e9d4]) by PH7PR01MB8146.prod.exchangelabs.com
 ([fe80::2972:642:93d1:e9d4%5]) with mapi id 15.20.7982.016; Fri, 20 Sep 2024
 13:56:09 +0000
Message-ID: <9c79dcce-39dc-498e-ad41-f50fe2752582@cornelisnetworks.com>
Date: Fri, 20 Sep 2024 08:56:07 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: How to create/use RPMSG-over-VIRTIO devices in Linux
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Mathieu Poirier <mathieu.poirier@linaro.org>,
 Bjorn Andersson <andersson@kernel.org>, linux-remoteproc@vger.kernel.org,
 OFED mailing list <linux-rdma@vger.kernel.org>,
 "Dalessandro, Dennis" <dennis.dalessandro@cornelisnetworks.com>
References: <70cf5f00-c4bf-483a-829e-c34362ba8a70@cornelisnetworks.com>
 <ZuBiLgxv6Axis3F/@p14s>
 <aff4e2e3-0cb9-4ca3-84f7-2ae1b62715e4@cornelisnetworks.com>
 <CANLsYkyuB=BsswRmbSbjDNMqz0iGHrviLMGfNJLx-HJ60JeEMA@mail.gmail.com>
 <591e01eb-a05b-43e6-a00a-8f6007e77930@cornelisnetworks.com>
 <ZuMEW9T2qSTIkqrp@p14s>
 <d8a4001c-d8c7-457a-a926-1d03e4f772fe@cornelisnetworks.com>
 <CANLsYkw-5i_4=UXwtG_SfR7rkjKEz3ieSOP2s4SOCozkWMct7w@mail.gmail.com>
 <20240915165800.GF869260@ziepe.ca>
 <0dda0411-22a3-4805-807b-0471f10c6468@cornelisnetworks.com>
 <Zu1ubAO8e8vNpC3A@ziepe.ca>
Content-Language: en-US
From: Doug Miller <doug.miller@cornelisnetworks.com>
In-Reply-To: <Zu1ubAO8e8vNpC3A@ziepe.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: CH0PR03CA0384.namprd03.prod.outlook.com
 (2603:10b6:610:119::26) To PH7PR01MB8146.prod.exchangelabs.com
 (2603:10b6:510:2bd::18)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR01MB8146:EE_|BL1PR01MB7722:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b24e7b2-053a-451f-4d2b-08dcd97bfb12
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?THo4WWQyUHRHanhaaUlDN2N2aXpiVkdUL0p6OEp1ZDZ2c1NyaCsrT1g0QUJ6?=
 =?utf-8?B?dDB6Q1hVNUw0eTFadmNKcEE4V1VoK0JHUk5CYlpLL1psYlZTbThJMFpOTEVU?=
 =?utf-8?B?Qkx4a3VXelJWRzU0bnc3Und3Ty96R0lTVHZUMnZDc1BuNW5haDJ5NWpZY0Vp?=
 =?utf-8?B?ZzlHZmZSTEl2aEtCNm1NVkVmOU1jcGVNYUtwTGdYMEVkWVkvZ0czbXJNeEEv?=
 =?utf-8?B?cjkwN1J4bkR4bDYzeHZFVGd4VytpVFhTNlFNSnFMdzc4K2pMbVBScGJod1cy?=
 =?utf-8?B?cWJxWnY0c3ozL0Vsd2Z1dFgxS1lNZzA5VE8yY3k5UmhIb0VhT3pYZE1tOUxn?=
 =?utf-8?B?K1A4cXg5V3dKTHNvNVF3Rk1jY3BBUFJRdkZnR3FXVW5MelZ2S24vTFlYeEtm?=
 =?utf-8?B?RS9xZ1JzUVkrYnFVMm9JUnZNYWJ6RHNwd1pwM1lCcWdGNXRtK0FGNHZxYXdJ?=
 =?utf-8?B?OExtVmtqZFcwWDhUSGw0YitPUnFFemZZVThPL0lnOVk2MGFUYlFoamtacHpH?=
 =?utf-8?B?UjBud2hNL1JsYkJKc0g4eFV4b01uMnRCSGtHRGdzNVlUWkR2bURTbllOZjRC?=
 =?utf-8?B?Q1BtZUdiVk1iVlAycklSTVhNdjlScEJaSjFhV0JJcnJZbmpZNzZvb1NMQlYv?=
 =?utf-8?B?K1F3MDQrMi9rYVJGSFI3NDNGeGd3NnQ4bHpWOStBN2lrQXRDQ1pyMTN4ZTI1?=
 =?utf-8?B?RUNXMy81eXRpZzdiSFN4Qk9NN2RtQkJMaFN3bUlleUhETEFCZmJGY1hPUW5T?=
 =?utf-8?B?RC9lbGdwSGhqOHhDLytnZkkwdUhXNE9MaVdxK3N6S2V0YkpDa2lRcERDRHZC?=
 =?utf-8?B?WmtXbE5RZ1VHSVlHVmdzZ2VhaGtQNjAxSVY3YjJuODBYdkU4bWNHY1pRTzJ0?=
 =?utf-8?B?bTFKVDhpUHJRSDRDTzQvRHV1M2kxaDNlaWROZWMwamw2N1hpZTNTa1NobnF1?=
 =?utf-8?B?TE4wbVJPRmhmdmVOQmxUMFVZMi9wcXZwdVhtZkNrejdhbkZ0YnJVWkJFTVh5?=
 =?utf-8?B?emxUVTBPNjR5cGVxVU1NSWZXRFFqRTIrb3hSNnByMGZ6VDkvOEhEQWRsVmd0?=
 =?utf-8?B?YzNYMmltUlg1TjB1K3dTRE5zU1Y5dnFWQ1dPbmhGeWZMZlRsTEQydmh4c1Iv?=
 =?utf-8?B?OTNTM251WlJTSE5vSUpuenZENVJVUHkxdVZTWE5uY1BNZFZETFpVUTdJdkVr?=
 =?utf-8?B?TUx0NWhkSU5Fa3lLQ21iOGJEQjd1aFpGdlArbjBaWWtYdyt4VXh2TEdzWXRz?=
 =?utf-8?B?UnNxZEVrcTluOXY0MFlVTXlMZnV2ejBMYjEwb2xBYkZ4UnY2VVQ0b3RwU1VX?=
 =?utf-8?B?MFRIZmhFY00zcG5WUXp2WmM2ditVejdUZzduSE9QUmx3ZjNGYmNENUxUeHp6?=
 =?utf-8?B?ZWdVeER6a3ZvV3gxb2o3TytBSEFqRWRwSzVsczFiaDFSMjZUOHlNSlg0SHpk?=
 =?utf-8?B?RXo5eUpOaStBNXlib1lqWm16TFlTRGRhOEVUSjlYNEFWcytUd1Z6cWM4bHJm?=
 =?utf-8?B?TFBFa0hiOENHVVc4akhENUduY1MyenBobWUzRFZ4dGJISm1OY0tVdjZaY3lT?=
 =?utf-8?B?NFdWeW1EUDRKWTJwbFdtUVExbzZaYm5OV2o0K1FNc1VJZjY2cDdSQkdwNUJG?=
 =?utf-8?B?ZjVpTmNHVlhOeldnQU1MMlVmZGlJMEZ5YU41MWtESXhKUnVZWi9RTFFLYXRM?=
 =?utf-8?B?ZUxWWEJvZ3FjUHpuZTM3Szd4YlFHcjVQby9kWHN4L3F0KzBKKzQwRWVTZ2JY?=
 =?utf-8?B?WFYzZlluT1RMbGhHUXdUaFNFWWxSWC8zMWNQY09qT0VpeXZnV1BtT3lKMnh1?=
 =?utf-8?B?UEt2eHE1SmhVUXdhc21sdz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR01MB8146.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?alFDVFFja0JuV0k2ZGg4R1c1R25kbHpPTW5HSWxtSGJsWmcwTXQ2a2lmOHEx?=
 =?utf-8?B?L1ZqalpJaEZsYkwzTkgxaGVlRFdjbFQxNUQ3QUQxcW1IREl5TkI1TjJxS093?=
 =?utf-8?B?UUR4VVBsSGI3V0JXSk9aNnl4NDZMNFJ6c3JEZTNvWFA1a0RlTm1iVUM5Zmls?=
 =?utf-8?B?WWx0cVFTOHNKKzNTYUd4bG1Rc2hTV3VvdDRXVjVsdlhmbHR0YTBSSnlkRHBm?=
 =?utf-8?B?KzYvdFlSM3p3V1BqSFEzaFA3UGE5em5PcWtlZlExSDR3S1VNNVNkTE54UmZl?=
 =?utf-8?B?Ny81eGFWWERyZitQRWwyeS92MjJRZWVhcGpUVFVIM0ovdldSUHUwbXVMUDZV?=
 =?utf-8?B?RzRtckVCNEsxOTB5eEVtNDM1Wjlsd25EakZmcHBQLy8ycXZZbjhGQmo1Y1Vo?=
 =?utf-8?B?OTJJdU5HTmI2dlFyMUl1WU5OWWd2aGFaamVKZlkvWmhlTmpoMnVwck8yTm9X?=
 =?utf-8?B?b0JhNDlMdityaUNzZ1dUQWtoL1BSQk9acFJvdkIzMlh4SGkrcXp4ckRrUWgz?=
 =?utf-8?B?ZjFiU2dlcDFzdXhXWm5EWnVua1FoRExSR013eU1iKzdRenF0YnRLcVZDTFJJ?=
 =?utf-8?B?ZHB1ODc2cDlVQUR6eXBwOHdoWTNaSHRaQ0lrV0pIOEVXVUlYMzhVMnFYQnRJ?=
 =?utf-8?B?bXd6MjFPekJJKzErdUZncVVWT2JxZGVad2phRDRUMDhDYmUzdkZ4bVE1a2pu?=
 =?utf-8?B?Tk9Bc3NreThpcjhVOTVUUzBPakd4TVV0ZVZBWGdxUVgvMzFJMGY0ODZHT1VB?=
 =?utf-8?B?Q1UrWHhYR2JFRzU2dy9sUFlQakNqbDRnWFRoV3cwUkd1UXJMTGZ5Q3ZnZ3Yx?=
 =?utf-8?B?RTRYSnZPMzVFTkx6bDlObCtkNithOWExRnl5ZDNQVFgxbm5rTzk5enlDcGVk?=
 =?utf-8?B?L09nTGRFekk2cFhPQ25QYnkwVkRsMlFWbXJhMWtHM2VhZW1NbkNyNDZKY2pF?=
 =?utf-8?B?YTBrMjhqVjJJMkcrMTlid2ZRMXZicS9jM2s4ZXBUNklGcFg5YXBZRWpyOVps?=
 =?utf-8?B?U0FKOFRaWUYvMCtuSTNCakwrRU5SQmlPeEVRYm5wNVpoMXBTWGtBWWRyMW0x?=
 =?utf-8?B?ZDBXcExjSlZTclhyc2pEQnFuZFBSUzE0ZmQzYmdZbndpcURvWW53VGFYUVRi?=
 =?utf-8?B?aUhuRWlTSm9lOEluQTVUQm9ZT2N3b3NlU1ZGb2d6TlFpbWJiNXJ3R1dqTURL?=
 =?utf-8?B?OHoxMWpYQWJRR20ydlozYTU5QkQxbzZDQis4Kzc3MkFFZDZRM1NLOSt4Q1h2?=
 =?utf-8?B?U2RZVzFsczhiOFZDV1ExaUZock9MbXVVaWozRUxhdWxoY1Y4Wld1NjIzbGJC?=
 =?utf-8?B?QVo4Y285czBKZnYxVXh0a3BYZllBZzgvNWc0UDlYaURPWVZ3cVRrVkpaNHM0?=
 =?utf-8?B?dFE5azNZcVZzRTg4VFJ2VzE0cTltWW5JWGlJQU1xa09XRUVJOWZnbUhQQ0Ix?=
 =?utf-8?B?dkV2bit6bU9iY0tjdm9MS2pLaDMxVnl4eHlGWi9MT1NPRkdGdkdjQi9Hdzl4?=
 =?utf-8?B?eVNNdDVrWnFYOWEyYlBTaGdGak1oM016eE5BVW9tTm1VMFNpUUlGVGI0WG5V?=
 =?utf-8?B?Q1hWR21rSkZlNUxjUHZaR0FPYmthMFZRQW42bldxQksxd2llTlJBK1JiWW5T?=
 =?utf-8?B?MkMxNEoxWjlWdy9hcW1EOERNNW1zNWFRMUMwdTJFTk9sU3lDeWZOYXc5SCtl?=
 =?utf-8?B?TXN0NU5zVG9nK0VmRTJkWGFlMzhrQWdvNXhaVzc4RXJoMVJEbTJPcElneTUx?=
 =?utf-8?B?Nkp6Q2cxNXFnWlArcnpreW9ad1dVWUplN2ZGVURCd3AreXZQSGI4am9YMndT?=
 =?utf-8?B?Y2dDQWZ1ME9HSS9kZlpyWS9GbmdIQjVHNGJJQmtPZnJQVHR6RmZzV3FVcXNL?=
 =?utf-8?B?UjRLWXJPU3FPdDN6amNPSEFpY2QxWndtZFhRSFR0NkFtVE5lUHFpKzI4eGp2?=
 =?utf-8?B?TFNYbEZSeDJSUWwvcjRuZHE5cGFMQVV5cWRqVVpxMXNkdzEyNjJ2ZUNUYUtp?=
 =?utf-8?B?bCtuT2RvSnNUUHEvVDZFRmlCd0crdGl0QmI4SnNMNlhEUndmWWNUUjVmK2VI?=
 =?utf-8?B?YWN1MVp1YnQrZFo1ZVJIVjlydmtxUG9VcGg0QXE0RU5MeEtzd05PWHBSdkxk?=
 =?utf-8?B?R1VhVXl3alZQbC90OGFCSGFyRmp3NDJkcm1WZjIyNzdRcWxLSk5ndkwzTkZx?=
 =?utf-8?Q?Z03/++SNOnbGS+mWYWJibNI=3D?=
X-OriginatorOrg: cornelisnetworks.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b24e7b2-053a-451f-4d2b-08dcd97bfb12
X-MS-Exchange-CrossTenant-AuthSource: PH7PR01MB8146.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2024 13:56:09.8575
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Lszycg2L6XtyFaVpIJmW3k0DOv4Zfkg2sAlaOBJa+muAkA76y2Sm9BWr5TbDscSs3Zoqra1aNrIUhCnikU3uU06Qy8yjPrPnDHx4KecOtGa6i3lEARioRfcqRAEXzVBH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR01MB7722

On 9/20/2024 7:45 AM, Jason Gunthorpe wrote:
> On Mon, Sep 16, 2024 at 08:38:42AM -0500, Doug Miller wrote:
>> On 9/15/2024 11:58 AM, Jason Gunthorpe wrote:
>>> On Fri, Sep 13, 2024 at 08:39:26AM -0600, Mathieu Poirier wrote:
>>>> KVM has nothing to do with this.  The life of a virtio device starts
>>>> in the VMM (Virtual Machine Manager) where a backend device is created
>>>> and a virtio MMIO entry for that device is added to the device tree
>>>> that is fed to the VM kernel.  When the VM kernel boots the virtio
>>>> MMIO entry in the DT is parsed as part of the normal device discovery
>>>> process and a virtio-device is instantiated, added to the virtio-bus
>>>> and a driver is probed.
>>>>
>>>> I suggest you start looking at that process using the kvmtool and a
>>>> simple virtio device such as virtio-rng.
>>> I would repeat again, I think trying to create a companion virtio
>>> device to go along with a real vPCI device and then logically
>>> associating both of them with a single driver is going to cause so
>>> much pain you should not do it.
>>>
>>> Find a way to send your RPCs through your own vPCI device.
>> When you say "your own vPCI device", are you referring to the virtual
>> functions that are created by the adapter? Those are defined by the
>> hardware specification and we don't have the ability to extend them.
> Yes you do the VMM can extend them. You need some qemu code or a
> vfio-cornelis or something like that.
We can't require that SR-IOV customers use one specific VMM (qemu). If
you're talking about modifying the kernel virtio_pci facility, that may
be a worthwhile effort long term but I suspect it will take a longer
time to get adopted. Using an existing kernel facility as-is would be
the most practical solution.
>
>> What we're investigating is using RPMSG-over-VIRTIO, not using virtio
>> devices directly.
> I understand, and that will be very painful.
Can you expand on what you mean by "painful"? Are you speaking from
experience with the rpmsg interfaces (can you point to problem areas)?
Or is this based on the fact that, as of yet, no one has come forward to
explain exactly how to do this?
>
> Jason


External recipient

