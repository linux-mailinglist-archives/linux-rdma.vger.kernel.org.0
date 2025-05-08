Return-Path: <linux-rdma+bounces-10165-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 919C2AAFCCE
	for <lists+linux-rdma@lfdr.de>; Thu,  8 May 2025 16:23:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2FC723BDD43
	for <lists+linux-rdma@lfdr.de>; Thu,  8 May 2025 14:23:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4753253953;
	Thu,  8 May 2025 14:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="CwJw7Oe9"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4482201100
	for <linux-rdma@vger.kernel.org>; Thu,  8 May 2025 14:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746714228; cv=fail; b=s1wMZckBF4Bfn7A5pwuVaia6ESvlqgDOQHUbURXdVTVYyDGaBZKIuvF+9LH7Dbj/9NJjSaGpbMPt+Q178DAeRk/j/0sahZ3sHrMXHJQwU6ecZluSDUUphadxjUhxOJJPrqY84wqRQvO7LBkAKj3nqju6iWaeWJquwWr0QEv9ALc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746714228; c=relaxed/simple;
	bh=cPFV/Ehhs/4Xmqh6eVl0zABTcBuYQ5II5HS9RpB6RYc=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=NYhzgV1YASfQt1KvozAMyDCty+xqDEWK+CsCquF1Md2AooBuCDIeMq/i3unsgNkjh+5AjxqgKtoouoM/N/uYN/7X2SGbxQWKhsAWYkYNh7s2bI+PYRhiQkYU332y/Ekl4PTYDaus5Bdmj/G0DHxUT2CUUtq9+B+X1Edm7KljJ2w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zurich.ibm.com; spf=pass smtp.mailfrom=zurich.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=CwJw7Oe9; arc=fail smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zurich.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zurich.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 548A47VO025980;
	Thu, 8 May 2025 14:23:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=cPFV/E
	hhs/4Xmqh6eVl0zABTcBuYQ5II5HS9RpB6RYc=; b=CwJw7Oe9eR5warO+o+2Gt0
	fDyXumukdj6qIxdlmgVOCOBgBPCK9HVXLC0yr0L7dsOjdwc8/92iIeNCRiehHBjV
	D17IuHlo275D8APU6GiIC7ZIAIe65NaHv8tMgxy9X2TEbuAudhfHHUdkhKo2T+Td
	ZbRb5OrRf5IWqHEJqg9syfVL5P/3ieINT9ZRkwKxEH0B4TSZKt9LsfWXO8zxOSA+
	6JpC+KUGHfzJLETySoxSrZ7CZDgJ5SMZx6uLLVSaWP0U8jjAaCihpu7h7Q23qR3N
	cJED+mOZNp2zqH6jRrxe2Jk27qU4Yu0qbOQuw8vCAvaMfKPOs7jmZAv6jauDYOTw
	==
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2042.outbound.protection.outlook.com [104.47.55.42])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46gthk97yy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 08 May 2025 14:23:41 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jJkOULFCYNxR5O+2wYUXuQG/LlWsLn5EzGQaVCMuHiGS+EJntVC9CdZgwE9fSV1VN6qDo5XDp7ZOIqAuGJ5B1Zx0GtrFxEWGcki9mB6IJdj7NTj+FJ8SwX6fzxJImMbag91zf135gncw21vPdo/GTRY/6P6VXkj4gNDq26JseKc2zOnK76xo6jXo82XDeWAakCyW4DMwIzC0EVGrCmFWTsFkORYxUaQMRPgfyMZkM4qwyiJg64Sd7w2TMZbchIXG86F6GZvYkyGAJ00rpTIA82cLra517gYxEt7KBaM1+HU+yjKQzvf7Td4PyRe/pR+nHwP/sSzIocoS35gpXZ8Scw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cPFV/Ehhs/4Xmqh6eVl0zABTcBuYQ5II5HS9RpB6RYc=;
 b=XMNuVwFXNk/yZnEI+sbW8dsNKZzmW/WFRJL18VbY7EVvqj1FEsq/L9nLioUWpd8n9eu39q8oDCQasyZSMPS2RbrE7xGoIbk/LTdYmzYxE8RIwMO8mVKUX2TCvEEHBFIG7VxVcs38boCwwIUFQ/+PN2ldkfoJ5QmOMcmS7JgOqYxqOK+th54pe12swVKUk8E31IIxGvA12M78wIyM7xLYxvPW6s5egjLld5RQ3tHGPg9Aoib5ez9Y/oQRZRw0pSTO2OhGOPxv3RzY6qh/KXeUJOu2PRHNbIznXSzURqZEUIPdp3Y9HX/TgTULEx2EnnwDG4StTAe90frl1eP/14Q5/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=zurich.ibm.com; dmarc=pass action=none
 header.from=zurich.ibm.com; dkim=pass header.d=zurich.ibm.com; arc=none
