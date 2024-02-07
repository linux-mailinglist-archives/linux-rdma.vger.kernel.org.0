Return-Path: <linux-rdma+bounces-958-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FC7684CFB9
	for <lists+linux-rdma@lfdr.de>; Wed,  7 Feb 2024 18:24:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B79071F28C52
	for <lists+linux-rdma@lfdr.de>; Wed,  7 Feb 2024 17:24:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5D6D81ACE;
	Wed,  7 Feb 2024 17:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="C3g8qNx+";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="YLo2Ab6f"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AD9782C76;
	Wed,  7 Feb 2024 17:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707326650; cv=fail; b=VEe7TZh3qwSxhgBFops/ffQQjPLwrZzDmOEqNTzPeJIhAlvG86DaK0WyGXUGTnSbsD5XAfI7gDAB88wSk28mgDDen77KZLPrYOr3JMFd9EIEwGxGFUddM9Z1pCRbXdXSUFxqTLXxQVTB7vmY9b5+qUDWF61USwWE2jr+DEPBhiY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707326650; c=relaxed/simple;
	bh=JpMAeesah8PNMeeUNULCMjZ346Ms7GKc502TBfk+fbw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Ckeg2Y6XudKaHb4bQXRIVOnReL+6q/PFBEKoAIUw+/XfHAtVE9N2aWukXcAl+quWLS4Ibg7ijBgJ/mXaWEhiEtGlFGjrQYPos4pno0/wwiMRe52DaW7gv/8Y9+HAuCar/HU5OnESu1OArpRmBYWFQs2JP5ubwcPMiUg5MrgWEwY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=C3g8qNx+; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=YLo2Ab6f; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 417FxTG3009137;
	Wed, 7 Feb 2024 17:23:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=JpMAeesah8PNMeeUNULCMjZ346Ms7GKc502TBfk+fbw=;
 b=C3g8qNx+BMnWrP/2ePfF/kxb7SYnOWRnKIWJhpxLW+YFRlvf+uYVSJLs8AIm85SO7psK
 9V6GNbxuDGgz7fa98Gx1bk/jAZ97Yra7vI8ZzZ//lOAfKcU3S1IrdZ0k3pKO1yi2cKKn
 1ny90NpuUlRVnB7mPGwzSe4BQvr7rmAklYh54aCENQba5PCW59XxZ5Ub0c0jw0/5ofF3
 Q6t+EpUaQxVgVKLBHnKoEH+xCi3M0l7S0VlNURg5+etRSSFhNeD+Pai7R436VpJZIKeN
 Z7F4ZMSlcx6g3PAK4e87a1N2nOrit+sRLtJ6iN+97K2gElreSaJxxrv43daGv187CrxD cQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3w1dcbj8e7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 07 Feb 2024 17:23:57 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 417GKDVX038468;
	Wed, 7 Feb 2024 17:23:57 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3w1bx9b3w2-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 07 Feb 2024 17:23:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jtwJsbAevQQE16LKUSa9Z3Af1Y/ooq/5qG8zxj9YnGFynX+9vPRic4s99iIxbLIsQYw1Q1x6dYOSrPpxTfN/e4MrX3EztDY2gDFP3CatDKYTbn48Stc0Q+Z4wRZLaLxr7InjmbvY/bjtzFEMbciFSA0IfznWAnEpBDxbjxL104APssAe/s++8LUiNm2BY0QzOnDmLFOl6IM6Tku6D7E8zjSYayvaFACzxFPrP0UJ9A3KWNFmeS2SvLA+/il5YvWvT2+epjwsAVg36rYDWtTuJp3dmdQkllOv9JEHBF/PFH8cZtEIpfFtfCAAkGxG7VtZRsxe2NGBeSLwDz1GSUQHew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JpMAeesah8PNMeeUNULCMjZ346Ms7GKc502TBfk+fbw=;
 b=J04TUzcTqAv1Xj7QXFuocDb6rY+yGPwt9W5Xr5f85WLHJLF6UEM6FnhS7Wj8J1EbheG1hysZt/LwAqGSTeRKJYMr63vmeUVb8KTCaikIeEjRLBxj4S15805tBLYDNM/1bQCtM5hkC1FZI/q+z96jM+q/2VW9iR1xUaYWassWTMASCQijImZDXHa8JLZYQO2hj+RbDHeQe9JjilYnVmVJ6uX+7x5WdYX91eL62p7QFSNAuD3Cr6smyFSxSHXnXjekuhw/BuGlrb6KDLWrGS2WNoetVcPw3Bwrd3mewiGb70dippYBDxvjUgbXjLna2lrLqqNMQAhE2C5GJmDAOiQS4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JpMAeesah8PNMeeUNULCMjZ346Ms7GKc502TBfk+fbw=;
 b=YLo2Ab6fWcVMU+uwhLTfCKj9/VQzsS5qjPmend6+LHuMjHp/9b8phjU2PXFr4ANflUXIaOKOIXGhr2fzZLTlomygXw2ZN3wHWB5Ca/KdzR8BUPRH00/CXhOx/vYcxuO02tUkDSIbT1LzPh/Ejp3j7IzXcv8Z3kzJ1ryy8a1C1sw=
