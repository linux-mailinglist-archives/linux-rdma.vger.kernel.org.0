Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F12E34694C8
	for <lists+linux-rdma@lfdr.de>; Mon,  6 Dec 2021 12:11:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242236AbhLFLOd (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 6 Dec 2021 06:14:33 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:12392 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236157AbhLFLOd (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 6 Dec 2021 06:14:33 -0500
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1B69kZRq015208;
        Mon, 6 Dec 2021 11:11:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : date :
 message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version : subject; s=pp1;
 bh=QgVulAjD1P594v9IKodLi/j3FiV0JPQ1oe9KOJ7kYNQ=;
 b=G7ZvFt7e8iT5RKvzNbTZQrv2S+gfLugWPBnGfLb7atp4bUFJ4x2d7w0CLcuo/ALpccal
 eU49bWytCjz77v0VWLQro5SlDMxuG/FO4ij9sqBQiq+PZ8wQNR+gi/L4C5CRRIRAMUjd
 IjQVsyIurfApBfs56NxkEaOyORKBMcrjpYDCy1LQFhEksUcYMVoLOqAxEsQVknzM/Xav
 4WYKYLlw9kPcMPWOs45X9GyzMpafOvDeFyxSrlgIWmRgoeY+Zfctrzj9m6O1KG4+QB5V
 LRmK2KX4ENWqWT88plOnAJuqPkgpOglWMDJoSFNseKIBA/ziB+lQ2PWdTX25XZTH+Tpj XA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3csdjdcm8f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Dec 2021 11:10:59 +0000
Received: from m0098417.ppops.net (m0098417.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1B6BAC4T021394;
        Mon, 6 Dec 2021 11:10:59 GMT
Received: from ppma04wdc.us.ibm.com (1a.90.2fa9.ip4.static.sl-reverse.com [169.47.144.26])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3csdjdcm87-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Dec 2021 11:10:59 +0000
Received: from pps.filterd (ppma04wdc.us.ibm.com [127.0.0.1])
        by ppma04wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1B6B7eoL021264;
        Mon, 6 Dec 2021 11:10:58 GMT
Received: from b01cxnp23032.gho.pok.ibm.com (b01cxnp23032.gho.pok.ibm.com [9.57.198.27])
        by ppma04wdc.us.ibm.com with ESMTP id 3cqyy9j65a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Dec 2021 11:10:58 +0000
Received: from b01ledav004.gho.pok.ibm.com (b01ledav004.gho.pok.ibm.com [9.57.199.109])
        by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1B6BAw0L66454014
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 6 Dec 2021 11:10:58 GMT
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3B704112061;
        Mon,  6 Dec 2021 11:10:58 +0000 (GMT)
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1B331112067;
        Mon,  6 Dec 2021 11:10:58 +0000 (GMT)
Received: from mail.gmx.ibm.com (unknown [9.209.252.101])
        by b01ledav004.gho.pok.ibm.com (Postfix) with ESMTPS;
        Mon,  6 Dec 2021 11:10:58 +0000 (GMT)
Received: from m03ex004.gmx.ibm.com (10.120.110.19) by m03ex002.gmx.ibm.com
 (10.94.54.156) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.20; Mon, 6 Dec
 2021 06:10:54 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (9.221.46.12) by
 m03ex004.gmx.ibm.com (10.120.110.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20 via Frontend Transport; Mon, 6 Dec 2021 06:10:54 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hG6llx3jJTv1Pq6FIrjAdiYhPWaXjzGsQJsqnL6HBOqCmLuMXBS9zK5a97NIbLyzb8d1PYyOgqG9a8kfa2ZSQd58U30yiMCz3LkUjsCIxKKNxT1RFQ0D+BPs6QqXES8MIbnK0E1+xVcm+IYESW7+0iShPBCGaUwFfDLO1gZN1wUPkW3sM2T6xVbRQR/VzeKol0n6hyG8pu1+8Hzos3+P7WyklEKIlDlpMOcEA2QIijFzXcejSdDRji24u7sm9OTH9TbWTRF5JzVqwjPAlpvKhuWJWcCmv0bTiJ4uGDQhZUgyBDE9gTCBQmnQ34LOV3Lyp+mB6/4/kqtN2k2eXD/njA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QgVulAjD1P594v9IKodLi/j3FiV0JPQ1oe9KOJ7kYNQ=;
 b=IPxc/wcxkFrjPZzBqaPhr/UT9QASfGrfu/0ssD5UjMN2AS0LsXC+mK6bQbtsSSCczIoKFIlfH9n5GUBwURbVlAJu3uykbZLD1fzGACMrnKOeleYkwOCQpc1vqgL0ZAMi7EkYy9akM8oauIRANAZOrtl8IKx3DLTjYfOQpaVoxbh1vYQlvN+TBa/k42k8n2tADNugeaNpKj6SAQDJyt54lg02Cdrq9P2gCYDnZ3yCNEa+Ceo+mZJf+Md3gP0R95QznaegHw4zHrueqO/sTM/ilIBeZBchwZztcxn0xb7LZfr2geSJLuHeAhDPnsTwLqAvHCRrNTt1ZzarvVhlVUMSxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=zurich.ibm.com; dmarc=pass action=none
 header.from=zurich.ibm.com; dkim=pass header.d=zurich.ibm.com; arc=none
Received: from BYAPR15MB2631.namprd15.prod.outlook.com (2603:10b6:a03:150::19)
 by BYAPR15MB2808.namprd15.prod.outlook.com (2603:10b6:a03:153::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.21; Mon, 6 Dec
 2021 11:10:52 +0000
Received: from BYAPR15MB2631.namprd15.prod.outlook.com
 ([fe80::7583:7c76:8fc0:a6ec]) by BYAPR15MB2631.namprd15.prod.outlook.com
 ([fe80::7583:7c76:8fc0:a6ec%7]) with mapi id 15.20.4734.028; Mon, 6 Dec 2021
 11:10:52 +0000
From:   Bernard Metzler <BMT@zurich.ibm.com>
To:     Leon Romanovsky <leon@kernel.org>
CC:     Yi Zhang <yi.zhang@redhat.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>
Thread-Topic: [EXTERNAL] Re: [bug report]concurrent blktests nvme-rdma
 execution lead kernel null pointer
Thread-Index: AQHX6c3f9z0pXqUS80mcT4B9wanED6wlPznw
Date:   Mon, 6 Dec 2021 11:10:52 +0000
Message-ID: <BYAPR15MB26317A0F809FDAB6BC739937996D9@BYAPR15MB2631.namprd15.prod.outlook.com>
References: <CAHj4cs8h3e_fY6cKb3XL9aEp8_MT3Po8-W6cL35kKEAvj6qs0Q@mail.gmail.com>
 <OF74AE32F7.7A787A6C-ON002587A0.003CDEF3-002587A0.003EEE89@ibm.com>
 <YaymumNuphhWiCc2@unreal>
In-Reply-To: <YaymumNuphhWiCc2@unreal>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: da7e83e6-0570-4dfb-fd4e-08d9b8a91112
x-ms-traffictypediagnostic: BYAPR15MB2808:EE_
x-microsoft-antispam-prvs: <BYAPR15MB2808294D3676BCB900078632996D9@BYAPR15MB2808.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1013;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 19wJKyk7rU3ClujY5w57lqGRi7XLFTRa+r1R6jXvSpqSMvUfae3arH4JtMGGWlxRfg4hh2dOzjYwXC7yUY8j4XF1zT+hRlj+s0BHcEh/FZ4DY7Onb4kP/uFZa5sSs+5EF8xa1ul7cRBLbru83ON1qc6cQ2lVGVO8lvdCeiPKC5W9446r6EklBc5xcZ6MwkK06f/XQKr5bhEVyoZooMrExBqfp9HTBO9v7NNKOL2q9IP7wy8xk6c7oXdNEDev+1lwjxGBrE5dHlbW7Jj7VH17MWOuOqsAOWOBVw6WaXuK/r0ssqQ/fAfNIIf6EDz8x41s9a4gviavJT8bDg5VXqNuyCuCPKrWlVxuhuTgHCJmYX+E1JCzjqp7ix6fScZYyZoUkAbhOUsqT6RiRmHbHnVRl1oy3u6ZVWdlVBMA7a8zUdM6fZk9XJaYuh3S/dwg2QEgteMqblSAxR/+Du4BhybTQAwZW/brDS5a9vlf3B3iU8zz7FdXl843Iwb3MLKjz27NV/E87Cg9TguFcBtuDyMoKVmBx8nVNq885r/nxELJQjjv+TgPX46kKGmnLWus+EDPZhYimU98tircnANuxNkkag/rXj6uRKY4QhNbkWkEfprL+OhGOukwqVMHZ6cTGQp1oBIykEhrciefOyDtsWgt5AO2T5tdxDLLcNoGiRfq+ooPS46NmN+NcequCOF6DrSBidpl77K8sSzDQjSM9O5fjg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB2631.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(86362001)(122000001)(8676002)(2906002)(71200400001)(186003)(6506007)(316002)(53546011)(38100700002)(4326008)(8936002)(54906003)(33656002)(64756008)(38070700005)(6916009)(52536014)(5660300002)(83380400001)(55016003)(508600001)(66446008)(66476007)(76116006)(66946007)(7696005)(66556008)(9686003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WjRZMVhYb2xXRTJEeHdENnBaNDY5RG4xdHhPM3lUcXRscEgrcys0UG9nQWlK?=
 =?utf-8?B?aDRYNXFyQlpSZ1M0RHlsTm43Mm9walE5L2QxVkM1aW1MTW5PKy9Ddk03MlBz?=
 =?utf-8?B?NjhOOWZYV05oQk5RVWRRQlFscFp2VWhJWXJSclArSHpYV1BpSEtyVGJOMURR?=
 =?utf-8?B?cUxQUzV6c2pFNnJ6RUt6MXpId1hQN0RLZGFUUHFFdUdtQnR6K0V4ZG01Zmov?=
 =?utf-8?B?R3VsQS9iK3ZJaE9DeGUwY2RJc3JRd2J6cHg3WW1vNHNrTUliZTh3Vnpad1hH?=
 =?utf-8?B?REJrTHExeXF2MTRKOGNSTS9BdExvWVN3ZUVCOHlwMnBBKzJKNHhZZzlFSE1E?=
 =?utf-8?B?UUt3VzhsZzYxWXdheWdySEExcTNrWFFoMHQvNU9FdGNaTE9Na01PSXRBWm4w?=
 =?utf-8?B?bThRZVV6NExjY3RXZnJ2L1VnOVFMdmZpdWhqVnJyUk1jQ2hONXM4aThKY3FC?=
 =?utf-8?B?R0ZFVFFhczJ1L3M3T2ZxUERtOTZTYmkyR2RhQ3V0OVdyamQxQU5yMzlXVGxz?=
 =?utf-8?B?UjIwdkRNSjdNWitiSWFkYldtZGFKcnAxS2FpQWJaSlBFUXVYbEsyclZPWkpv?=
 =?utf-8?B?L1czUVpZWWpkZXVvSzRxZXBQeWg1VnlvZ3RCdkM5ZmN2TnVZelhPMmd4With?=
 =?utf-8?B?Z0t6akROK1lLQnpPMHBBQitVd3lxRnpMOXdXL1dQRDZjbi9WZzk5UE0xVVFO?=
 =?utf-8?B?TmpsYi9TL1RmL2l5eTh6M3pHazgwT3hXaTM1VGpWZEVrRW41eEt0K2QzdStM?=
 =?utf-8?B?ejlZL1Ard0l5b2k3YzlsVVNwSTByaDJUZ1BtYm0vS3k4L0VZM2xpenBBR3VT?=
 =?utf-8?B?aVJVZ25tUUhkaHhPVzZLSU5qaU1BUmVjYzlDSTBncEhBeVUyZW8yVGt5T3E1?=
 =?utf-8?B?ejBVbE5sOXFpRTRxMW0yanR3YU9kMERjSk1lcDFNTjdEQjBDcEdCbFd3R0Rn?=
 =?utf-8?B?QzJEUXFuU2FTUzJSU21SMit2YUI4d1BjcHVEWGNyWnpBTnRiNXJiN1l6UW01?=
 =?utf-8?B?NHJ1TTlpM240bCtqTnFSSm4rUVVJQ1NGZHFUdjBZSnVTcUVsR1dhTWExMXZ5?=
 =?utf-8?B?b2ZBbkRoK0Q3enE2b1AyMGVSVXViU3FCT3Zjb2pmejJ6V2c2blBSMlg2eXFZ?=
 =?utf-8?B?emRKNGNDcnBHdnhiY2pKMENvK3NFVTJlY0dBSnR2MGxwQlI4OU9hdmFrNTA1?=
 =?utf-8?B?dThiYk9pdjlaV3l1QlRnRkxpMlNlWGl4UWpURU9aVGdSZFFnZklsWDRuRHZY?=
 =?utf-8?B?djBObnJMT3JjQ2pyQ3JnSmQzMUJIclZSYndmOTJGVStwbW9TZjRFcnVPMG5j?=
 =?utf-8?B?WVdYdUZ3SzBzUFRkR0U0WWJoWEFuU3JFZ0xHT2FrVkV5djhFQUlNK3FjQnRj?=
 =?utf-8?B?VjdVNGo0ZHZGRlpJbHkvSlgzODJZV1RVcXJLWklseHJlVTljZUpTYnB2U3Zl?=
 =?utf-8?B?TG1aRlgzZ1NwOGlOTHVCU2pEUVN3VlRTTTFSVEpHZmdMTDBSNFluTDZNUDll?=
 =?utf-8?B?RG51a3ZxemZhYkY5bWkyelFQaElkYnBJNThYWGMzZUVGaFJnYTgyYzVNQkp1?=
 =?utf-8?B?eEErVEgrbkNZOXZWdk5iS0JkQ1pMZE41Y0lBaUY0UjR2S2dDYktkRWRHVEdZ?=
 =?utf-8?B?S2RONCtVTlQydmFzUzU3NmVJZllCeW16MlAram1WcFlUeWE3MUxIbGhYZTl3?=
 =?utf-8?B?eXpjUFg0UkJyMndQOUQ5dG5ocGQ3NEtrbVlpaFlXVXZ1OVJsK1c0MGJERC94?=
 =?utf-8?B?YWlaeDBYR0J5Wk1EQmxPdXppNjJ0M3dkYkRLVjg5QzFxREpTRGRNZUd4TDJl?=
 =?utf-8?B?Y1l6R2s3WmJ1WkpnN0ZQQk5TeHNHVHdqZUFaeW1zejF2TncvQmlLQVlBNkNZ?=
 =?utf-8?B?cmF3T3VKVXF5UFVqOHp0R3UzTWNyazF4ZnlycDlYaFJybFN3UEFtM1dsQ2M1?=
 =?utf-8?B?YUZYTS83bjAwcFlKL3AxV2hXWjdUVi92QTFnK3Bmbm5UdGhsSkR4MkFFaGxI?=
 =?utf-8?B?a1ErMDJ2VkZob1dJdE8vQUdUL20xSG4yVERlMXM5ak5GSzVtTWNUTFhDQTgr?=
 =?utf-8?B?akU4Y0laMUQ1Yy8vYlRIN2s4YU5meEcxaFBYeU5WWmlVYWZMcjFrblhvdWNM?=
 =?utf-8?B?aEJNNWFkZ0F0Q2ZDN0tvWGk0ZEFQQnBLOE9lRjVlUVdCaXBNN2NOeHBSS2JV?=
 =?utf-8?B?Q09DWkl1UjRDcnNzRGY3WWs1T1hIWjhGeWUrTWxINzN6ZHJmUGppM00rMkE1?=
 =?utf-8?Q?hpP6n27xo1FYDgnpHxd9zYByVE1FDf8L9ttFBYUcnA=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB2631.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da7e83e6-0570-4dfb-fd4e-08d9b8a91112
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Dec 2021 11:10:52.4657
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: obPXlnvxuMSQUlTn+Z20PEvBeT8oUW9ROfjSehr/qybui1vqFaEPUqIIk7g6H+0M6oED1XYAuzz5GdnHORmoIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2808
X-OriginatorOrg: Zurich.ibm.com
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 9Dddp6sVqErjkqvVzrVKJw6dozZQQ3-a
X-Proofpoint-GUID: SY5tqtRiDDxJ3qkS9mEyQc_vErfw__7R
Subject: RE: [bug report]concurrent blktests nvme-rdma execution lead kernel null
 pointer
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-06_04,2021-12-06_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 malwarescore=0 clxscore=1015 phishscore=0 bulkscore=0 spamscore=0
 priorityscore=1501 suspectscore=0 impostorscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112060066
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBMZW9uIFJvbWFub3Zza3kgPGxl
b25Aa2VybmVsLm9yZz4NCj4gU2VudDogU3VuZGF5LCA1IERlY2VtYmVyIDIwMjEgMTI6NDcNCj4g
VG86IEJlcm5hcmQgTWV0emxlciA8Qk1UQHp1cmljaC5pYm0uY29tPg0KPiBDYzogWWkgWmhhbmcg
PHlpLnpoYW5nQHJlZGhhdC5jb20+OyBSRE1BIG1haWxpbmcgbGlzdCA8bGludXgtDQo+IHJkbWFA
dmdlci5rZXJuZWwub3JnPg0KPiBTdWJqZWN0OiBbRVhURVJOQUxdIFJlOiBbYnVnIHJlcG9ydF1j
b25jdXJyZW50IGJsa3Rlc3RzIG52bWUtcmRtYQ0KPiBleGVjdXRpb24gbGVhZCBrZXJuZWwgbnVs
bCBwb2ludGVyDQo+IA0KPiBPbiBGcmksIERlYyAwMywgMjAyMSBhdCAxMToyNzoyMkFNICswMDAw
LCBCZXJuYXJkIE1ldHpsZXIgd3JvdGU6DQo+ID4gLS0tLS0iWWkgWmhhbmciIDx5aS56aGFuZ0By
ZWRoYXQuY29tPiB3cm90ZTogLS0tLS0NCj4gPg0KPiA+ID5UbzogIlJETUEgbWFpbGluZyBsaXN0
IiA8bGludXgtcmRtYUB2Z2VyLmtlcm5lbC5vcmc+DQo+ID4gPkZyb206ICJZaSBaaGFuZyIgPHlp
LnpoYW5nQHJlZGhhdC5jb20+DQo+ID4gPkRhdGU6IDEyLzAzLzIwMjEgMDM6MjBBTQ0KPiA+ID5T
dWJqZWN0OiBbRVhURVJOQUxdIFtidWcgcmVwb3J0XWNvbmN1cnJlbnQgYmxrdGVzdHMgbnZtZS1y
ZG1hDQo+ID4gPmV4ZWN1dGlvbiBsZWFkIGtlcm5lbCBudWxsIHBvaW50ZXINCj4gPiA+DQo+ID4g
PkhlbGxvDQo+ID4gPldpdGggdGhlIGNvbmN1cnJlbnQgYmxrdGVzdHMgbnZtZS1yZG1hIGV4ZWN1
dGlvbiB3aXRoIGJvdGggcmRtYV9yeGUNCj4gPiA+YW5kIHNpdyBsZWFkIGtlcm5lbCBCVUcgb24g
NS4xNi4wLXJjMywgcGxzIGhlbHAgY2hlY2sgaXQsIHRoYW5rcy4NCj4gPiA+DQo+ID4NCj4gPiBU
aGUgUkRNQSBjb3JlIGN1cnJlbnRseSBkb2VzIG5vdCBwcmV2ZW50IHVzIGZyb20gYXNzaWduaW5n
ICBib3RoIHNpdw0KPiA+IGFuZCByeGUgdG8gdGhlIHNhbWUgbmV0ZGV2LiBJIHRoaW5rIHRoaXMg
aXMgd2hhdCBpcyBoYXBwZW5pbmcgaGVyZS4NCj4gPiBUaGlzIHNldHRpbmcgaXMgb2Ygbm8gc2Vu
c2UsIGJ1dCBvYnZpb3VzbHkgbm90IHByb2hpYml0ZWQgYnkgdGhlIFJETUENCj4gPiBpbmZyYXN0
cnVjdHVyZS4gQmVoYXZpb3IgaXMgdW5kZWZpbmVkIGFuZCBhIGtlcm5lbCBwYW5pYyBub3QNCj4g
PiB1bmV4cGVjdGVkLiBTaGFsbCB3ZSBwcmV2ZW50IHRoZSBwcml2aWxlZ2VkIHVzZXIgZnJvbSBk
b2luZyB0aGlzIHR5cGUNCj4gPiBvZiBleHBlcmltZW50cz8NCj4gPg0KPiA+IEEgcmVsYXRlZCBx
dWVzdGlvbjogc2hvdWxkIHdlIGFsc28gZXhwbGljaXRseSByZWZ1c2UgdG8gYWRkIHNvZnR3YXJl
DQo+ID4gUkRNQSBkcml2ZXJzIHRvIG5ldGRldnMgd2l0aCBSRE1BIGhhcmR3YXJlIGFjdGl2ZT8N
Cj4gPiBUaGlzIGlzLCB3aGlsZSBzdHVwaWQgYW5kIHJlc3VsdGluZyBiZWhhdmlvciB1bmRlZmlu
ZWQsIGN1cnJlbnRseQ0KPiA+IHBvc3NpYmxlIGFzIHdlbGwuDQo+IA0KPiBJbiBvbGQgc29mdC1S
b0NFIG1hbnVhbHMsIEkgc2F3IGEgcmVxdWVzdCB0byB1bmxvYWQgbWx4NF9pYi9tbHg1X2liDQo+
IG1vZHVsZXMgYmVmb3JlIGNvbmZpZ3VyaW5nIFJYRS4gVGhpcyBlZmZlY3RpdmVseSAicHJldmVu
dGVkIiBmcm9tIHJ1bm5pbmcNCj4gd2l0aCAiUkRNQSBoYXJkd2FyZSBhY3RpdmUiLg0KPiANClJp
Z2h0LiBTYW1lIGZvciAnc2l3IG92ZXIgQ2hlbHNpbyBUNS82JyBldGM6IGZpcnN0IHVubG9hZCB0
aGUgaXdfY3hnYjQNCmRyaXZlciwgd2hpY2ggaW1wbGVtZW50cyB0aGUgaVdhcnAgcHJvdG9jb2ws
IGJlZm9yZSBhdHRhY2hpbmcgc2l3IHRvDQp0aGUgbmV0d29yayBpbnRlcmZhY2UuIEJ1dCBzaG91
bGRuJ3QgdGhlIGtlcm5lbCBqdXN0IHJlZnVzZSB0aGF0IHR3bw0KaW5zdGFuY2VzIG9mIHRoZSBf
c2FtZV8gVUxQIChlLmcuLCBvbmUgaGFyZHdhcmUgaVdhcnAsIG9uZSBzb2Z0d2FyZQ0KaVdBUlAp
IGNhbiBiZSBhdHRhY2hlZCB0byB0aGUgc2FtZSBuZXRkZXYsIHBvdGVudGlhbGx5IHNoYXJpbmcg
SVANCmFkZHJlc3MgYW5kIHBvcnQgc3BhY2U/DQoNCj4gU28gSSdtIG5vdCBzdXJwcmlzZWQgdGhh
dCBpdCBkb2Vzbid0IHdvcmssIGJ1dCB3aHkgZG8geW91IHRoaW5rIHRoYXQgdGhpcw0KPiBiZWhh
dmlvciBpcyBzdHVwaWQ/IFJYRS9TSVcgY2FuIGJlIHNlZW4gYXMgVUxQIGFuZCBhcyBzdWNoIGl0
IGlzIG9rIHRvIHJ1bg0KPiBtYW55IFVMUHMgb24gc2FtZSBuZXRkZXYuDQoNCkhtbSwgZnJvbSBh
biByZG1hX2NtIHBlcnNwZWN0aXZlLCBJIGFtIG5vdCBzdXJlIGl0IGlzIHN1cHBvcnRlZA0KdGhh
dCB0d28gUkRNQSBwcm92aWRlcnMgY2FuIHNoYXJlIHRoZSBzYW1lIGRldmljZSBhbmQgSVAgYWRk
cmVzcy4NCldpdGhvdXQgcmVjcmVhdGluZyBpdCBvciBsb29raW5nIGludG8gdGhlIGNvZGUsIEkg
ZXhwZWN0IFlpJ3MNCm51bGwgcG9pbnRlciBpc3N1ZSBpcyBjYXVzZWQgYnkgdGhpcyB1bnN1cHBv
cnRlZCBzZXR1cC4gSWYgaXQgaXMNCnVuc3VwcG9ydGVkLCBpdCBzaG91bGQgYmUgaW1wb3NzaWJs
ZSB0byBzZXR1cC4NCg0KVGhhbmtzLA0KQmVybmFyZC4NCg==
