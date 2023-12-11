Return-Path: <linux-rdma+bounces-376-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A94F80DAD4
	for <lists+linux-rdma@lfdr.de>; Mon, 11 Dec 2023 20:25:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 986471F21AA5
	for <lists+linux-rdma@lfdr.de>; Mon, 11 Dec 2023 19:25:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C505152F84;
	Mon, 11 Dec 2023 19:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="C/om+ZCK";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="nGPM78An"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 877A09F;
	Mon, 11 Dec 2023 11:24:58 -0800 (PST)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3BBJH6bH014788;
	Mon, 11 Dec 2023 19:24:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type : content-id :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=Dxlvq2p0wNDaHCx+AlVdIxidF+oh91hrzPeyM6s/n5o=;
 b=C/om+ZCKU4v6j9/Y6dCzliaZNX3tystjB7Q2nFCfHl9I2J7HBvWiWq9Qkehw+FNtYlUf
 qtS+q4l4ssI2KVLHso7WRuHCOs51kfUPISK4fGezzDTF/VNka3Fxbb4opCu7rIaHJJcB
 Wr/4sk2i5ojXGc2GCCxsJt0K2rch1SVxFgFzp+DtA93gzIVwK66qMM8n2cTM4Wg6EHRy
 WhRa7ej/6FgxHwyjJRXKe4/Q/O07cryeg0bPE9e2lPxJZUrkSR6xf6YcVVoRGaZqQkGG
 TfW9XTRUiL1Xks2/6f2c9owZVUzewZ0tJd3l5hBlfl3HnRBm16MBDkcTp4wz3mgCqJ0L Zw== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3uvgsubtyd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 11 Dec 2023 19:24:55 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3BBIxspx018633;
	Mon, 11 Dec 2023 19:24:54 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3uvep5e4j2-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 11 Dec 2023 19:24:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bD143ZE/8lMoo2YwiFBQGErUD6u5KZbKZv0r+sjO58Lg4Qdo8xYxGZzvUg1SqzmCEk5HD0NhpbPDvLVBwyWoVylq5pJ5XnF6o37JHChVhhxjZ7IWSO60KBJYiF/y2i5qRBWi+iJtLjWBesy2VxoUEE6xxo7e0jhfJzKqBXTn7IN0xYiz3jmfsuuONCerySBHE/1BdzxoCPIDER7wWjFgnwHq6BNrjrtywOT4G3o4vWONflRNsRvmwVqx2X9snEuM8ZBPIiePVzRtgoWSsGtodpT53HQ1Szm2Ffyxn2LaxUwV5h7R9OZReNcGKos64xI4d4b73W62hxlyDz6hRykpVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dxlvq2p0wNDaHCx+AlVdIxidF+oh91hrzPeyM6s/n5o=;
 b=SkErZ3oQmu/++JoxRwBbA3LqBDj/edFKoOX8MUMKILcnzx1r1lMdnbClJb4GQ20SbZ17trC1FbnFzE9p8/xW7Qi7DEhydXdjmlY1D1/g71byTIj0hjyc4O2Ael6wTRurnL4iLE20w2JRg3RM1YalT4wlwyve5jidnIX0W+vfO9AOtL6+cYYb/oIH+Xh7dBbXniLBQmOpW8KqwmXZi+qwR15EmczpKv1Jwh8d/wdhjfc+d/YfvczpXJP/I9+1qdHfXfcNuZjg+kdeuw29vBaavYwQ9UcD138ESVQkbsnyRXruxCAYY7uRQr3qNZxyW96BY6n6tRjiVPWEK0Ue76ldKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dxlvq2p0wNDaHCx+AlVdIxidF+oh91hrzPeyM6s/n5o=;
 b=nGPM78AnUCXMXDx32ndr8QhYmNoxJXZxqlyF2zcNouZyJOG8ei4OI2OVf6FGLFPzMSgDP6hLvZoQ2qkV3Gse3DzY5QNtBI3u0LcbOIUPKYW/t0iActhcnH0UKhzQMRgmM/jpY871jUEqsCrl0WxWFn6n8nultxQYPA469d+Zqks=