Received: from SA0SPRMB0005.namprd15.prod.outlook.com (2603:10b6:806:152::20)
 by PH0PR15MB4910.namprd15.prod.outlook.com (2603:10b6:510:c5::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.27; Thu, 8 May
 2025 14:23:39 +0000
Received: from SA0SPRMB0005.namprd15.prod.outlook.com
 ([fe80::2572:f04:ba6b:3dd]) by SA0SPRMB0005.namprd15.prod.outlook.com
 ([fe80::2572:f04:ba6b:3dd%5]) with mapi id 15.20.8699.022; Thu, 8 May 2025
 14:23:39 +0000
From: Bernard Metzler <BMT@zurich.ibm.com>
To: Jason Gunthorpe <jgg@ziepe.ca>,
        Shinichiro Kawasaki
	<shinichiro.kawasaki@wdc.com>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Daniel Wagner
	<wagi@kernel.org>
Thread-Topic: [EXTERNAL] Re: [bug report] blktests nvme/061 hang with rdma
 transport and siw driver
Thread-Index: AQHbrfdhJhGSraouF0ezotWmIGdrJbOkzJXwgADapACAIstSAIAAWiOAgAAg4GA=
Date: Thu, 8 May 2025 14:23:39 +0000
Message-ID:
 <SA0SPRMB000501945CA2663576E32B85998BA@SA0SPRMB0005.namprd15.prod.outlook.com>
References: <r5676e754sv35aq7cdsqrlnvyhiq5zktteaurl7vmfih35efko@z6lay7uypy3c>
 <BN8PR15MB251354A3F4F39E0360B9B41399B22@BN8PR15MB2513.namprd15.prod.outlook.com>
 <lembalemdaoaqocvyd6n3rtdocv45734d22kmaleliwjoqpnpi@hrkfn3bl6hsv>
 <d4xfwos54mccrwgw76t6q5nhwe2n3bxbt46cmyuhjcpcsub2hy@7d3zsewjkycv>
 <20250508122539.GA6371@ziepe.ca>
In-Reply-To: <20250508122539.GA6371@ziepe.ca>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA0SPRMB0005:EE_|PH0PR15MB4910:EE_
x-ms-office365-filtering-correlation-id: c0654364-981e-4cd2-2c45-08dd8e3bed51
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|10070799003|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?emY1MEFmREg5UXFZbk5yTmU0bkYrazk0RkNiUlMveWpnbVZoYlB5dndXTStm?=
 =?utf-8?B?WVZhQlBjOUZjSUJ2dHpOTGVyamJjaEN1ZTcxLytFVmVtSnpOM2dVQ0JhRyt1?=
 =?utf-8?B?N1paaVZ5Um9QWnRTZFVzU3Z6TDZLNUVFdE05UFhKdFVTamw2cmlINGdqZEFB?=
 =?utf-8?B?T3o5emRUS3lkaHc0Y2FNazc2WFR0ZVlud3UxNlNTdWFJQnh6cXB3SUlqbXVr?=
 =?utf-8?B?azBheHA1MEhwZnRVM1F1b1RxWFlzZWFqTVJzT2Z2dGtSOEJzNUkyNHNCRndO?=
 =?utf-8?B?SURRL2dJRHRnMnA1S04yWFR3VDJqR3lmQk5rOFF2OHRtWW1zODNOTGpIU1lS?=
 =?utf-8?B?L1MyTG80RGVEQ0FQR25xMThWVDc1RlNqTnpNNHNEK3ZnSGJFbzVjbU53VnVV?=
 =?utf-8?B?MjdMTW5SMUgybXZObVJlRzdjNERMc25yUisraVZqd2pOaHVIbDBjajhPdjF6?=
 =?utf-8?B?aEt3SUx2TG91M1JoTDlyWnZaNjhWQzFab2UvZWFHYW5BTEE3VXpTTDRvZGE0?=
 =?utf-8?B?dXorYkpoMTRvTnBOWkRlaEc5L1p3bnIrWW1veEZzRDl4aHB6eDRSaDIxZ3RT?=
 =?utf-8?B?TkFibTRMOFVMMDhvc29EWGlpZ0MvZWROS2cwMExnemNoZFZoUzRpOWlUL1Er?=
 =?utf-8?B?ZnJvVTZ6Q1YxK29rdFZhMmdoQ2tRbXZWd1FLbjZCLzRzRmJLK2d3dkR2TGRH?=
 =?utf-8?B?QklFSi9mSVBqV1RHNVBOOWJBaFlOQzBrc2MxZEkxUGljZlhLOWJlcTY0cG9X?=
 =?utf-8?B?V3pEMmxZenE2dVlGN0hFQzJld3M0WXJ0VUhFMERYYndxU1VlaWlPMEgzNksx?=
 =?utf-8?B?N0RmYVB6a3hHbzNINy96MllPU2xGNkN2NlEwNGMxRGFHSHRpNjhmVEdkbG52?=
 =?utf-8?B?dnY3ZE9oalk2QTJYcHVwclpiQUpTa1VLMWFxRGFjdGtJeTArbytMeEZXS2M3?=
 =?utf-8?B?ZERHSThOUEIxT3d6TEI0ZGJEQlQ5VEh2MkpMUUN0VUQ0WHU0L3NIbTVlTEZZ?=
 =?utf-8?B?S29YWTVYNWtBM21RTGRUMWlLUjR2NUIrNlNHSHdkeE4vd2RTd3lpSmJScDVu?=
 =?utf-8?B?UWt0NDZqZ0RxZVBTQjBCb0E1cFlzTTljYU1TWmFLSDZZVG9qQzVtd0VSNG4x?=
 =?utf-8?B?eXpOT3hFcUpYRHE1UjFnRVZWSTR2c3VnOFBOOWc3UkJRUkNWWWRJNDcyMHFY?=
 =?utf-8?B?SUg4ZXVhc0Nha3lESlE2OG9qNU1RN2ZQSGxsT0ZWNnE0UlZpallUWnpoRVhP?=
 =?utf-8?B?b2xEYmZhMDZZYUdjM0MzSDBoLzBoUlNtTXpQUnM1R0xWcUV1ellPL0g3NHY3?=
 =?utf-8?B?M1Y3RkZ1VGIrZnVqTUF4d3pvY2NMYWpVUklaTHFKTS85UTdKOTFOZFlONVpE?=
 =?utf-8?B?a042akdDaG9yOXREQlA4KzZuWndOTmJrKzZhNGs1ZGdoVERGOFVuV2p6REU5?=
 =?utf-8?B?UmFCRkZqTjN4UjhFV3lWU1o0d2N3UTJZdS9nMzdEU1kwbkRTUHlRSzNwZGtN?=
 =?utf-8?B?V1R6elBxaTE2TjZ6VEsxZC9CNFdkWVpIaTBVNGJVcUpHRmxYV1BiZmgrRUlj?=
 =?utf-8?B?TTBManorV0pIODVWVzlQOXdIakdUTXRvT0QrZHFVNUJEamd1YWJrQlpHT0kx?=
 =?utf-8?B?NkJyMnVSRkxUeXdqWjhIKzA0VEk2amFobFhXUGxtOWdiZ3ByWEVTb0YzeUZ5?=
 =?utf-8?B?aWJIeU1adGhSaHZpZ2ticFdVZ0MrTEtrTlJkWmFQRDEvSERab0p6V3NtS0xY?=
 =?utf-8?B?b09MYXZKdVpqS0IvdnpXRUYzQUNrY0dJNWFFbExzcTZwL1lSSHlLRnhmdWN4?=
 =?utf-8?B?L0lYVHRKS2dOU0xRYkpEWDJqL3dZVTFCNXVyQ0JLR0ZzSC95OUR1ejRtamE1?=
 =?utf-8?B?YnI2VTgxYVd3c0VWOXNMNmZiTExYYkFwTEd5YURRM1hYMGFPSGsxN2RGRVNo?=
 =?utf-8?B?cHlIZklBZkhCNW1iNzBSZ0g2Wjc1MU1YNS82U1g2aFlJSGtpNEhWYVZNQ3p3?=
 =?utf-8?B?YmNpY3BqTURBPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0SPRMB0005.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?MGVpSFk5RnhuUmNoM0lpdlU1NFVYRUVFd0pQWmJpcHJEbC81VGZQQWtBaTlw?=
 =?utf-8?B?NWhxbVhNVG85eWp0UDIvYU1UMXFJQzM3N2FwYjgvRWVjVzErRm1FQUZXNko2?=
 =?utf-8?B?Snd2VitTQm5jN0s0NGV5cXc4S3BSMVluUkw4WTMvSHlRdU9IVmdYWlFLRWtC?=
 =?utf-8?B?QjU2cW5ZSVJ4Y012cXZGcHFIcDU3Vk94TXBXb25zRnJiS1lZNTFxQXlYaytU?=
 =?utf-8?B?YUszU011L1E3UTNqQ24zNFAzcnRtTHB4RVdIOXI3ZnZIdVhKOWw0LzFvb3RF?=
 =?utf-8?B?eWVJZDd5aHg3djdxaXJ1bTJiNWVMU2p4WFFSaHhITWpoUFVlSUswcUc3OHZQ?=
 =?utf-8?B?TTNUeWhMSmpKTlJMNVo1L3I0QWV4dTNPN243d2pXSG1veEdINGpYbURrc1ZV?=
 =?utf-8?B?V1NSb2lPeWNzQ1BaNVNYbnBDSlhLRy9PeUJUZitabDI4cDQrV2V1MkFocWY1?=
 =?utf-8?B?Sm5BQzVJdS9DWHFPLzBZUldaTkxIa2hETHZlYWhtcWV0L2VmWExrRHp6NVdH?=
 =?utf-8?B?ZDl0NmI5d2xMUHlJcExOeTBKN0ppSnN5OGlHUW9Uc1lIdk8zWWNsbCtSdUpp?=
 =?utf-8?B?b3FIckdXNzQyOWNZdHdMRnoxOUUwMmdxSFJnRzROREgwd3Nib3FudkR3Nzlr?=
 =?utf-8?B?TytyczhUUnJNY3N1WTN5WGk1ejRQcWxjWTJEMkdjR21DSisveDFycjJ4KzlF?=
 =?utf-8?B?UTJxYzVwamJiOThpZ3B0VlVZbjJZcnVuNGc4VHoyeCtYemIxSWY1RXZGU1da?=
 =?utf-8?B?Y1UvRXdzcVRUU0dNNzlWTUpIN1FMQlZITmUyRkVkaWgxNXlja3BuT3FhY0NM?=
 =?utf-8?B?UkJ1U0lHano5eGhjRjN2a3ZlWmttdUtGZHk3R2pQVE9wV3JWRUJhVCtxSFZZ?=
 =?utf-8?B?N2ZVeUhpNTdydXdTVTlXTVFCeTFacmtVVkZHcmJwdjdoc2ZMcGxQR3lMTkVF?=
 =?utf-8?B?NWJtNGNvZ09RQ05raVUydjRJdUNyeERIb2cyQVcreEJYd3cyazhsY3NGWUNY?=
 =?utf-8?B?ZzhPWmZOaVR1dHdhbUtOT3dJWTUvR0pia0JuWXNKY2thLzVMeTBObVR4RFh0?=
 =?utf-8?B?dTNvelF4YlBIMmJ0eVdwZjV1MlFCclcvNDBDQ2tnWkNzVDVuOUdWbC9lQnds?=
 =?utf-8?B?WGUwTEQ2bFlhdkpBaklMVGhzb0szbzB0VE1qMnJCcS9jYkFRUERYUUhoZ1hJ?=
 =?utf-8?B?SUIzckd2ZTlRb1RnU25XaWFrZ0JqbUw0VkxQWTFXbGxsV0xDYUU3K0MzK25s?=
 =?utf-8?B?Z1VkQm5EQm5DZ1hUdFI4YVFHeVRJWDI3alFSSkVoRW1CcC9GK2E5bEhTV3Jl?=
 =?utf-8?B?aERPaWpUWHRkOWtuUjczTHBBWHhzUE9IdmtmYlFWeUZYTGlqVjZQVERpTSt2?=
 =?utf-8?B?bXJzVytXUitGTkxDWEV2RWVHTWZmb3VLdkl1NUlzZ1pGajRpL2ZvTGJLdkx3?=
 =?utf-8?B?YWVLYmwzRHdoWXkyQnpVR3RFc3VYbm9ZajBrdEUzL2g5VGlvSjg3bStudElp?=
 =?utf-8?B?YWNUdklNU1l5dlZBeVBZRTM0VEJEUEYxTVlFc2tiOFQ5SnFpSEF5bGZIMktK?=
 =?utf-8?B?WU5UTDU3VjFpRVh6TUZzYWMxWVNIQ3RTMm82ODNXdUpHMEVHaTdkMFhDRmZq?=
 =?utf-8?B?b0lMRE1jTU1kR2UzbWloaWFVa0NCVmcwTUU3dG11ZE1oVFMvdXJVNGNudWtp?=
 =?utf-8?B?MGhFMDltbkVCSk5QYjNQZXBJYjY2bENQMysxRjVhUTFyU0F4d0grVkltQXhB?=
 =?utf-8?B?YU5ha2NFVmU2TmluVVlTb2xJcFlpRDJSdzFkMUMwdlpYeloxRzBNNC9BOHQv?=
 =?utf-8?B?b2tVWHdrVDc1ZklGUUZGOWJaTCt6SXVpOFhKL3dxOHA4MTRjbEN2QnFiQ1hN?=
 =?utf-8?B?K1huY3lRbTdYZTJxc1drZktkUkQvajcwMDAwdHR0OVRZYUk3Mkt1eXZnU084?=
 =?utf-8?B?aU5rVUd4b0tMeHdmOWZtOXNiREJHR1ErWEdSZ0NIRHNPNVBsRG1DdDNhSEZY?=
 =?utf-8?B?a1FEVnB3VTJxOTdoR2hxRkN2UFE2WjlZRDVhTldOU2JJdWZ3R3Rod0RtdHgr?=
 =?utf-8?B?RUh6YTV5TGkyVDlFSlBrdHVlTGlWNWlWbFh0RjNOY0FobXZqc2d3VGR4dEw1?=
 =?utf-8?B?QWMwTmlIMENuU2J4ZU8yRDZKUXBhci94UUp4V2NrcVZ0dnJZY0FYTDgzdjd2?=
 =?utf-8?Q?4vyGUNQq36KT+rmGLggv2hE=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Zurich.ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA0SPRMB0005.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0654364-981e-4cd2-2c45-08dd8e3bed51
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 May 2025 14:23:39.2085
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8qS67A1dkkwM0A6KqnoQf4fzK10uq5gi7D3BJXeBB57aeCM/eZSCc32XNskrpnkVEnyIl/A3sAGNjVmLumDquQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR15MB4910
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA4MDEyMCBTYWx0ZWRfX0DJD8Y2wnUaL 7SklYDFlPEajkthtPcDjlRi/B2FJjpRIZ+HSSdRhZHPL0Zrx5dhvW3ia5/rsEURbDo7GY/ExFP+ aEEboWtzKknqdZZmEMhpEli4CTXnzgupUYkZpdMRIuL2yCj3QDrLOgCkgaJ1fmqeGBI4tX0Nlrg
 qIGpeRuR46IPZnrnU/zDxf/Ew+J859dWC5wcd+WQe2VIUVMsLgvavEs11MOrodQ8HvMy1c5yl7s ujYhIuFPSJfGVAP+VV5KDSHoelwQGt34cw1e0A3ZefTJnIxlBlZizrh3r0oXZM/78BFuJq2dg17 zBSnFNOJqZ1qSvwfhbX8gnweGWnPx370hBxkVaJXKiyqEnrnjyjxQHlCi+5OQm9e3VzI1mNDlI8
 7A4KhpEui0o8oiSkSOyGdoRV34SVQDVrjxbsWDIobrhCKLW579BMxQraUC0CqhtYBkPnNsCP
X-Proofpoint-ORIG-GUID: bAa8ha3bTU3rGjl8qLvQ2FAycCX04BPd
X-Authority-Analysis: v=2.4 cv=PvCTbxM3 c=1 sm=1 tr=0 ts=681cbe6e cx=c_pps a=SXeWyiAXBtEG6vW+ku2Kqw==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=sf_c4huTtXOTCMgN:21 a=xqWC_Br6kY4A:10
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=9jRdOu3wAAAA:8 a=JF9118EUAAAA:8 a=VnNF1IyMAAAA:8 a=JfrnYn6hAAAA:8 a=VwQbUJbxAAAA:8 a=DYow5LizJLTvbkSjNJMA:9 a=QEXdDO2ut3YA:10 a=ZE6KLimJVUuLrTuGpvhn:22 a=xVlTc564ipvMDusKsbsT:22 a=1CNFftbPRP8L7MoqJWF3:22
 a=t8gNky6DTScCJD9b48VS:22
X-Proofpoint-GUID: bAa8ha3bTU3rGjl8qLvQ2FAycCX04BPd
Subject: RE: [bug report] blktests nvme/061 hang with rdma transport and siw driver
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-08_05,2025-05-07_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 phishscore=0 spamscore=0 clxscore=1015 mlxlogscore=990 bulkscore=0
 impostorscore=0 suspectscore=0 mlxscore=0 malwarescore=0 adultscore=0
 priorityscore=1501 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2505080120

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogSmFzb24gR3VudGhvcnBl
IDxqZ2dAemllcGUuY2E+DQo+IFNlbnQ6IFRodXJzZGF5LCBNYXkgOCwgMjAyNSAyOjI2IFBNDQo+
IFRvOiBTaGluaWNoaXJvIEthd2FzYWtpIDxzaGluaWNoaXJvLmthd2FzYWtpQHdkYy5jb20+DQo+
IENjOiBCZXJuYXJkIE1ldHpsZXIgPEJNVEB6dXJpY2guaWJtLmNvbT47IGxpbnV4LW52bWVAbGlz
dHMuaW5mcmFkZWFkLm9yZzsNCj4gbGludXgtcmRtYUB2Z2VyLmtlcm5lbC5vcmc7IERhbmllbCBX
YWduZXIgPHdhZ2lAa2VybmVsLm9yZz4NCj4gU3ViamVjdDogW0VYVEVSTkFMXSBSZTogW2J1ZyBy
ZXBvcnRdIGJsa3Rlc3RzIG52bWUvMDYxIGhhbmcgd2l0aCByZG1hDQo+IHRyYW5zcG9ydCBhbmQg
c2l3IGRyaXZlcg0KPiANCj4gT24gVGh1LCBNYXkgMDgsIDIwMjUgYXQgMDc6MDM6MDNBTSArMDAw
MCwgU2hpbmljaGlybyBLYXdhc2FraSB3cm90ZToNCj4gPiBPbmUgbGVmdCBxdWVzdGlvbiBpcyB3
aHkgdGhlIGZhaWx1cmUgd2FzIG5vdCBvYnNlcnZlZCB3aXRoIHJ4ZSBkcml2ZXIsDQo+IGJ1dCB3
aXRoDQo+ID4gc2l3IGRyaXZlci4gTXkgbWVyZSBndWVzcyBpcyB0aGF0IGlzIGJlY2F1c2Ugc2l3
IGRyaXZlciBjYWxscyBpZC0NCj4gPmFkZF9yZWYoKSBhbmQNCj4gPiBjbV9pZC0+cmVtX3JlZigp
Lg0KPiANCj4gT25seSBzaXcgdXNlcyB0aGUgY29kZSBpbiBpd2NtLmMsIHJ4ZSBkb2VzIG5vdC4N
Cj4gDQo+IEJlcm5hcmQ/IFdoYXQgZG8geW91IHRoaW5rIGFib3V0IHRoaXMgYW5hbHlzaXM/IEkn
dmUgbmV2ZXIgcmVhbGx5DQo+IGxvb2tlZCBpbnNpZGUgaXdjbS5jLi4NCj4gDQoNCmxndG0hDQoN
ClRoYW5rcywNCkJlcm5hcmQuDQoNCj4gVGhhbmtzLA0KPiBKYXNvbg0KDQo=

