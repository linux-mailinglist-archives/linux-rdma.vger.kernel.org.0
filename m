Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2F764789B3
	for <lists+linux-rdma@lfdr.de>; Fri, 17 Dec 2021 12:20:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233344AbhLQLUN (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 17 Dec 2021 06:20:13 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:56558 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233336AbhLQLUM (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 17 Dec 2021 06:20:12 -0500
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1BH88tSE012915;
        Fri, 17 Dec 2021 11:20:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=clwqjdWdUAhtBXQcHLMEbNE55ae6Ky0+hzMNSeaQo7o=;
 b=KCjP4/OCIoLLCUsxWj+NS4D89FOM+kJ8fwZhiG6EJpXRbAtzByEeV5cOvzSwwlGSLZUr
 Qh5qKWWiTIs/e6KH9ScP8oY49WuBqzLVAM7DnzMhevYdxnVRl2R+DqwyPZLrTjOGXm8Y
 UrRWJ23oiysml9VoThwAK0JOhaY70vCVQGHtvKnHQ+PHIH1Z2/rxdvDbzEOFT/akNKY/
 mYLABZyzjKMwisciNoP9PQiQLLwb6B5yUEEYeGSUAkbn3t3YvjXyQb6VB4p+fmM8VgYv
 gE24RF1q1/Lnec/AoE/DuNOskizSpzRkCQz7m9nvTvbrOaWAZ0/oc72tlU8yTFbxbZGU 8Q== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cyknrncuv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 17 Dec 2021 11:20:02 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1BHBGcFM107887;
        Fri, 17 Dec 2021 11:20:01 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2046.outbound.protection.outlook.com [104.47.66.46])
        by aserp3020.oracle.com with ESMTP id 3cxmreu6qj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 17 Dec 2021 11:20:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B1H+W2arvpFRa7FPKHO5jYfD/uzD9bDb7+SiKDe1nMVHELi+hs++fNfgvT3PzAX5QWvu/TxgvC3jOkjFqB/6zC2uLGJ5hDhWcu5ABE8O2IELR3zfAkKkuZw7GXyzOeJbwDAt+Ir9vZOqrDe8dZ7rpv+KfRZiW/3ULDfrhwopbqHJRgxCbtueGRNDrLbBQ6EFkqt7ONB6gPRMkc/7AdSJFvjBxtLPkyCS+PAc5gv606+8pYVSkT8B9tI8LCUKBgnUCj9mNXfExORuXl2P6Bczj3H/2YNxH1LyBVW5HsCQv9O/tMnpPNkgLUC06AXuUQAiVfgkJl90tYRAO0x+uwCddA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=clwqjdWdUAhtBXQcHLMEbNE55ae6Ky0+hzMNSeaQo7o=;
 b=GKMBs4zNpRdG+UoOvVh2wY+lZWinQNWPoOQmLUlvSpEruaMrUdcECBBw2mURXbAFnFAKSDMlH4+MZ1AnsUVhtCqqU1K4fh7JWTYtZE+clPmB7415sb++V0vZ4lqDmbSTzfwvnbvT4vd8nAQYs1qeAEwrnzHp84TxrXS/uFKe0wxMU7vPuVpj+hTzpSLoOJ4NXuzMQlQ9fR+I7bxvXySeQ2n3CPG8XPIXsMo+yWaIqza1ntAjl7e3fZBVeoGY095xcaK0WZhTKLX9PPvghcsaC9YURybSilz6aMtdytb5Y6y8K/70fr4yv1SZNvzL4oNukvgwy1q/cs3jqWUyc8IumA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=clwqjdWdUAhtBXQcHLMEbNE55ae6Ky0+hzMNSeaQo7o=;
 b=TF2eig33GWDJHS6HOTqhsMw2WXuJSkWGvJ1BbJyO86lskGlibvThMlzYKMk4h6089+42O5JG1N8oFAEsclYlnaSf3D+Fev2R2XEqujs+4GadhUQ5E5wvSF/VZmdwc5hLuT+t/5IhSbOJ2C/7oW5KKaEDLeTyvGTpDadBwi+CJeU=
Received: from PH0PR10MB5593.namprd10.prod.outlook.com (2603:10b6:510:f5::16)
 by PH0PR10MB5465.namprd10.prod.outlook.com (2603:10b6:510:e7::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.16; Fri, 17 Dec
 2021 11:19:59 +0000
Received: from PH0PR10MB5593.namprd10.prod.outlook.com
 ([fe80::70e5:d105:dd10:78e8]) by PH0PR10MB5593.namprd10.prod.outlook.com
 ([fe80::70e5:d105:dd10:78e8%9]) with mapi id 15.20.4778.018; Fri, 17 Dec 2021
 11:19:59 +0000
From:   Haakon Bugge <haakon.bugge@oracle.com>
To:     Yi Zhang <yi.zhang@redhat.com>
CC:     Max Gurtovoy <mgurtovoy@nvidia.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Max Gurtovoy <maxg@mellanox.com>,
        "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>,
        OFED mailing list <linux-rdma@vger.kernel.org>
Subject: Re: [bug report] NVMe/IB: reset_controller need more than 1min
Thread-Topic: [bug report] NVMe/IB: reset_controller need more than 1min
Thread-Index: AQHXTlwn6279ZHO/kkCFpni3P9R2O6ruObmAgACvIwCAMqfBAIAAwUaAgAE5eACBCk7WAIACAyqAgAFWtwCAADA4gIAAhiiAgAEmkwCAABa1gIAA3iKAgAC264CAAOzngIAAuVCAgAA1QYCAABEqgIAA4jOAgABHuAA=
Date:   Fri, 17 Dec 2021 11:19:59 +0000
Message-ID: <4BB6D957-6C18-4E58-A622-0880007ECD9F@oracle.com>
References: <CAHj4cs8cT23z+h2i+g6o3OQqEhWnHS88JO4jNoQo0Nww-sdkYg@mail.gmail.com>
 <3c86dc88-97d9-5a71-20e1-a90279f47db5@grimberg.me>
 <CAHj4cs_3eLZd=vxRRrnBU2W4H38mqttcy0ZdSw6uw4KvbJWgeQ@mail.gmail.com>
 <CAHj4cs_VZ7C7ciKy-q51a+Gc=uce0GDKRHNmUdoGOd7KSvURpA@mail.gmail.com>
 <84208be5-a7a9-5261-398c-fa9bda3efbe3@grimberg.me>
 <CAHj4cs8dgNNE5qcX3Y4ykuTYU8z_kea6=q64Pn_2vsdodgOJZQ@mail.gmail.com>
 <CAHj4cs-aDo7DufnKazyKuZVR-1AWr5FK1LDsN=Do=CVUJ2pH3g@mail.gmail.com>
 <9f115198-bafc-be4e-1c90-06444b8a37f6@grimberg.me>
 <CAHj4cs8wBwDGhhtEPodyBdR-sCqJLYhwLhNHuPDm+KCan0hwWg@mail.gmail.com>
 <42ccd095-b552-32f7-96b0-d34d46f7c83e@grimberg.me>
 <CAHj4cs9EazUmtbjPKp5TXO4kRPcSShiYbhmsHwfh7SOTQAeoyw@mail.gmail.com>
 <c6d43a10-44bc-e73a-8836-d75367df049b@grimberg.me>
 <162ec7c5-9483-3f53-bd1c-502ff5ac9f87@nvidia.com>
 <CAHj4cs_kCorBjHcvamhZLBNXP2zWE0n_e-3wLwb-ERfpJWJxUA@mail.gmail.com>
 <3292547e-2453-0320-c2e7-e17dbc20bbdd@nvidia.com>
 <CAHj4cs9QuANriWeLrhDvkahnNzHp-4WNFoxtWi2qGH9V0L3+Rw@mail.gmail.com>
 <fcad6dac-6d40-98d7-93e2-bfa307e8e101@nvidia.com>
 <CAHj4cs_WGP9q10d9GSzKQZi3uZCF+S8qW1sirWZWkkHuepgYgQ@mail.gmail.com>
 <2D31D2FB-BC4B-476A-9717-C02E84542DFA@oracle.com>
 <CAHj4cs-yt1+Lufqgwira-YbB6PHtJ=2JA_Vora_CfarzSzoFrA@mail.gmail.com>
In-Reply-To: <CAHj4cs-yt1+Lufqgwira-YbB6PHtJ=2JA_Vora_CfarzSzoFrA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3693.20.0.1.32)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9155e415-39f2-426b-0f47-08d9c14f2973
x-ms-traffictypediagnostic: PH0PR10MB5465:EE_
x-microsoft-antispam-prvs: <PH0PR10MB5465022C147EEDE2FD4AAAF3FD789@PH0PR10MB5465.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /B5DNQNkkk40j8u6mvF8WG6yiky2ozjarlkCb0HYw/e0+Jsk7Ht5NWJPyULdtpdywoccKbAdJAKrqbw3l6CNTrWjiTeOYzxmGGjJiY+KL+Qw8OuEsJ+y94Gr44zqsX7HhC9TRoWg7rb2vEU2w77wVn00fV9y+ovIBEFYFtW+NhSu0jr7Wos0kPpZcJysI/LMD0oBLR5oPBNYB6glwuQ5SyikQcU/bUKxPqZOShVsk09Bb+d//Cfs/wV2j9y3tlFEQE6IZCUEdLWmxY/7Ek8CIedHNNybv3367DpU8nSZ2l1RDpIAMlH1u4I5DBRJOLr2zcZpxL77TP9OT+pxy/jSF938eiFTG75fnN8zNpqSYEzJsMjLmBCm9PEmHEF3ZmroMWfC5ygIlIRuF4DsDiA2fNfSobRaboyVlNl4dKiRR4/TBrbeKE2HogQMM5AuuPUi5eKjqwEKa3jBoWpuX03XhfGH9nvhBhornIlsWU2JblWihwn5PB9GE/9ZpocXGK3vPY7miUQFLwA28OBvIB37jaqa6wa3HskfEiNI1E2loirj2yalftYK2nObprMkxrPM0cu0w+9bRvKUjozdl4ghalYyf/ZNjrdjgIDUQosaq2jK2DRVyHGqIb90OHv8khaC/39X7hrpoeV3mCPrvKMhxgCITu2tGvTmLCLjZSzIplpZykt/Xa/8ea3J6aWGIw/EpBnU7cm4hb2wXpOzUzY8ksTbuEcxCG1N7NRdT5EY0fN79GM/24TZe1UqmaxbdLOf
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5593.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(38100700002)(91956017)(66476007)(66556008)(64756008)(76116006)(5660300002)(44832011)(6506007)(4326008)(6916009)(66946007)(53546011)(2616005)(71200400001)(6486002)(33656002)(36756003)(508600001)(6512007)(2906002)(66574015)(8676002)(8936002)(26005)(66446008)(38070700005)(186003)(86362001)(316002)(54906003)(122000001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UGx5a09EYVBZRXNVN29ZWWNBNXk3NWVwNEh4S0p3SEJLNFQrTEJPd3Z1SDcz?=
 =?utf-8?B?ejVURGxYTHc4cHVLcGxEZGFIa0ZzWHhVOUk1dSs1MHRPV0U4dWl2S1NQQVJv?=
 =?utf-8?B?Zlpoa25nYzBOWEkzQkZLMlI0Tk9sTmtmS3M0R3NGTVByS0VxZXV3Ym1pSlYr?=
 =?utf-8?B?dVV0VVVyM2lFa1FJSXU1aThrdXA1UGxxVEhCQ0lMaXBlQzJqcUNxUUNvdHh4?=
 =?utf-8?B?NGUyaXRYYkVhbFRyejBIbHFQcnFSMEc0UXNyOWpJNHRSOEpyQm5UaEl0OTY0?=
 =?utf-8?B?VEluL0FkMGoyVFVtdzFDaUQ4aGFJaWZHVHA3YmVWeW9Nd1Q1MzNtdVFVYjBU?=
 =?utf-8?B?RThHV04rNVNLYjg5MmVuVnJ1S202MUxPZUZCU0k5Tzk0VjhDMWViYkY0NDlL?=
 =?utf-8?B?K0h5Rk9SYTRWN3M5Z0tTamh5dWJ6SzlER004YVFXeEYxWWkwd3NPYUgzMW90?=
 =?utf-8?B?MVdsbzJtTDZEWmtLWmpiZVhVWUNFcWE2OHU2SnVzYU9ZRFB4d3l4WFppTy9Q?=
 =?utf-8?B?aDVlZkJMVnNKY2sxUnV6NWhiS2VFSHpYN29RaWVPRmsrTG9hNGgvTGgxeVZ6?=
 =?utf-8?B?YmhIL1I5TE5YeC9XWHZQRlF2S1M2RUdtZkFhRVNSeStUKzF6eHBMMnlxWWov?=
 =?utf-8?B?c0hkclZLRDdMT3VFd0M2VVg3L0tLSzJ3SFpLT0tWM0Z6UVM0K05wdVVrb3Rn?=
 =?utf-8?B?aUkrSnZ5MGl3T1lJaWZLRFFwMDNjQ00vM09kVFM1OEpkK1VPSnhSb2J1bkRx?=
 =?utf-8?B?elJjWndpSzFsRy9sS295TmlYVVpoRFMvUnBHWGZpQjZWeVlWcTF6ZXJTLzlw?=
 =?utf-8?B?ZnViMSs4a3FzNzQ1NVBiU2pCNXBKUTlWeTJsZ1Avd2lobEhSYVBWeDRzVTFK?=
 =?utf-8?B?YkZXVm54c1BNNlFzSTV3ZzRwaXZIOUtXbjVPM1NwRmdWSUovcDRuSzlVWTA5?=
 =?utf-8?B?QnpHYnlBWkY3MlpDazhZUkJRNGVBUFIxMG9Xa29YQU9aRE8wNk05dUhtVXBn?=
 =?utf-8?B?VlZpdWc5cHdZUHQ2SkU1UmVmQWJkME5HK3IxTTV6OFlDTHk0eElodjNWNTYw?=
 =?utf-8?B?NFIxNCswSEUvT0RYVlZ5MzdjUmtkakpmWUFnOHdlSzJGclpzV1k2S05FbWc4?=
 =?utf-8?B?OUF0T0F6Q1A4bUI1YThWRzBRYUFnVHJNWGtOWXBRMjFNQTZaeFFJdmw1YjFy?=
 =?utf-8?B?TWZYQmdHZXIzMG1hclBoc1hWVFpRc1VQUi9ZS3J1UkdJQVdEcGp5MDhSZ1pG?=
 =?utf-8?B?WTd6YW5NT3JZZEVqME9VazFaQ2ZyTk43bGJvbEMyTVd2eFFXNDdqMDlRTGhy?=
 =?utf-8?B?OFQwVzBwQ2pZOVlBWUthQ2xabU5EYnRWL2d1MjNGR1pFMHhJaFFVSmtyR0ZS?=
 =?utf-8?B?THZac3lVaUxNTzZWWXZscW5HUnZ4K2NCQ1pYeG9YazVsQUhQSzBSQk1BTjNL?=
 =?utf-8?B?YVRzbUVsdkNxeGQ3d3hSNjNNN2ZBZVF3L1lYRXRtTjdrcXhYU3NQNytBZ1VS?=
 =?utf-8?B?TmR0Rit5LzJmWnJzOC9salV6a2VYTE1KbFFUbzJGOGh5MzBLbHJGOGhsTEty?=
 =?utf-8?B?WXVVSGk0N3FFYjdPaCtxeHlQem05TS9SUUZaMEJ1cGVXOC9pNmJ6VDFVTkZK?=
 =?utf-8?B?c3hDNDlSUlRTbUt2Y0xpdTM4b0xxU2Frc01jVjF3VjhPK0gxdHp5MU4vTU9a?=
 =?utf-8?B?RW1hSzZVVk9TYzlxbG1XcGptYklmVFp2SEN5YjVUbkRkQ09sYTVXOWNqNlJ5?=
 =?utf-8?B?VmFsRWNnR2dIZDJ6MzNNamRjRlpadjdBN2NvcGJ4aWU1TGw0U2J3SEVjUWVy?=
 =?utf-8?B?TmRISlM3U3lvYWd3dk1JRGdUSXJRTk5Uem9sUHRkaEFjU0Y0UndoS1lWRWRX?=
 =?utf-8?B?c2JTU1NoVzBuMC9sTm5vQ2VJZHhKeG9zUm1mOFh5VSs0dVBMV2dRWmUyNFBN?=
 =?utf-8?B?djJ6TVhFdFNYTmxlQ1FieFlnTlBxSEFydXdvNnNZMWRoYzlpd1FmWHRRRlAx?=
 =?utf-8?B?VEFXa09DWVA1d1UzbjZHeTh0N092a1EwdjYzRSt1QzBZVG42Y3ZNL0F3QW1R?=
 =?utf-8?B?TGlkZDIxdnI1TldnWVFKdjFPeldDbnRFcWFSb1JaNnhMcGpRZHpkS2h3M0FZ?=
 =?utf-8?B?MnIyUWJPV1RkMStYc2l2NExHN0tEdkJHMi9lNnpNYUYxVWZnN3RtOFgzWjZk?=
 =?utf-8?Q?gZXFEyU1fgw5U2xuAdWhWKw=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <97192C1FBA4B694B9D6534C3EC2EFDAF@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5593.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9155e415-39f2-426b-0f47-08d9c14f2973
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Dec 2021 11:19:59.0265
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aGQ8Cf4pNlCk9gG2PbEyTMGsuZk0lq/4DNLPICzl0pZra6rwSU4rD9YOiCXWu/XSl2ZDETkDZ00zuXDkhhUpDA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5465
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10200 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 spamscore=0
 mlxlogscore=999 suspectscore=0 adultscore=0 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2112170065
X-Proofpoint-ORIG-GUID: uqLdnwJvRzAyrKMY8K9nLsxkDGnWMpvx
X-Proofpoint-GUID: uqLdnwJvRzAyrKMY8K9nLsxkDGnWMpvx
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

DQoNCj4gT24gMTcgRGVjIDIwMjEsIGF0IDA4OjAzLCBZaSBaaGFuZyA8eWkuemhhbmdAcmVkaGF0
LmNvbT4gd3JvdGU6DQo+IA0KPiBPbiBGcmksIERlYyAxNywgMjAyMSBhdCAxOjM0IEFNIEhhYWtv
biBCdWdnZSA8aGFha29uLmJ1Z2dlQG9yYWNsZS5jb20+IHdyb3RlOg0KPj4gDQo+PiANCj4+IA0K
Pj4+IE9uIDE2IERlYyAyMDIxLCBhdCAxNzozMiwgWWkgWmhhbmcgPHlpLnpoYW5nQHJlZGhhdC5j
b20+IHdyb3RlOg0KPj4+IA0KPj4+IE9uIFRodSwgRGVjIDE2LCAyMDIxIGF0IDk6MjEgUE0gTWF4
IEd1cnRvdm95IDxtZ3VydG92b3lAbnZpZGlhLmNvbT4gd3JvdGU6DQo+Pj4+IA0KPj4+PiANCj4+
Pj4gT24gMTIvMTYvMjAyMSA0OjE4IEFNLCBZaSBaaGFuZyB3cm90ZToNCj4+Pj4+IE9uIFdlZCwg
RGVjIDE1LCAyMDIxIGF0IDg6MTAgUE0gTWF4IEd1cnRvdm95IDxtZ3VydG92b3lAbnZpZGlhLmNv
bT4gd3JvdGU6DQo+Pj4+Pj4gDQo+Pj4+Pj4gT24gMTIvMTUvMjAyMSAzOjE1IEFNLCBZaSBaaGFu
ZyB3cm90ZToNCj4+Pj4+Pj4gT24gVHVlLCBEZWMgMTQsIDIwMjEgYXQgODowMSBQTSBNYXggR3Vy
dG92b3kgPG1ndXJ0b3ZveUBudmlkaWEuY29tPiB3cm90ZToNCj4+Pj4+Pj4+IE9uIDEyLzE0LzIw
MjEgMTI6MzkgUE0sIFNhZ2kgR3JpbWJlcmcgd3JvdGU6DQo+Pj4+Pj4+Pj4+Pj4gSGkgU2FnaQ0K
Pj4+Pj4+Pj4+Pj4+IEl0IGlzIHN0aWxsIHJlcHJvZHVjaWJsZSB3aXRoIHRoZSBjaGFuZ2UsIGhl
cmUgaXMgdGhlIGxvZzoNCj4+Pj4+Pj4+Pj4+PiANCj4+Pj4+Pj4+Pj4+PiAjIHRpbWUgbnZtZSBy
ZXNldCAvZGV2L252bWUwDQo+Pj4+Pj4+Pj4+Pj4gDQo+Pj4+Pj4+Pj4+Pj4gcmVhbCAgICAwbTEy
Ljk3M3MNCj4+Pj4+Pj4+Pj4+PiB1c2VyICAgIDBtMC4wMDBzDQo+Pj4+Pj4+Pj4+Pj4gc3lzICAg
ICAwbTAuMDA2cw0KPj4+Pj4+Pj4+Pj4+ICMgdGltZSBudm1lIHJlc2V0IC9kZXYvbnZtZTANCj4+
Pj4+Pj4+Pj4+PiANCj4+Pj4+Pj4+Pj4+PiByZWFsICAgIDFtMTUuNjA2cw0KPj4+Pj4+Pj4+Pj4+
IHVzZXIgICAgMG0wLjAwMHMNCj4+Pj4+Pj4+Pj4+PiBzeXMgICAgIDBtMC4wMDdzDQo+Pj4+Pj4+
Pj4+PiBEb2VzIGl0IHNwZWVkIHVwIGlmIHlvdSB1c2UgbGVzcyBxdWV1ZXM/IChpLmUuIGNvbm5l
Y3Qgd2l0aCAtaSA0KSA/DQo+Pj4+Pj4+Pj4+IFllcywgd2l0aCAtaSA0LCBpdCBoYXMgc3RhYmxl
ZSAxLjNzDQo+Pj4+Pj4+Pj4+ICMgdGltZSBudm1lIHJlc2V0IC9kZXYvbnZtZTANCj4+Pj4+Pj4+
PiBTbyBpdCBhcHBlYXJzIHRoYXQgZGVzdHJveWluZyBhIHFwIHRha2VzIGEgbG9uZyB0aW1lIG9u
DQo+Pj4+Pj4+Pj4gSUIgZm9yIHNvbWUgcmVhc29uLi4uDQo+Pj4+Pj4+Pj4gDQo+Pj4+Pj4+Pj4+
IHJlYWwgMG0xLjIyNXMNCj4+Pj4+Pj4+Pj4gdXNlciAwbTAuMDAwcw0KPj4+Pj4+Pj4+PiBzeXMg
MG0wLjAwN3MNCj4+Pj4+Pj4+Pj4gDQo+Pj4+Pj4+Pj4+Pj4gIyBkbWVzZyB8IGdyZXAgbnZtZQ0K
Pj4+Pj4+Pj4+Pj4+IFsgIDkwMC42MzQ4NzddIG52bWUgbnZtZTA6IHJlc2V0dGluZyBjb250cm9s
bGVyDQo+Pj4+Pj4+Pj4+Pj4gWyAgOTA5LjAyNjk1OF0gbnZtZSBudm1lMDogY3JlYXRpbmcgNDAg
SS9PIHF1ZXVlcy4NCj4+Pj4+Pj4+Pj4+PiBbICA5MTMuNjA0Mjk3XSBudm1lIG52bWUwOiBtYXBw
ZWQgNDAvMC8wIGRlZmF1bHQvcmVhZC9wb2xsIHF1ZXVlcy4NCj4+Pj4+Pj4+Pj4+PiBbICA5MTcu
NjAwOTkzXSBudm1lIG52bWUwOiByZXNldHRpbmcgY29udHJvbGxlcg0KPj4+Pj4+Pj4+Pj4+IFsg
IDk4OC41NjIyMzBdIG52bWUgbnZtZTA6IEkvTyAyIFFJRCAwIHRpbWVvdXQNCj4+Pj4+Pj4+Pj4+
PiBbICA5ODguNTY3NjA3XSBudm1lIG52bWUwOiBQcm9wZXJ0eSBTZXQgZXJyb3I6IDg4MSwgb2Zm
c2V0IDB4MTQNCj4+Pj4+Pj4+Pj4+PiBbICA5ODguNjA4MTgxXSBudm1lIG52bWUwOiBjcmVhdGlu
ZyA0MCBJL08gcXVldWVzLg0KPj4+Pj4+Pj4+Pj4+IFsgIDk5My4yMDM0OTVdIG52bWUgbnZtZTA6
IG1hcHBlZCA0MC8wLzAgZGVmYXVsdC9yZWFkL3BvbGwgcXVldWVzLg0KPj4+Pj4+Pj4+Pj4+IA0K
Pj4+Pj4+Pj4+Pj4+IEJUVywgdGhpcyBpc3N1ZSBjYW5ub3QgYmUgcmVwcm9kdWNlZCBvbiBteSBO
Vk1FL1JPQ0UgZW52aXJvbm1lbnQuDQo+Pj4+Pj4+Pj4+PiBUaGVuIEkgdGhpbmsgdGhhdCB3ZSBu
ZWVkIHRoZSByZG1hIGZvbGtzIHRvIGhlbHAgaGVyZS4uLg0KPj4+Pj4+Pj4+IE1heD8NCj4+Pj4+
Pj4+IEl0IHRvb2sgbWUgMTJzIHRvIHJlc2V0IGEgY29udHJvbGxlciB3aXRoIDYzIElPIHF1ZXVl
cyB3aXRoIDUuMTYtcmMzKy4NCj4+Pj4+Pj4+IA0KPj4+Pj4+Pj4gQ2FuIHlvdSB0cnkgcmVwcm8g
d2l0aCBsYXRlc3QgdmVyc2lvbnMgcGxlYXNlID8NCj4+Pj4+Pj4+IA0KPj4+Pj4+Pj4gT3IgZ2l2
ZSB0aGUgZXhhY3Qgc2NlbmFyaW8gPw0KPj4+Pj4+PiBZZWFoLCBib3RoIHRhcmdldCBhbmQgY2xp
ZW50IGFyZSB1c2luZyBNZWxsYW5veCBUZWNobm9sb2dpZXMgTVQyNzcwMA0KPj4+Pj4+PiBGYW1p
bHkgW0Nvbm5lY3RYLTRdLCBjb3VsZCB5b3UgdHJ5IHN0cmVzcyAibnZtZSByZXNldCAvZGV2L252
bWUwIiwgdGhlDQo+Pj4+Pj4+IGZpcnN0IHRpbWUgcmVzZXQgd2lsbCB0YWtlIDEycywgYW5kIGl0
IGFsd2F5cyBjYW4gYmUgcmVwcm9kdWNlZCBhdCB0aGUNCj4+Pj4+Pj4gc2Vjb25kIHJlc2V0IG9w
ZXJhdGlvbi4NCj4+Pj4+PiBJIGNyZWF0ZWQgYSB0YXJnZXQgd2l0aCAxIG5hbWVzcGFjZSBiYWNr
ZWQgYnkgbnVsbF9ibGsgYW5kIGNvbm5lY3RlZCB0bw0KPj4+Pj4+IGl0IGZyb20gdGhlIHNhbWUg
c2VydmVyIGluIGxvb3BiYWNrIHJkbWEgY29ubmVjdGlvbiB1c2luZyB0aGUgQ29ubmVjdFgtNA0K
Pj4+Pj4+IGFkYXB0ZXIuDQo+Pj4+PiBDb3VsZCB5b3Ugc2hhcmUgeW91ciBsb29wLmpzb24gZmls
ZSBzbyBJIGNhbiB0cnkgaXQgb24gbXkgZW52aXJvbm1lbnQ/DQo+Pj4+IA0KPj4+PiB7DQo+Pj4+
ICAiaG9zdHMiOiBbXSwNCj4+Pj4gICJwb3J0cyI6IFsNCj4+Pj4gICAgew0KPj4+PiAgICAgICJh
ZGRyIjogew0KPj4+PiAgICAgICAgImFkcmZhbSI6ICJpcHY0IiwNCj4+Pj4gICAgICAgICJ0cmFk
ZHIiOiAiPGlwPiIsDQo+Pj4+ICAgICAgICAidHJlcSI6ICJub3Qgc3BlY2lmaWVkIiwNCj4+Pj4g
ICAgICAgICJ0cnN2Y2lkIjogIjQ0MjAiLA0KPj4+PiAgICAgICAgInRydHlwZSI6ICJyZG1hIg0K
Pj4+PiAgICAgIH0sDQo+Pj4+ICAgICAgInBvcnRpZCI6IDEsDQo+Pj4+ICAgICAgInJlZmVycmFs
cyI6IFtdLA0KPj4+PiAgICAgICJzdWJzeXN0ZW1zIjogWw0KPj4+PiAgICAgICAgInRlc3RzdWJz
eXN0ZW1fMCINCj4+Pj4gICAgICBdDQo+Pj4+ICAgIH0NCj4+Pj4gIF0sDQo+Pj4+ICAic3Vic3lz
dGVtcyI6IFsNCj4+Pj4gICAgew0KPj4+PiAgICAgICJhbGxvd2VkX2hvc3RzIjogW10sDQo+Pj4+
ICAgICAgImF0dHIiOiB7DQo+Pj4+ICAgICAgICAiYWxsb3dfYW55X2hvc3QiOiAiMSIsDQo+Pj4+
ICAgICAgICAiY250bGlkX21heCI6ICI2NTUxOSIsDQo+Pj4+ICAgICAgICAiY250bGlkX21pbiI6
ICIxIiwNCj4+Pj4gICAgICAgICJtb2RlbCI6ICJMaW51eCIsDQo+Pj4+ICAgICAgICAic2VyaWFs
IjogIjNkODNjNzhiNzY2MjNmMWQiLA0KPj4+PiAgICAgICAgInZlcnNpb24iOiAiMS4zIg0KPj4+
PiAgICAgIH0sDQo+Pj4+ICAgICAgIm5hbWVzcGFjZXMiOiBbDQo+Pj4+ICAgICAgICB7DQo+Pj4+
ICAgICAgICAgICJkZXZpY2UiOiB7DQo+Pj4+ICAgICAgICAgICAgIm5ndWlkIjogIjViNzIyYjA1
LWU5YjYtNTQyZC1iYTgwLTYyMDEwYjU3Nzc1ZCIsDQo+Pj4+ICAgICAgICAgICAgInBhdGgiOiAi
L2Rldi9udWxsYjAiLA0KPj4+PiAgICAgICAgICAgICJ1dWlkIjogIjI2ZmZjOGNlLTczYjQtMzIx
ZC05Njg1LTdkN2E5ODcyYzQ2MCINCj4+Pj4gICAgICAgICAgfSwNCj4+Pj4gICAgICAgICAgImVu
YWJsZSI6IDEsDQo+Pj4+ICAgICAgICAgICJuc2lkIjogMQ0KPj4+PiAgICAgICAgfQ0KPj4+PiAg
ICAgIF0sDQo+Pj4+ICAgICAgIm5xbiI6ICJ0ZXN0c3Vic3lzdGVtXzAiDQo+Pj4+ICAgIH0NCj4+
Pj4gIF0NCj4+Pj4gfQ0KPj4+IA0KPj4+IFRoYW5rcywgSSByZXByb2R1Y2VkIGl0IHdpdGggeW91
ciBqc29uIGZpbGUgb24gb25lIHNlcnZlciB3aXRoDQo+Pj4gbG9vcGJhY2sgcmRtYSBjb25uZWN0
aW9uOg0KPj4+ICMgdGltZSBudm1lIGNvbm5lY3QgLXQgcmRtYSAtYSAxNzIuMzEuMC4yMDIgLXMg
NDQyMCAtbiB0ZXN0c3Vic3lzdGVtXzANCj4+PiANCj4+PiByZWFsIDBtNC41NTdzDQo+Pj4gdXNl
ciAwbTAuMDAwcw0KPj4+IHN5cyAwbTAuMDA1cw0KPj4+ICMgdGltZSBudm1lIHJlc2V0IC9kZXYv
bnZtZTANCj4+PiANCj4+PiByZWFsIDBtMTMuMTc2cw0KPj4+IHVzZXIgMG0wLjAwMHMNCj4+PiBz
eXMgMG0wLjAwN3MNCj4+PiAjIHRpbWUgbnZtZSByZXNldCAvZGV2L252bWUwDQo+Pj4gDQo+Pj4g
cmVhbCAxbTE2LjU3N3MNCj4+PiB1c2VyIDBtMC4wMDJzDQo+Pj4gc3lzIDBtMC4wMDVzDQo+Pj4g
IyB0aW1lIG52bWUgZGlzY29ubmVjdCAtbiB0ZXN0c3Vic3lzdGVtXzANCj4+IA0KPj4gV2hhdCBk
b2VzOg0KPj4gDQo+PiAjIHJkbWEgcmVzIHNob3cgcXAgfCBncmVwIC1jIEVSUg0KPj4gDQo+PiBz
YXksIHdoZW4gaXQgaXMgc2xvdz8NCj4gDQo+IEhpIEhhYWtvbg0KPiBIZXJlIGlzIHRoZSBvdXRw
dXQgZHVyaW5nIHRoZSByZXNldCBvcGVyYXRpb246DQo+IA0KPiAzOA0KPiAzMw0KPiAyOA0KPiAy
NA0KPiAxOQ0KPiAxNA0KPiA5DQo+IDQNCj4gMA0KPiAwDQo+IDANCj4gMA0KPiAwDQo+IDANCj4g
MA0KPiAwDQo+IDANCj4gMA0KPiAwDQo+IDANCj4gMA0KPiAwDQo+IDANCj4gMA0KPiAwDQo+IDAN
Cj4gMA0KPiAwDQo+IDANCj4gMA0KPiAwDQo+IDANCj4gMA0KPiAwDQo+IDANCj4gMA0KPiAwDQo+
IDANCj4gMA0KPiAwDQo+IDANCj4gMQ0KPiAxDQo+IDENCj4gMQ0KPiAxDQo+IDENCj4gMQ0KPiAx
DQo+IDENCj4gMQ0KPiAxDQo+IDENCj4gMQ0KPiAxDQo+IDENCj4gMQ0KPiAxDQo+IDENCj4gMQ0K
PiAxDQo+IDENCj4gMQ0KPiAxDQo+IDENCj4gMQ0KPiAxDQo+IDENCj4gMQ0KPiAwDQo+IDANCj4g
MA0KDQoNCk9LLiBJIGhhZCBhIGh1bmNoIHRoYXQgbWFueSBRUHMgaW4gdGhlIEVSUiBzdGF0ZSBj
b3VsZCBiZSB0aGUgcmVhc29uLiBCdXQgdGhpcyBpcyBub3QgbWFueSwgc28gSSByZXN0IG15IGNh
c2UgOi0pIFRoYW5rcyBmb3IgdHJ5aW5nIHRob3VnaCENCg0KDQpUaHhzLCBIw6Vrb24NCg0KPiAN
Cj4+IA0KPj4gDQo+PiANCj4+IFRoeHMsIEjDpWtvbg0KPj4gDQo+IA0KPiANCj4gDQo+IC0tIA0K
PiBCZXN0IFJlZ2FyZHMsDQo+ICBZaSBaaGFuZw0KDQo=