Received: from BY5PR10MB4306.namprd10.prod.outlook.com (2603:10b6:a03:211::7)
 by CH3PR10MB7908.namprd10.prod.outlook.com (2603:10b6:610:1d1::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.32; Mon, 11 Dec
 2023 19:24:51 +0000
Received: from BY5PR10MB4306.namprd10.prod.outlook.com
 ([fe80::8cde:f1f2:6ec5:fbe4]) by BY5PR10MB4306.namprd10.prod.outlook.com
 ([fe80::8cde:f1f2:6ec5:fbe4%7]) with mapi id 15.20.7068.031; Mon, 11 Dec 2023
 19:24:51 +0000
From: Allison Henderson <allison.henderson@oracle.com>
To: "syzkaller-bugs@googlegroups.com" <syzkaller-bugs@googlegroups.com>,
        "rds-devel@oss.oracle.com" <rds-devel@oss.oracle.com>,
        Santosh Shilimkar
	<santosh.shilimkar@oracle.com>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "syzbot+listdfc3c773f22d2282a24a@syzkaller.appspotmail.com"
	<syzbot+listdfc3c773f22d2282a24a@syzkaller.appspotmail.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [syzbot] Monthly rds report (Nov 2023)
Thread-Topic: [syzbot] Monthly rds report (Nov 2023)
Thread-Index: AQHaLGe2dVHeRrzpcU2l+PGVb83/9g==
Date: Mon, 11 Dec 2023 19:24:51 +0000
Message-ID: <cffb062924c94a1c5f33617b244c2dfff66ccb04.camel@oracle.com>
References: <0000000000008f064b060aba89c4@google.com>
In-Reply-To: <0000000000008f064b060aba89c4@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.44.4-0ubuntu2 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY5PR10MB4306:EE_|CH3PR10MB7908:EE_
x-ms-office365-filtering-correlation-id: 0a35386e-0dce-434e-a04e-08dbfa7ed8d6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
	=?utf-8?B?ZXBmTHljbnc0QkRva1ZvRGRNQ3ZkWElrM2RBT0lKL21lWDBNU09ROWNIMkRw?=
 =?utf-8?B?T1FGOTZ3T2R1TmR5VmMrdzd0RlBkMDNKdzRNUjRIaGZieUNBZEJnalJOM3BO?=
 =?utf-8?B?Sm12aXRHSE82d05xejBHWmI2a0NsZnlaVFh0eDRVZGdJN2hOQ0pnVy85UXVU?=
 =?utf-8?B?Qi9NNmsyZDFGZ0o4TXVaQXgwQ0NCamwwMVExbzEvSXVOMU03QkVocUx4VEFT?=
 =?utf-8?B?SmxNaG44SW1YcUl5Q29sd3Vvb2ZYdm5nVE5qZ09KMlhXdmg0RWZTeC91T2RM?=
 =?utf-8?B?MlVlemhyRkZZRmp1SFhTejM2ekV5cVZaV2lMdVVPSk9nY2JQcld1QzVVNEll?=
 =?utf-8?B?V1FOdEs1N01PeEpqcWpDUkRjNURxYTFnZDlzb3VIYmlZTE5kTlU3b2JMU1Zk?=
 =?utf-8?B?ZEtxVk4rSTBLc0REWlhlU05taXBzZUVhUkNNY3V5VHdBZFRjQVdnNERVSGJJ?=
 =?utf-8?B?SE9VdkhTWC9RN2VSbHZic2lNOWVMSXVqcDFqdjVJdlZpb1lXMlVRVDUra3p2?=
 =?utf-8?B?eVdlZk9uNERtbER5S1NaVnFBM3I0N2t4UEpqNGtEK0Z0UFgzcGdvbzJrSGl5?=
 =?utf-8?B?WklhazhwNk1NM21vTXBVbW8rYXNoenBUWkhDTllIRHFuVVQ5cEVnck1uSGt5?=
 =?utf-8?B?RmpKMVcrSFBmdmpLTyszKyt1UUNBWVBrVmFHUVk3RTRrQ29GQ3B3YnRZaGRh?=
 =?utf-8?B?cDEvMTZicTJVRENkVm91Snk3aGJuWUlucTZCakJDL3czUjYyWWZETEs5d05v?=
 =?utf-8?B?bENvYzlHbkxXSEtRWHUwOHBsdEhWWTBVTzd1ZXVwSDZ5Z0ZjdmE4dWVqU2hW?=
 =?utf-8?B?amZ6bFZjYjE1SzhqZGFqQlpjMVRKYTV6RGR2OFlYOWlRVDVjYkJUQkJ5Wm9F?=
 =?utf-8?B?b0c3UTVUMEY2c1l2NUJjQ1dFRitjQkNVcGQ1VW04SHpZVks0T3RVTnplbzlZ?=
 =?utf-8?B?ZDVpNXRIaGtnQWxMSzdhdTUvK3dHVElrL3NvbzdXbm1VZ25SVXdTbFlTOWp0?=
 =?utf-8?B?azFQUlZ6d1RSMFlHSDZkdHpFN3dnOFlFWVpNS0JmUHA3UW1zRlEwSVd2eWwr?=
 =?utf-8?B?SGZqOGwzU2tRd2lNL0NocWtIMU9hSlN6ZTkrQVVZay9EOHlEcUoyL1puNkdG?=
 =?utf-8?B?SnlsQ3AvV3pMcUNpVDQ5TlY1TE9UMTV3NFlkQzkrYjJ5L0dEcXE0eFhDcEhS?=
 =?utf-8?B?blY1WnhQTE8yaUNraUhZcnBoQ3BiMzQ1V2E0bWNwMFYvWnlmb29IZHlTK3Zp?=
 =?utf-8?B?VlZQV0F6bk96QkdMNUdWTHVmUUxCaVYvQklWeGhnMlRIY3RQdz09?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4306.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(366004)(376002)(136003)(39860400002)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(26005)(2616005)(36756003)(86362001)(38070700009)(122000001)(38100700002)(5660300002)(83380400001)(44832011)(6506007)(71200400001)(6512007)(76116006)(66556008)(91956017)(110136005)(66946007)(8936002)(8676002)(6486002)(64756008)(966005)(66476007)(66446008)(316002)(4001150100001)(2906002)(41300700001)(478600001)(99710200001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?Q2J2eUtabVo0c0hua2xWOG5VUWlzK3BZRTJEeVBzYWs0ajlwczlQUHVVNUdU?=
 =?utf-8?B?Mk5XNi9KVzJwMGQ2K0R3em5tY0NOMFcxVGk0cVd0Wmp0L3VpR0EzYnVEQ1NC?=
 =?utf-8?B?VFZjNlhxSE1ZYml0Q3JNOWdiVWJTYnRrK2w5K21UckljK2tEa29oSU5RZ2JY?=
 =?utf-8?B?NzhPbkNpUG4zQ1JIeXVUMnZxb3NQTjM2eTR3R1JpSkwzZlFvcGFyOEZ5Vk1N?=
 =?utf-8?B?dURNajAzajI0RjJzT0dJaDZXVWplUnJ3NGdCdlZ5U21DLzdLZGhtbHRKWkpv?=
 =?utf-8?B?ZVROeVdRd3NTcjNtTm8yUzVPc01paVd4ZWE4MCtiSkxiTGJsOXIrZ01IL2E4?=
 =?utf-8?B?TVBFWXdCb2E2YUkzT2dTT0RRNkZETThJMWhiWUo2YTdPZldnb0txbEVIR3JR?=
 =?utf-8?B?Q2hWU2lqYkNuMHNqc2FQSHlBa3J0OTJDM1lNY01ReVNXbDJ2Mk5keXlMcGkv?=
 =?utf-8?B?Y01DeGFLRElaWjhWMVlZcXVoT0ZnSWd0dENpdlFwc3VZZHczMFVwOFJNaDNj?=
 =?utf-8?B?ME5hbjYxR2x0N3NaRnRZWC9wN2ZEZExwY0IzZFBOTVVJZ0pRd0FCWHhJUkR0?=
 =?utf-8?B?ZnpFYTJKdUJNUDFTclNkT3l1ZVIrV3N4c1dLajRxTUlmYjF2V1N3SzNQNUZF?=
 =?utf-8?B?T0RLYisyK1VXVFdXNmM3Vk9hNW9NY1g5U0EwQk5RTHp2VE5ZOE0rRXpTZDVY?=
 =?utf-8?B?eUh3ZDQ3UlpSWjIzbnQvREUxc3FPWkRyNkxjVVhoeTgwQW9tM3o4TnQzcjJj?=
 =?utf-8?B?Rk02QmlJSTZYWEQzdzR4eURxTzZ2UkNvMGlaQ1cwN0I0T2orMFM5eSs4ZDdq?=
 =?utf-8?B?M0g5aTdjRHZDSHZ3Y0doeGlOY21FYzVlaW1QTnBXSlhva25kenYvT3Zydk12?=
 =?utf-8?B?N2ErbXh3UU1OS2Y1YTdMT3EvYlJrZGVvV0J1bEk4OW9MclM0Z0M3UDhKL0hR?=
 =?utf-8?B?ak1heUtTMXVGNzJJdEFHb2JBMmlod1hWSjZnOFZ1ZzU2em4ya1kvaFhkNmE2?=
 =?utf-8?B?eGZNSE9IUU81eDI0U3RKa3RxMDF6SzRQS3V2V255cGU4QkhoRzBXVk1pa2JH?=
 =?utf-8?B?V25SajUyR2ZyQkxYVkswQWo0Tys5dkxaQlYyV01mcXJzN2RocGVzUDlSMjQ0?=
 =?utf-8?B?cURLaDZwNVRxSUtvdmRwd3N3UmZuTXVhbTFoNTJyNHl0TS9jdnE3Sml4L1l3?=
 =?utf-8?B?Sm1wUEx1bEVWVTFjdnVib0xwZTZ5TEcrNjNpS2lMb2hGdlhBZjJFRzZqUWJl?=
 =?utf-8?B?czdpcEJTUVp6dGo5ZjBrZ0hUeFhBVzVpOG1sdWZPSk5zYS8vRWFiVEdrVnNT?=
 =?utf-8?B?clc4ZXZsS0ZQbjl2R3Q0Q3doZVZIQXJISGV4bFJHSFZrMmU4WUw4Q2lmOUQ2?=
 =?utf-8?B?RW1Ha3hNYXY1Y0ZNZlJabVpZZTJZSzNjQ3B5T1BiTnNodEYxeFpwc1p2eWVK?=
 =?utf-8?B?VGdncW5hRUVtQWFQMW1XSytrM05zaFV2cVltT0h6L0h2N3hjOUoxNUV1RWkx?=
 =?utf-8?B?UzMrQVpLVEFZM0t2NnI4dkNRS1lqTEoyWkhZZGZsaUluWVVha3JtZHhRYmd4?=
 =?utf-8?B?eXFjVWZJRm9vcFY0cFp0K1d6L2c2V3NFTTc4cFpmMXBHM2RXVHFaU0xlQ3RZ?=
 =?utf-8?B?VGxyRTBiRUNhT1hpem0wUzFQOHFsZ3JDQkJXSDdDc2t1ZmxTQUFORFkxckdH?=
 =?utf-8?B?YUVGQXFEd3BmWVcyS3c4ak9RK2ZKbGJCOGFmWit1aDdXYnFiQnorMzNwRFZq?=
 =?utf-8?B?Z1pkd2ZSaEMzaGo4NWpkcUpWNlFCREN1TUYzM2U4S3RKbnRnZndYdHdGR0lR?=
 =?utf-8?B?dGNvbDJoemZ6cmJ2WXJFWWgyZk5Bd1BpdUNVQjZRejBNaW0yalZNNEt2Vjcv?=
 =?utf-8?B?eDNoZzdKKzlrRWRzSjZ4RGNqNDlhZStCVlR3NXE2eWpxVjNIS3dCWmJEeXhy?=
 =?utf-8?B?ai9vOTExOVpzQThxR2dudWtRaTNRNys2eEUxUUZZeU5nWHRjZGxXM3l3YWlT?=
 =?utf-8?B?eC9JWFFPR1djNUlPUm9DZTFuWi9DRW5WQnlyV25sNDBnUUdJSE9uaDl0Rmkv?=
 =?utf-8?B?anNpNzI4YklJU1FGamdDczJ3b1V5cHlLWG1mUzN1VEduejVCME9oMDNYaUky?=
 =?utf-8?B?OTNoOThYZ0VvVXo3MFhmYzc0TEVqd1g3NlErN0daeDFwK2ZSYnJrK05GZDVI?=
 =?utf-8?B?T2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8DE71176F549E245A2AAFB550D683A53@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	O+3yX/rpC3vu4yVvkPPLu8lSwK+WyavxUfLKsJVq5WLXqV5V9N4XMlN24fHScMvq7R1VeBJm5R1nE21Vdhu/4C1l18xASy1HHnwKQQgmRrb5IJaOpj2NK7m2Fg1a3d4Wmd5SYEZzkBmR6qxW9NsfvJWOHvqBd9dYW1swxZsJG9WOizzzKGoMIYlxTj+h5tMr/MEYY8stGAZl2GaPwtJExAHQBEM9HUFCcEVWs6ghFwCNPPejaJORN4P5+B09RVAlmSU+0fvFCshuXfE/5GITcQNO51yObfrDbX+dbAySxrwMiOuIkU648xND90O3A+ZP9kAzmQlcbJhpjpkWO9i5RhE1NDTqyJp7jKwBp8riZ854cGnUS/VECUW9OkxpnAgYV03prbgYyy05jlaRrcPyfyVjoKMjpqDCjI1/CqmyvTwa6/bUyEhKXqg/TcBR0KkutFRVitWxCw3+RViZP42IO1f16mOUPUYqXF1FMkrmIYWnnU7KjY53USDbgbqeACQ1doCA7QhjCg1ar4uJjf9lK9T8SJhMrsKRfRf8bJ2+/jBUUW/br8m+rRRoQCKcWIHMySpv1ghXqB73kOXCl+kVJkTupptDirgCGV1LiWNv5Ro2xbgJSGGeABlOc40+mr3uyAAivmqsXRLrOmKhxHmKQ5504oYOJf0Acos8seAE81baqhqeKy9SmeWFduS3iMnWj1b334yUkNJDzLlXDeguuNm0/eeApKH78B8sxNSOnwnvz3ONS/TlE8K9/JBgGdyTQIsPmzsJ3kJ1+hWtFlSBV+uMFaSs1bK3cTGsp8PB44d5rcS9hqbf+faLM3h2vRgJAIWNYEq2U6gfvKjO/oYdJsLEx43vLRxf9RTMPNrdIf8k5uMF8+30eMBfSc7GifuK
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4306.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a35386e-0dce-434e-a04e-08dbfa7ed8d6
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Dec 2023 19:24:51.3611
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tMV+bPzWReeq2PTb/PXs19zbXnc+Zl/RxVT06kO+n34/HLOJiO6fBAEmNSIoklakFmoYTXwKwYO6X/swJDr8rE084g9KERRuf+uPlSqk5IY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7908
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-11_09,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0 spamscore=0
 suspectscore=0 mlxscore=0 mlxlogscore=869 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2312110161
X-Proofpoint-ORIG-GUID: W37UahFjbPvl8BRgA7rXBrCmYPiOxXKV
X-Proofpoint-GUID: W37UahFjbPvl8BRgA7rXBrCmYPiOxXKV

T24gV2VkLCAyMDIzLTExLTIyIGF0IDAxOjQyIC0wODAwLCBzeXpib3Qgd3JvdGU6DQo+IEhlbGxv
IHJkcyBtYWludGFpbmVycy9kZXZlbG9wZXJzLA0KPiANCj4gVGhpcyBpcyBhIDMxLWRheSBzeXpi
b3QgcmVwb3J0IGZvciB0aGUgcmRzIHN1YnN5c3RlbS4NCj4gQWxsIHJlbGF0ZWQgcmVwb3J0cy9p
bmZvcm1hdGlvbiBjYW4gYmUgZm91bmQgYXQ6DQo+IGh0dHBzOi8vc3l6a2FsbGVyLmFwcHNwb3Qu
Y29tL3Vwc3RyZWFtL3MvcmRzDQo+IA0KPiBEdXJpbmcgdGhlIHBlcmlvZCwgMCBuZXcgaXNzdWVz
IHdlcmUgZGV0ZWN0ZWQgYW5kIDAgd2VyZSBmaXhlZC4NCj4gSW4gdG90YWwsIDUgaXNzdWVzIGFy
ZSBzdGlsbCBvcGVuIGFuZCAyMCBoYXZlIGJlZW4gZml4ZWQgc28gZmFyLg0KPiANCj4gU29tZSBv
ZiB0aGUgc3RpbGwgaGFwcGVuaW5nIGlzc3VlczoNCj4gDQo+IFJlZiBDcmFzaGVzIFJlcHJvIFRp
dGxlDQo+IDwxPiAxNcKgwqDCoMKgwqAgWWVzwqDCoCBwb3NzaWJsZSBkZWFkbG9jayBpbiByZHNf
d2FrZV9za19zbGVlcCAoNCkNCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoA0K
PiBodHRwczovL3N5emthbGxlci5hcHBzcG90LmNvbS9idWc/ZXh0aWQ9ZGNkNzNmZjkyOTFlNmQz
NGIzYWINCj4gPDI+IDXCoMKgwqDCoMKgwqAgWWVzwqDCoCBwb3NzaWJsZSBkZWFkbG9jayBpbiBy
ZHNfbWVzc2FnZV9wdXQNCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoA0KPiBo
dHRwczovL3N5emthbGxlci5hcHBzcG90LmNvbS9idWc/ZXh0aWQ9ZjlkYjZmZjI3YjliZmRjZmVj
YTANCj4gPDM+IDPCoMKgwqDCoMKgwqAgTm/CoMKgwqAgS0NTQU46IGRhdGEtcmFjZSBpbiByZHNf
c2VuZG1zZyAvIHJkc19zZW5kbXNnDQo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqANCj4gaHR0cHM6Ly9zeXprYWxsZXIuYXBwc3BvdC5jb20vYnVnP2V4dGlkPTAwNTYzNzU1OTgw
YTc5YTU3NWY2DQo+IA0KPiAtLS0NCj4gVGhpcyByZXBvcnQgaXMgZ2VuZXJhdGVkIGJ5IGEgYm90
LiBJdCBtYXkgY29udGFpbiBlcnJvcnMuDQo+IFNlZSBodHRwczovL2dvby5nbC90cHNtRUrCoGZv
ciBtb3JlIGluZm9ybWF0aW9uIGFib3V0IHN5emJvdC4NCj4gc3l6Ym90IGVuZ2luZWVycyBjYW4g
YmUgcmVhY2hlZCBhdCBzeXprYWxsZXJAZ29vZ2xlZ3JvdXBzLmNvbS4NCj4gDQo+IFRvIGRpc2Fi
bGUgcmVtaW5kZXJzIGZvciBpbmRpdmlkdWFsIGJ1Z3MsIHJlcGx5IHdpdGggdGhlIGZvbGxvd2lu
Zw0KPiBjb21tYW5kOg0KPiAjc3l6IHNldCA8UmVmPiBuby1yZW1pbmRlcnMNCj4gDQo+IFRvIGNo
YW5nZSBidWcncyBzdWJzeXN0ZW1zLCByZXBseSB3aXRoOg0KPiAjc3l6IHNldCA8UmVmPiBzdWJz
eXN0ZW1zOiBuZXctc3Vic3lzdGVtDQo+IA0KPiBZb3UgbWF5IHNlbmQgbXVsdGlwbGUgY29tbWFu
ZHMgaW4gYSBzaW5nbGUgZW1haWwgbWVzc2FnZS4NCg0KSGkgZXZlcnlib2R5IQ0KDQpUaGFua3Mg
Zm9yIHRoZSByZXBvcnQuICBJJ3ZlIG9wZW5lZCBzb21lIGludGVybmFsIGJ1Z3MgdG8ga2VlcCB0
cmFjayBvZg0KdGhlc2UgYW5kIHdlJ2xsIGJlIGxvb2tpbmcgaW50byBmaXhlcyBmb3IgdGhlbS4g
IFRoYW5rIHlvdSENCg0KQWxsaXNvbg0KDQo=