Received: from BY5PR10MB4306.namprd10.prod.outlook.com (2603:10b6:a03:211::7)
 by IA1PR10MB5948.namprd10.prod.outlook.com (2603:10b6:208:3d4::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.36; Wed, 7 Feb
 2024 17:23:54 +0000
Received: from BY5PR10MB4306.namprd10.prod.outlook.com
 ([fe80::68a8:709b:34ed:2aeb]) by BY5PR10MB4306.namprd10.prod.outlook.com
 ([fe80::68a8:709b:34ed:2aeb%5]) with mapi id 15.20.7249.035; Wed, 7 Feb 2024
 17:23:54 +0000
From: Allison Henderson <allison.henderson@oracle.com>
To: "kuba@kernel.org" <kuba@kernel.org>
CC: "rds-devel@oss.oracle.com" <rds-devel@oss.oracle.com>,
        Santosh Shilimkar
	<santosh.shilimkar@oracle.com>,
        "edumazet@google.com" <edumazet@google.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "davem@davemloft.net"
	<davem@davemloft.net>
Subject: Re: [PATCH v2 1/1] net:rds: Fix possible deadlock in rds_message_put
Thread-Topic: [PATCH v2 1/1] net:rds: Fix possible deadlock in rds_message_put
Thread-Index: AQHaVG6LDphLu37HU02eZhIVlnxlVbD+N02AgAD0rYA=
Date: Wed, 7 Feb 2024 17:23:53 +0000
Message-ID: <6c63549d6771bfb1ab410338b2dcea3e3fedb415.camel@oracle.com>
References: <20240131175417.19715-1-allison.henderson@oracle.com>
	 <20240206184809.1a245236@kernel.org>
In-Reply-To: <20240206184809.1a245236@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.44.4-0ubuntu2 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY5PR10MB4306:EE_|IA1PR10MB5948:EE_
x-ms-office365-filtering-correlation-id: 4a1e7c1b-0a94-4337-3b28-08dc28018f0c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 AligGM6d3MNoedYGQWCVaDWVC9PjJ29f6Bwame10eg2txaVkcaOF7Wyl9CZFZR5yLhPfDQQ9jVF0N1xN4Tmflq+Mzi4U2ltdEUJQBDzQzASGqMiMC0GXn+J8iI6grnfZzAGM/SAqhW8L90bAdjdOVmyu4hTRw/xCrWjvv4+AuWozYtnrcmW7icHdUgEprsSRSWRIYnG0kx5/lpZHyur2It57RkSCyAbSnPpradd0wY5InFXd3QtBU+zIGmhPXcmQYSuWdYPix9FG712mwJzrUKwBDJp3Bus3wpbC5JHigw+/oHzCfITBV/JCuLltY/QyyGb1S2NZHq6xt6fsbAhLR/n3ofV9ZBmvw9mwsd0VW+EuMEUB5KpDLXo0f7y+a93iw+JhyBVKz3YIeKgPLtqH3gZY1UB+9y2seDCO4qw9+j6ttHvXo3eJieZPvr6jfUmLB37uDKgagCnur+DZAXPw21PdgYvFIYbD5Al3+m+EeBOO5QtzFdkH80t3GTEmDLoF6NHNz9bvWoAd0K8ZG5i/fzX8UOc7L2ujF7/dcbjAH88fyZkjU10O0uNZNcRv2eZXnjYv1KwRevOoj6/pqmIRn739c4W2P8GNme9fwrqnKQ5Jk2TN9+KwUnMNbYo9tRGm
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4306.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(396003)(376002)(39860400002)(366004)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(41300700001)(38070700009)(66556008)(66446008)(66476007)(54906003)(64756008)(6916009)(66946007)(76116006)(36756003)(316002)(5660300002)(4744005)(2906002)(4326008)(8676002)(8936002)(44832011)(83380400001)(38100700002)(122000001)(6486002)(26005)(6506007)(71200400001)(6512007)(478600001)(2616005)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?MnVNWDcwMjVCdURJc3AvbDhjdnl2SCs2eG1Pc1BUUXl4MDN2dWNZVDNoekw2?=
 =?utf-8?B?c2VwT2NVWEZpbVF5L1A1WERzOHlSRHdGZWg0WUhlU2IvUVR1bUE1ek1sMVVp?=
 =?utf-8?B?bkNaamRmTFRSTFY4dld6b3hUNVl3QzdNc3cweWJWL2cwQ3hqNVhIVnRwOWN1?=
 =?utf-8?B?R2QyK0RZQlhxRjdkRVluRlQyQW1UajdjQ3lPK1lEeEJVMWNNb3ovQWxrRVBn?=
 =?utf-8?B?b1VLS2FjSkEybnBiUytWQzlGeUV5bmRWYmt5RWkyeWQvbXpXZzAwNm9jMDlq?=
 =?utf-8?B?STUyOHNRbDgvY0xWaUcxUVZVcERnOUVEZGRtQnNNTVpvMW85M0lVbVVITmVW?=
 =?utf-8?B?VDdiNndaZWJNQ3VKa1k0cXdsQWFwQ3RYRThHSWE2djIwaXJteExKNGdYdmhs?=
 =?utf-8?B?UjZGdDF6OVplRk9VNGozeGh3OFY5aUxycEczZUUwQTRRUzk0eVlPNjVFWEFZ?=
 =?utf-8?B?eHFIWFVncVBvdk9JSXZyR1ZTTXRPSGZpNlVteHdDbk51aHo5WVh5S29TRHBl?=
 =?utf-8?B?QTJVNEdsK1o0RXZKMWNJZWRFRG4zRjdjUUhuVFJLdXJIZWlob3plSmEvK0I1?=
 =?utf-8?B?b0xkM0IzcHR6WE5oVFRmdi9JUWFCd1EwVDhPMVd6U0RVcHVZVkduZEM2c2ls?=
 =?utf-8?B?eVNTVEJ0R0g4NDMxUlFXdldCbURtNGdYK2RMektaSUpRbGZaYkJjQVFGeG5M?=
 =?utf-8?B?QWhLZ2prK3A1bkhCR2RYdS96cjRLenllL2dkejU1Tks0WkgrTUJkL0pNeWht?=
 =?utf-8?B?NFUzMEJJaURLaWlxVWpCQk9UYmpMdmFSV1Vtcld3YysyWlF1Z3AyUzI1Y0xB?=
 =?utf-8?B?MHRtZkc2c3NtVWxkalNUbTdWejRXVldNbFhSMHo0WkNtT293dTNyekFmWndQ?=
 =?utf-8?B?S3BkZDJINEZhRFhqMTFFYnVTcDJxVG5OV3ZFK0dsNEFzc2puRlV6UWpucUVl?=
 =?utf-8?B?R2VVYWY3eW84TUNYN3E5NDR2bko4eEFKSXgxOFYyU3h3T2J0YjVwZjVtN0pv?=
 =?utf-8?B?S3RFd3hHYVZHYjRKd252TGY2L2lvMEJ5MlcxZ0hYTVUvQ3dHZkwvN0M0SHlM?=
 =?utf-8?B?VDRma1BMdWxHMUltcUZKSlhzMUZYTDBDRG0xeXBmeTlreFA2K3RwTGJSSjh5?=
 =?utf-8?B?UjhxaGZkaTdQeGhBQlJNMittbDhrN05XUEJJS2wvMXdHMFJOMWI2dzJhbXlq?=
 =?utf-8?B?YnM1ajIxWVJ3amhlVkZHaWFNZTU1Z0hPUmdDc2xxQW9iTGFENFRyWHMyelp1?=
 =?utf-8?B?bzloSXMvc2c5WG9Cb0VEVGpRRHdwV0M0NTg4M0RxYkJPeUFUbnhteDVLWllZ?=
 =?utf-8?B?a2w0NjhWZDMvWW5LYkk0aFhWbkpIeEt2OHljRTdiUWpmWEtlUUZlaXlUUVBS?=
 =?utf-8?B?MmtzN3dlbXpwNURSUCs3NDBMNVBWZFZKbUQ5VFhEeGorK1djL05Nc0I3Rmlp?=
 =?utf-8?B?REI4eFdOZUFUMzlOUW1Xbk51WTByRFV1MWg5bkpJWmxwei9lVk12UHI4RVNs?=
 =?utf-8?B?elBIbFh0Z05mSzZwY3ovczVLWll2ZHdTOXlBSk1CY3A3Qk9ON2FlZW81amRW?=
 =?utf-8?B?bzdZRmF3azU5QUJ3YktNbmtBbTYrNEpVeFdsSGU1Zkk3RFltU3NSUVVFa09H?=
 =?utf-8?B?S2JlT1VESWxHaFZhbzRubHFOdHhKaTV6NU1YKzcrdHJaN09tWUlqelU1MkZu?=
 =?utf-8?B?ajhqMzJKSkpsZDZudGVNT014U2x0TElvNE5wbW94RnBnRkZSVmJmbUtadVJ2?=
 =?utf-8?B?VExrV1IyYmhBR0tmdnRkbDBxdlN6eDhNWnFwWjd4MmJSblhWT0ZpbnljYnJ6?=
 =?utf-8?B?WEt3R1VYbThJMUdpSXdZVW1JaXA1WHUzSFFUVkxuaEJDUkRPRG1GQWk2eFNv?=
 =?utf-8?B?dVZNU0tNU2JsdTFnb2gvYjFnTmlKSnkwbVBpWGdvc0dwL2ZHenNzVTNyS2pD?=
 =?utf-8?B?RTNhMHNTeVQ2Tlk5OHhBeWZHajNZQjc2MTBYd2Z4N0hxbytPdmlQTS9CQXBW?=
 =?utf-8?B?N1V2bGwxWlQwcmV2dWtkNzQ4MWtQYkM1a3N3bzZ2QzZ5Vm1ZUHVSdThxN3lz?=
 =?utf-8?B?ckxaL2N0Y25iRXVSd2c4ZElFcVpuUmgrdnR0Wm1LUlh0OVlnRGFwL0I3SUVi?=
 =?utf-8?B?WmVlZ082OHRodHI3RjJiNVBZT25HUkQ5OEErcnV5QUROT1J1QjhHenIvSXBv?=
 =?utf-8?B?OVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <ADDA34309CE68D4C93477F86EF2BDECE@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	MJJAO19QiAixSNr4Bc6CQuSWSrbSzxcJdMvQwqx5wp4vECUyR4WXRtbEq9Fyy/rV7LBevaG9yEBMSxt0Od2X//ZEVV1uv021sgfFfmV631fbp/gyuy0v/qkfm2c1QksESnHL3xnoKOn1DX6J+C4g81YSPfsh9KAiw931uWqe7yLItGUc+cfs8g9bsnAHPP3XUl8+EiALz+2ZfO7SE6ibSmD4k8alDFxXMQzxsLAjUoUJ6oTfRHdeGOMCn7q9ylNFCJ0rMqpppXZKbYVXtt81n56bw3/fgDwqwJTc2Opbph1OwQNR/YcBzKiSuXSX4cxAxhsWu/QNWepXySC7HVBunEvS5yXNO14ISe65YEb0Kxr4k6I52qa9nr9Z3iJbc9zWhie4qkDr226k57U/o+ivx85nHjjkmJt80kSkaac4/IeEJTxqkYCH1bTlRtIt2ZgTquv0A9qw3ppEwYQhI8ZTe3eN5Ay1A4ca0wSqDrXfwRyx0a9V+HYYS4EIlyRLEqEDLl1+r4frNH+bLZZzcLUQE5syF8kBa7AXnUsUP7VOlKksYfkzhl3XjnbdvWLCsFwYM/ltct5RD+KrYAAzPact9fyFYl/G10FrPgGIjfmKfhQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4306.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a1e7c1b-0a94-4337-3b28-08dc28018f0c
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Feb 2024 17:23:53.9268
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8duNVc9VaV5+27o3mCwh1EisUoYWjmHQTDKYFTcwD+BCeqU9Ni3imOcy647b/QuFNHRat0ofZEWnQEyMVxcuGLAcBX4N2bV5YiWfQAgnfzQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB5948
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-07_08,2024-02-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0
 mlxlogscore=999 phishscore=0 spamscore=0 mlxscore=0 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402070128
X-Proofpoint-GUID: TFbDsU5IIYrV5Kd2tQZ4TMGLarKuVgUp
X-Proofpoint-ORIG-GUID: TFbDsU5IIYrV5Kd2tQZ4TMGLarKuVgUp

T24gVHVlLCAyMDI0LTAyLTA2IGF0IDE4OjQ4IC0wODAwLCBKYWt1YiBLaWNpbnNraSB3cm90ZToN
Cj4gT24gV2VkLCAzMSBKYW4gMjAyNCAxMDo1NDoxNyAtMDcwMA0KPiBhbGxpc29uLmhlbmRlcnNv
bkBvcmFjbGUuY29twqB3cm90ZToNCj4gPiBGaXhlczogcG9zc2libGUgZGVhZGxvY2sgaW4gcmRz
X21lc3NhZ2VfcHV0DQo+IA0KPiBUaGlzIGlzIG5vdCBhIGNvcnJlY3QgRml4ZXMgdGFnLiBQbGVh
c2UgbG9vayBhdCBnaXQgaGlzdG9yeQ0KDQpTb3JyeSwgdGhlIGZpeGVzIHRhZyBpZGVudGlmaWVz
IHRoZSBvZmZlbmRpbmcgY29tbWl0PyAgSSB0aGluayBpdCdzIGFuDQpleGlzdGluZyBidWcgc2lu
Y2UgdGhlIGNvZGUgd2FzIGludHJvZHVjZWQuICBXaGljaCB3b3VsZCBiZToNCg0KRml4ZXM6IGJk
YmU2ZmJjNmEyZiAoUkRTOiByZWN2LmMpDQoNCklmIHRoYXQncyBub3QgYSB1c2VmdWwgdGFnLCBJ
IGNhbiByZW1vdmUgaXQgdG9vLiAgVGhlIHN5emJvdCBiaXNlY3QNCnBvaW50cyB0byBhIHZpcnRp
byBjb21taXQgMTYyOGM2ODc3ZjM3LCBidXQgdGhhdCBkb2Vzbid0IGxvb2sgY29ycmVjdA0KdG8g
bWUuICBMZXQgbWUga25vdyB3aGF0IHlvdSB3b3VsZCBwcmVmZXIuICBUaGFuayB5b3UhDQoNCkFs
bGlzb24NCg==

