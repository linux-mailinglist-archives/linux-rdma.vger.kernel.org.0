Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09EC3477AAD
	for <lists+linux-rdma@lfdr.de>; Thu, 16 Dec 2021 18:34:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240270AbhLPReF (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 16 Dec 2021 12:34:05 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:21602 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240166AbhLPReF (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 16 Dec 2021 12:34:05 -0500
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1BGHVOEf015595;
        Thu, 16 Dec 2021 17:33:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=XbFCVEduuQkjB2FW0C4XjWyIA58GfQtS+/7fCaUQtU8=;
 b=QSfNtyFpbE9yhB4XdAowVA2r0ZvufqRl5cHocqPdet4oX5ZrXTDxBoZF4OB451Nu8R0x
 miCnjR7bqo0h5GTkZcMw5Mr17YSTOJsNMsL/AGQolLDGneQzqeIf9zWorzPHNvrsez88
 WtdoSyHUKiMJF4hn6t4Jpt/5OYkdLBqibADEaKcqfrHP1cZ3n0WsLQEPL58u/n3dVukU
 BQr+8ysFM642qtj6j4el6vM3qg47zD5iaK1MZ9zgIRTkJrEngZO2MdXF0hXfbMto7VET
 QWshA0rjrty60DKGXur+L7RMM9tBKqdWXQ+8NTmhIjkx9hoHk6HoTpHbUErb3D7zd81f 6Q== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cykmbkhf1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 16 Dec 2021 17:33:45 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1BGHUh4S043199;
        Thu, 16 Dec 2021 17:33:44 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2104.outbound.protection.outlook.com [104.47.55.104])
        by userp3030.oracle.com with ESMTP id 3cvh42c3hb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 16 Dec 2021 17:33:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PofBWxGHmtp/DiqB1wuT1eCazAF8WWQ2TlCHpO9xiKOau4VhS/dvJRW3y4eao9UI1qsLLtvSD65Cf4jebi/hUrRl5sqB2SviKP1gDNJt5RZrtrUjroyzkvhAi7sNxq9CxXmuR9n9KHeoiSyaRDnumlztg9GMgo6y4BCJfJPjKv8ceVZfn2Dw4nr9uPy8kN2GxhP6EqpJW7n/G6B0IKXcRc9SkpcYA9kyMjOdnsKT6pPJPVVhsVvQXNKKiqbLj+JlqthgZJU1b/ffjQ/4DBuzH0IQwgEYOKnuHdeOGJVGgmw3FqN7LtyemZp8KWR8ScBniaWbvByAwh1nLStzVIvD2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XbFCVEduuQkjB2FW0C4XjWyIA58GfQtS+/7fCaUQtU8=;
 b=lJ80wuMdKoqRjpE45oIVYRcqIGmes2lxKacRu/mk64gzBBNN8ciSEp9yAuVU461n1pdyR7Ucp/E1rD+IkFoVsKqkcLea/hfSlHMWJAZOsfVQAnX+36JeQGfTpkC2gH6TdaPlW/2zAVHT2penac10KS9ZpJz0zkUw2RK/GTaXhAuBxWppaFSa03p5zw4r6WWmdDPrxSCRlhZ7yMUpUUsvFNcKlz93kUyvxgEqH0Ehosg5P+//nGUuHy7d2UdtbF0YDXnqrw/yX7cMVVoDJae0ZzD36jQze16ni6BM4mDu2lfw5L8lZTxlBi7/ET5rpxbPF8+V9f1XoQgQ6ogOcRfQjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XbFCVEduuQkjB2FW0C4XjWyIA58GfQtS+/7fCaUQtU8=;
 b=MpOrucGMd+Gegqok+eT59+ak0Y3iV+XzbrJ2L00teoHkxjdvNaU+qspEethGFtnwyZZt3/pkH4coXPvdi5HNjYLURL4Qu9bBREszMBPWeXyKwnc+eAx4q7M2HaopDLUJd9wtDKrfyU/Qk/gNvRfESh7ppjBDhiHOqJXVrZTVJE0=
Received: from PH0PR10MB5593.namprd10.prod.outlook.com (2603:10b6:510:f5::16)
 by PH0PR10MB4584.namprd10.prod.outlook.com (2603:10b6:510:37::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.14; Thu, 16 Dec
 2021 17:33:42 +0000
Received: from PH0PR10MB5593.namprd10.prod.outlook.com
 ([fe80::70e5:d105:dd10:78e8]) by PH0PR10MB5593.namprd10.prod.outlook.com
 ([fe80::70e5:d105:dd10:78e8%9]) with mapi id 15.20.4778.018; Thu, 16 Dec 2021
 17:33:42 +0000
From:   Haakon Bugge <haakon.bugge@oracle.com>
To:     Yi Zhang <yi.zhang@redhat.com>
CC:     Max Gurtovoy <mgurtovoy@nvidia.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Max Gurtovoy <maxg@mellanox.com>,
        "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>,
        OFED mailing list <linux-rdma@vger.kernel.org>
Subject: Re: [bug report] NVMe/IB: reset_controller need more than 1min
Thread-Topic: [bug report] NVMe/IB: reset_controller need more than 1min
Thread-Index: AQHXTlwn6279ZHO/kkCFpni3P9R2O6ruObmAgACvIwCAMqfBAIAAwUaAgAE5eACBCk7WAIACAyqAgAFWtwCAADA4gIAAhiiAgAEmkwCAABa1gIAA3iKAgAC264CAAOzngIAAuVCAgAA1QYCAABEqgA==
Date:   Thu, 16 Dec 2021 17:33:42 +0000
Message-ID: <2D31D2FB-BC4B-476A-9717-C02E84542DFA@oracle.com>
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
In-Reply-To: <CAHj4cs_WGP9q10d9GSzKQZi3uZCF+S8qW1sirWZWkkHuepgYgQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3693.20.0.1.32)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2e6b6ea8-3939-46e7-9605-08d9c0ba3451
x-ms-traffictypediagnostic: PH0PR10MB4584:EE_
x-microsoft-antispam-prvs: <PH0PR10MB458489D2D09ECA61FFF6ECDDFD779@PH0PR10MB4584.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2887;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZPFPe5viS76Z5KWzL9E9DdGoYn6j/xRah2xod2oqUs0H81CrhdhQVaQP48/IguCzlM4ldLmKOHfz0wRznfm/o/zdGG6xVvs0pDHxIpmGRiiTmMnSnoIo+GUoa6nMaHGhoIqfFDhgJFSI2x5ZoZ1QPrdzkAx0g1BOaJvct7mNfpwzC9e5hHrSU0DkNEWkfxQoZc2GsryILOhoDQoyB5p/pKisHrXBfHDu9W7a+IJaWkzg8BmBcinszTNcO58YtQZwBd9BljJXsJ6iqzvecNyHScpO6Cq1or3qAg+mwsExjrWctKhDM+nt28/terXPE/kJx8Ia4z6I8+HeRvHg0pCPciD3jhVFbSQWmEmMEhvIMxEjXkYJGpZxrgmh7XWITTwhVE3Z+3oFQTuX3y+l5voDxqooXuvwDcgJmWMxz8gGF54zdwdcoiPqvtYHIzMbHt4EGCqTiTyXrUzRpEzwrQYmQvM/+H7LLmbCkAAbWb9HhhLpt5WSRWPg1lqXPPp3uVc7h5bhXKpYxsM4drnJ/RP+FwZ/CNSAzb0PlT5MVHmp/dyT2GZ4Oitv9WK62w+fI0+XttRnd/+sxkrUAWskmGouY4emNZBq2QDUmGvBCTZN0FfXcEjqwfp2me19cchqxIp7fmvYlUY41KNkonq46+nNmpibhl0J6ZV83HGHOU627ztDGKLrozPVhjAsJI3snV7Zc01V0jNTcN3gJs2QDwtLuHHYnqR6IcRJ5HEktXKBVPAUXZXWME6No+khonvFhGmw
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5593.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(8676002)(76116006)(8936002)(508600001)(44832011)(6506007)(5660300002)(6486002)(53546011)(91956017)(66574015)(6916009)(4326008)(2906002)(86362001)(36756003)(2616005)(64756008)(71200400001)(66946007)(66556008)(66476007)(26005)(316002)(54906003)(66446008)(33656002)(6512007)(38100700002)(122000001)(38070700005)(186003)(83380400001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NHVuRHNjSWRXZXlWNXZ4dEx1S3BPQ2FUNGpQU0d0cGFqbVltbm1Vc3JVYW9J?=
 =?utf-8?B?Mjlpay91Q24rYVZ0QklSSVdENkt2amJEaVFuRXBuanRCSjl3K0N6KzFVMG5J?=
 =?utf-8?B?Tk1sOFhDTTVvWFJoQUQ2alQ5NitaR2dsdFNndGQ1NmxDME1OYVFCcTNRTGJv?=
 =?utf-8?B?cjh2MjgvSjl5dWFCa2U0Z2h5eXQwb0Z3L2ZHdjJOb0R4ODVrSHhoT1psbGNj?=
 =?utf-8?B?TXg3cHZCUkZEYXh3MXlMN0s1Nnlqa2ZMR3RFbXkxSHVrSFNzWW9iTkM4amVn?=
 =?utf-8?B?UTkzd2ROUWROK2k3UWxoTlpyR1ppaGhsOVlnNTVxVkgvejBtR0ZmbVhLdkZJ?=
 =?utf-8?B?ZXpyRWp3MEh2eDZIOS9FVTA3bzA5NkIxTTI0dkNPNURQNWlpRTl1bEtrVHIx?=
 =?utf-8?B?dFBXS0cwb254TStocE0xaUxjR2pZS1RPNVo1Q1B2di9taXowZ281UzA2V014?=
 =?utf-8?B?WWtSRnRESjFkVU8yZDRacGFSMjNyOEpJZHZYdEN2WVBZbm1TSTJZbUVKRG1S?=
 =?utf-8?B?ckpYakx4MTd3cEdmenA4eXd2OFdpTGdDYUcrS1k2WTZHN0ZxRy8rNnRiSm5x?=
 =?utf-8?B?S2drVkJ6WDc2TVNTVzlJVWJEQmU4VlB1eUg3czJJWXdYMjUwYWhpRTgrSXBS?=
 =?utf-8?B?a3Q4WEFQbFhaZ09DMUwxY01TWHhwendLVXJCTFRHMlJOZGJ3MU5Ebkl3WkhN?=
 =?utf-8?B?VEtWYS9KNzE3aGdQNWw2bWorYXhUY1ZKTE9OVHRzVW5WZzlLMnV1NUR3Y2VH?=
 =?utf-8?B?cUo5UEt2eXE0RWVyWW12WUpnY3J4UDMxUlNQY0twSmJQNFhmd0ZGZllBTitk?=
 =?utf-8?B?K1pPV0lFQzlabmF6R3BZa1ViWWdld0x4YU80ZVp1TjAvZWQ1dmdKSnNlb04y?=
 =?utf-8?B?WjVkbWFwb29CS2o1cDJMbGVPVDh3djhwQW9td3VPcURlQldBc2VucDIxN1FQ?=
 =?utf-8?B?NUZJZ1lmUWlMZzVDeExidGZyWDFtWVhQRkE3WitGQXhnK0dEWTBpVjBWSzk4?=
 =?utf-8?B?dW5mTm9HL1cxeWM5d2hsZkhCZjgyYlhUSGVwNFlrSGQ2U2Y1VVJjZEVtVXRo?=
 =?utf-8?B?em5KZ0lMMGc2L3U5dTJYZER0Zkk5OCtzTnRaVlV0Nmo2Wktvc2lyOThEN0tT?=
 =?utf-8?B?MGpoam0wVnF6QWRHOGZVeGtzY1BKSjNTQkhsazF1VTRaenFlTkJqZndKeHpQ?=
 =?utf-8?B?dVF2Y0VEdlJvV1RlZCt0R2dvcmJ1dWhwWktsc3NhaEExSys4R3NZM1kyY2Ew?=
 =?utf-8?B?Z3ViY1YvYkF4cEoxbWs2bFllRWxiYUtsbkNOeCt6aHYwVWZzbGxtdXlmRXY2?=
 =?utf-8?B?YjM0UTBsZ3YwRFFrcEpGd0I4b0wrTHZXelEyU1RQbXlrZlE3aVhDTFB6M0px?=
 =?utf-8?B?UklXUVpwZm1XVWlMNkxva24xOWU1TVlEeTcvMklwQWlXME91Q2ZtTW1wWm52?=
 =?utf-8?B?Mm1NclYvMzF3M3NqSUw2MWdpWXY3bDYwVTlvTTNwYlQ2NCt0YTEvalhRa0lx?=
 =?utf-8?B?RkQzTzdITDZaWHhmelhxSWVBRytIMnhSYmI3ZitweUs2U3JzdnMyUHgxL05K?=
 =?utf-8?B?VkE2ZUdHOE5xdWgyNmVuaVM2b1hCNHZITlQ5S2xiVFI5dlFDY3RaMHNrVG9W?=
 =?utf-8?B?N3JCTVI4UFBTU3o3TjIyeWxHWTdITW1LOGlWV3IzMU5RTXR3SWcvZEtaRCtP?=
 =?utf-8?B?bGNxNVB2aHN4VGxtVWNUUjNDcUtjMHhKdCsvbVZnSnM2aU9MOEhJNnBnbG8z?=
 =?utf-8?B?UUdVL1d3T0NOTU10ZG11SEdTdUd1T0xaVytJWnhHSDB0WW1vTmZxNm0wTHBt?=
 =?utf-8?B?cU9odjFVaEpWclR4VjZsNTVlV2E0Wjgvd1B4T3ZKQmRPeU05YUM5by9KSjEr?=
 =?utf-8?B?c0ZsNWNka2ZjckJjU1FiNXgrRWpENHFoZm4vNTJkRUFIWUp6S3hrdHBLNFd6?=
 =?utf-8?B?YzV0TitTWDd5M0NRRTlmcStkMmFwOEszWUtHS0lHTll0ZlVBUmhSNXpjMksx?=
 =?utf-8?B?WGc4RTNxTG1TOXhBemRoRTVtNGlkWnhibzB2RGhmSTk2UmROYlU4YjRhMVpx?=
 =?utf-8?B?eGxnNUY5MkpweG5FeTNEL3ZNOFFVTlZORWVEVzZkd1daa2gyWU1IN2R5TVlq?=
 =?utf-8?B?OTM5MU94cklwVEFxSXphRFE1QkljWmNEcVJvS21IS1puT09YV1FaaVJQYVBi?=
 =?utf-8?Q?8bmXmk4UDaXVsS09fgajEW4=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C46988A62B34C848ACA228476BA5F484@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5593.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e6b6ea8-3939-46e7-9605-08d9c0ba3451
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Dec 2021 17:33:42.2434
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2pQe0T728c3uTW2Pl/e/MYCxIxz4vCym3BrFY2x9lwSNDiIAB0hKH+qcmZGKmi/drASvSMxpS7icPhM/3N0hPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4584
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10199 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 suspectscore=0
 malwarescore=0 mlxlogscore=999 bulkscore=0 mlxscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2112160098
X-Proofpoint-ORIG-GUID: rGDXreCS8qUHzFpiOGBRhblUXiNtQekd
X-Proofpoint-GUID: rGDXreCS8qUHzFpiOGBRhblUXiNtQekd
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

DQoNCj4gT24gMTYgRGVjIDIwMjEsIGF0IDE3OjMyLCBZaSBaaGFuZyA8eWkuemhhbmdAcmVkaGF0
LmNvbT4gd3JvdGU6DQo+IA0KPiBPbiBUaHUsIERlYyAxNiwgMjAyMSBhdCA5OjIxIFBNIE1heCBH
dXJ0b3ZveSA8bWd1cnRvdm95QG52aWRpYS5jb20+IHdyb3RlOg0KPj4gDQo+PiANCj4+IE9uIDEy
LzE2LzIwMjEgNDoxOCBBTSwgWWkgWmhhbmcgd3JvdGU6DQo+Pj4gT24gV2VkLCBEZWMgMTUsIDIw
MjEgYXQgODoxMCBQTSBNYXggR3VydG92b3kgPG1ndXJ0b3ZveUBudmlkaWEuY29tPiB3cm90ZToN
Cj4+Pj4gDQo+Pj4+IE9uIDEyLzE1LzIwMjEgMzoxNSBBTSwgWWkgWmhhbmcgd3JvdGU6DQo+Pj4+
PiBPbiBUdWUsIERlYyAxNCwgMjAyMSBhdCA4OjAxIFBNIE1heCBHdXJ0b3ZveSA8bWd1cnRvdm95
QG52aWRpYS5jb20+IHdyb3RlOg0KPj4+Pj4+IE9uIDEyLzE0LzIwMjEgMTI6MzkgUE0sIFNhZ2kg
R3JpbWJlcmcgd3JvdGU6DQo+Pj4+Pj4+Pj4+IEhpIFNhZ2kNCj4+Pj4+Pj4+Pj4gSXQgaXMgc3Rp
bGwgcmVwcm9kdWNpYmxlIHdpdGggdGhlIGNoYW5nZSwgaGVyZSBpcyB0aGUgbG9nOg0KPj4+Pj4+
Pj4+PiANCj4+Pj4+Pj4+Pj4gIyB0aW1lIG52bWUgcmVzZXQgL2Rldi9udm1lMA0KPj4+Pj4+Pj4+
PiANCj4+Pj4+Pj4+Pj4gcmVhbCAgICAwbTEyLjk3M3MNCj4+Pj4+Pj4+Pj4gdXNlciAgICAwbTAu
MDAwcw0KPj4+Pj4+Pj4+PiBzeXMgICAgIDBtMC4wMDZzDQo+Pj4+Pj4+Pj4+ICMgdGltZSBudm1l
IHJlc2V0IC9kZXYvbnZtZTANCj4+Pj4+Pj4+Pj4gDQo+Pj4+Pj4+Pj4+IHJlYWwgICAgMW0xNS42
MDZzDQo+Pj4+Pj4+Pj4+IHVzZXIgICAgMG0wLjAwMHMNCj4+Pj4+Pj4+Pj4gc3lzICAgICAwbTAu
MDA3cw0KPj4+Pj4+Pj4+IERvZXMgaXQgc3BlZWQgdXAgaWYgeW91IHVzZSBsZXNzIHF1ZXVlcz8g
KGkuZS4gY29ubmVjdCB3aXRoIC1pIDQpID8NCj4+Pj4+Pj4+IFllcywgd2l0aCAtaSA0LCBpdCBo
YXMgc3RhYmxlZSAxLjNzDQo+Pj4+Pj4+PiAjIHRpbWUgbnZtZSByZXNldCAvZGV2L252bWUwDQo+
Pj4+Pj4+IFNvIGl0IGFwcGVhcnMgdGhhdCBkZXN0cm95aW5nIGEgcXAgdGFrZXMgYSBsb25nIHRp
bWUgb24NCj4+Pj4+Pj4gSUIgZm9yIHNvbWUgcmVhc29uLi4uDQo+Pj4+Pj4+IA0KPj4+Pj4+Pj4g
cmVhbCAwbTEuMjI1cw0KPj4+Pj4+Pj4gdXNlciAwbTAuMDAwcw0KPj4+Pj4+Pj4gc3lzIDBtMC4w
MDdzDQo+Pj4+Pj4+PiANCj4+Pj4+Pj4+Pj4gIyBkbWVzZyB8IGdyZXAgbnZtZQ0KPj4+Pj4+Pj4+
PiBbICA5MDAuNjM0ODc3XSBudm1lIG52bWUwOiByZXNldHRpbmcgY29udHJvbGxlcg0KPj4+Pj4+
Pj4+PiBbICA5MDkuMDI2OTU4XSBudm1lIG52bWUwOiBjcmVhdGluZyA0MCBJL08gcXVldWVzLg0K
Pj4+Pj4+Pj4+PiBbICA5MTMuNjA0Mjk3XSBudm1lIG52bWUwOiBtYXBwZWQgNDAvMC8wIGRlZmF1
bHQvcmVhZC9wb2xsIHF1ZXVlcy4NCj4+Pj4+Pj4+Pj4gWyAgOTE3LjYwMDk5M10gbnZtZSBudm1l
MDogcmVzZXR0aW5nIGNvbnRyb2xsZXINCj4+Pj4+Pj4+Pj4gWyAgOTg4LjU2MjIzMF0gbnZtZSBu
dm1lMDogSS9PIDIgUUlEIDAgdGltZW91dA0KPj4+Pj4+Pj4+PiBbICA5ODguNTY3NjA3XSBudm1l
IG52bWUwOiBQcm9wZXJ0eSBTZXQgZXJyb3I6IDg4MSwgb2Zmc2V0IDB4MTQNCj4+Pj4+Pj4+Pj4g
WyAgOTg4LjYwODE4MV0gbnZtZSBudm1lMDogY3JlYXRpbmcgNDAgSS9PIHF1ZXVlcy4NCj4+Pj4+
Pj4+Pj4gWyAgOTkzLjIwMzQ5NV0gbnZtZSBudm1lMDogbWFwcGVkIDQwLzAvMCBkZWZhdWx0L3Jl
YWQvcG9sbCBxdWV1ZXMuDQo+Pj4+Pj4+Pj4+IA0KPj4+Pj4+Pj4+PiBCVFcsIHRoaXMgaXNzdWUg
Y2Fubm90IGJlIHJlcHJvZHVjZWQgb24gbXkgTlZNRS9ST0NFIGVudmlyb25tZW50Lg0KPj4+Pj4+
Pj4+IFRoZW4gSSB0aGluayB0aGF0IHdlIG5lZWQgdGhlIHJkbWEgZm9sa3MgdG8gaGVscCBoZXJl
Li4uDQo+Pj4+Pj4+IE1heD8NCj4+Pj4+PiBJdCB0b29rIG1lIDEycyB0byByZXNldCBhIGNvbnRy
b2xsZXIgd2l0aCA2MyBJTyBxdWV1ZXMgd2l0aCA1LjE2LXJjMysuDQo+Pj4+Pj4gDQo+Pj4+Pj4g
Q2FuIHlvdSB0cnkgcmVwcm8gd2l0aCBsYXRlc3QgdmVyc2lvbnMgcGxlYXNlID8NCj4+Pj4+PiAN
Cj4+Pj4+PiBPciBnaXZlIHRoZSBleGFjdCBzY2VuYXJpbyA/DQo+Pj4+PiBZZWFoLCBib3RoIHRh
cmdldCBhbmQgY2xpZW50IGFyZSB1c2luZyBNZWxsYW5veCBUZWNobm9sb2dpZXMgTVQyNzcwMA0K
Pj4+Pj4gRmFtaWx5IFtDb25uZWN0WC00XSwgY291bGQgeW91IHRyeSBzdHJlc3MgIm52bWUgcmVz
ZXQgL2Rldi9udm1lMCIsIHRoZQ0KPj4+Pj4gZmlyc3QgdGltZSByZXNldCB3aWxsIHRha2UgMTJz
LCBhbmQgaXQgYWx3YXlzIGNhbiBiZSByZXByb2R1Y2VkIGF0IHRoZQ0KPj4+Pj4gc2Vjb25kIHJl
c2V0IG9wZXJhdGlvbi4NCj4+Pj4gSSBjcmVhdGVkIGEgdGFyZ2V0IHdpdGggMSBuYW1lc3BhY2Ug
YmFja2VkIGJ5IG51bGxfYmxrIGFuZCBjb25uZWN0ZWQgdG8NCj4+Pj4gaXQgZnJvbSB0aGUgc2Ft
ZSBzZXJ2ZXIgaW4gbG9vcGJhY2sgcmRtYSBjb25uZWN0aW9uIHVzaW5nIHRoZSBDb25uZWN0WC00
DQo+Pj4+IGFkYXB0ZXIuDQo+Pj4gQ291bGQgeW91IHNoYXJlIHlvdXIgbG9vcC5qc29uIGZpbGUg
c28gSSBjYW4gdHJ5IGl0IG9uIG15IGVudmlyb25tZW50Pw0KPj4gDQo+PiB7DQo+PiAgICJob3N0
cyI6IFtdLA0KPj4gICAicG9ydHMiOiBbDQo+PiAgICAgew0KPj4gICAgICAgImFkZHIiOiB7DQo+
PiAgICAgICAgICJhZHJmYW0iOiAiaXB2NCIsDQo+PiAgICAgICAgICJ0cmFkZHIiOiAiPGlwPiIs
DQo+PiAgICAgICAgICJ0cmVxIjogIm5vdCBzcGVjaWZpZWQiLA0KPj4gICAgICAgICAidHJzdmNp
ZCI6ICI0NDIwIiwNCj4+ICAgICAgICAgInRydHlwZSI6ICJyZG1hIg0KPj4gICAgICAgfSwNCj4+
ICAgICAgICJwb3J0aWQiOiAxLA0KPj4gICAgICAgInJlZmVycmFscyI6IFtdLA0KPj4gICAgICAg
InN1YnN5c3RlbXMiOiBbDQo+PiAgICAgICAgICJ0ZXN0c3Vic3lzdGVtXzAiDQo+PiAgICAgICBd
DQo+PiAgICAgfQ0KPj4gICBdLA0KPj4gICAic3Vic3lzdGVtcyI6IFsNCj4+ICAgICB7DQo+PiAg
ICAgICAiYWxsb3dlZF9ob3N0cyI6IFtdLA0KPj4gICAgICAgImF0dHIiOiB7DQo+PiAgICAgICAg
ICJhbGxvd19hbnlfaG9zdCI6ICIxIiwNCj4+ICAgICAgICAgImNudGxpZF9tYXgiOiAiNjU1MTki
LA0KPj4gICAgICAgICAiY250bGlkX21pbiI6ICIxIiwNCj4+ICAgICAgICAgIm1vZGVsIjogIkxp
bnV4IiwNCj4+ICAgICAgICAgInNlcmlhbCI6ICIzZDgzYzc4Yjc2NjIzZjFkIiwNCj4+ICAgICAg
ICAgInZlcnNpb24iOiAiMS4zIg0KPj4gICAgICAgfSwNCj4+ICAgICAgICJuYW1lc3BhY2VzIjog
Ww0KPj4gICAgICAgICB7DQo+PiAgICAgICAgICAgImRldmljZSI6IHsNCj4+ICAgICAgICAgICAg
ICJuZ3VpZCI6ICI1YjcyMmIwNS1lOWI2LTU0MmQtYmE4MC02MjAxMGI1Nzc3NWQiLA0KPj4gICAg
ICAgICAgICAgInBhdGgiOiAiL2Rldi9udWxsYjAiLA0KPj4gICAgICAgICAgICAgInV1aWQiOiAi
MjZmZmM4Y2UtNzNiNC0zMjFkLTk2ODUtN2Q3YTk4NzJjNDYwIg0KPj4gICAgICAgICAgIH0sDQo+
PiAgICAgICAgICAgImVuYWJsZSI6IDEsDQo+PiAgICAgICAgICAgIm5zaWQiOiAxDQo+PiAgICAg
ICAgIH0NCj4+ICAgICAgIF0sDQo+PiAgICAgICAibnFuIjogInRlc3RzdWJzeXN0ZW1fMCINCj4+
ICAgICB9DQo+PiAgIF0NCj4+IH0NCj4gDQo+IFRoYW5rcywgSSByZXByb2R1Y2VkIGl0IHdpdGgg
eW91ciBqc29uIGZpbGUgb24gb25lIHNlcnZlciB3aXRoDQo+IGxvb3BiYWNrIHJkbWEgY29ubmVj
dGlvbjoNCj4gIyB0aW1lIG52bWUgY29ubmVjdCAtdCByZG1hIC1hIDE3Mi4zMS4wLjIwMiAtcyA0
NDIwIC1uIHRlc3RzdWJzeXN0ZW1fMA0KPiANCj4gcmVhbCAwbTQuNTU3cw0KPiB1c2VyIDBtMC4w
MDBzDQo+IHN5cyAwbTAuMDA1cw0KPiAjIHRpbWUgbnZtZSByZXNldCAvZGV2L252bWUwDQo+IA0K
PiByZWFsIDBtMTMuMTc2cw0KPiB1c2VyIDBtMC4wMDBzDQo+IHN5cyAwbTAuMDA3cw0KPiAjIHRp
bWUgbnZtZSByZXNldCAvZGV2L252bWUwDQo+IA0KPiByZWFsIDFtMTYuNTc3cw0KPiB1c2VyIDBt
MC4wMDJzDQo+IHN5cyAwbTAuMDA1cw0KPiAjIHRpbWUgbnZtZSBkaXNjb25uZWN0IC1uIHRlc3Rz
dWJzeXN0ZW1fMA0KDQpXaGF0IGRvZXM6DQoNCiMgcmRtYSByZXMgc2hvdyBxcCB8IGdyZXAgLWMg
RVJSDQoNCnNheSwgd2hlbiBpdCBpcyBzbG93Pw0KDQoNCg0KVGh4cywgSMOla29uDQoNCg0KDQo+
IE5RTjp0ZXN0c3Vic3lzdGVtXzAgZGlzY29ubmVjdGVkIDEgY29udHJvbGxlcihzKQ0KPiANCj4g
cmVhbCAxbTExLjU0MXMNCj4gdXNlciAwbTAuMDAwcw0KPiBzeXMgMG0wLjE4N3MNCj4gDQo+ICNk
bWVzZw0KPiBbOTY2MDAuMzYyODI3XSBudm1ldDogY3JlYXRpbmcgbnZtIGNvbnRyb2xsZXIgMSBm
b3Igc3Vic3lzdGVtDQo+IHRlc3RzdWJzeXN0ZW1fMCBmb3IgTlFODQo+IG5xbi4yMDE0LTA4Lm9y
Zy5udm1leHByZXNzOnV1aWQ6NGM0YzQ1NDQtMDA1Ni00ZDEwLTgwMzAtYjdjMDRmMzkzNDMyLg0K
PiBbOTY2MDAuMzYzMDM4XSBudm1lIG52bWUwOiBjcmVhdGluZyA0MCBJL08gcXVldWVzLg0KPiBb
OTY2MDQuOTA1NTE0XSBudm1lIG52bWUwOiBtYXBwZWQgNDAvMC8wIGRlZmF1bHQvcmVhZC9wb2xs
IHF1ZXVlcy4NCj4gWzk2NjA0LjkwOTE2MV0gbnZtZSBudm1lMDogbmV3IGN0cmw6IE5RTiAidGVz
dHN1YnN5c3RlbV8wIiwgYWRkcg0KPiAxNzIuMzEuMC4yMDI6NDQyMA0KPiBbOTY2MTQuMjcwODI1
XSBudm1lIG52bWUwOiBSZW1vdmluZyBjdHJsOiBOUU4gInRlc3RzdWJzeXN0ZW1fMCINCj4gWzk2
NjU5LjI2ODAwNl0gbnZtZXQ6IGNyZWF0aW5nIG52bSBjb250cm9sbGVyIDEgZm9yIHN1YnN5c3Rl
bQ0KPiB0ZXN0c3Vic3lzdGVtXzAgZm9yIE5RTg0KPiBucW4uMjAxNC0wOC5vcmcubnZtZXhwcmVz
czp1dWlkOjRjNGM0NTQ0LTAwNTYtNGQxMC04MDMwLWI3YzA0ZjM5MzQzMi4NCj4gWzk2NjU5LjI2
ODIxNV0gbnZtZSBudm1lMDogY3JlYXRpbmcgNDAgSS9PIHF1ZXVlcy4NCj4gWzk2NjYzLjgwMTky
OV0gbnZtZSBudm1lMDogbWFwcGVkIDQwLzAvMCBkZWZhdWx0L3JlYWQvcG9sbCBxdWV1ZXMuDQo+
IFs5NjY2My44MDU1ODldIG52bWUgbnZtZTA6IG5ldyBjdHJsOiBOUU4gInRlc3RzdWJzeXN0ZW1f
MCIsIGFkZHINCj4gMTcyLjMxLjAuMjAyOjQ0MjANCj4gWzk2NjczLjEzMDk4Nl0gbnZtZSBudm1l
MDogcmVzZXR0aW5nIGNvbnRyb2xsZXINCj4gWzk2NjgxLjc2MTk5Ml0gbnZtZXQ6IGNyZWF0aW5n
IG52bSBjb250cm9sbGVyIDEgZm9yIHN1YnN5c3RlbQ0KPiB0ZXN0c3Vic3lzdGVtXzAgZm9yIE5R
Tg0KPiBucW4uMjAxNC0wOC5vcmcubnZtZXhwcmVzczp1dWlkOjRjNGM0NTQ0LTAwNTYtNGQxMC04
MDMwLWI3YzA0ZjM5MzQzMi4NCj4gWzk2NjgxLjc2MjEzM10gbnZtZSBudm1lMDogY3JlYXRpbmcg
NDAgSS9PIHF1ZXVlcy4NCj4gWzk2Njg2LjMwMjU0NF0gbnZtZSBudm1lMDogbWFwcGVkIDQwLzAv
MCBkZWZhdWx0L3JlYWQvcG9sbCBxdWV1ZXMuDQo+IFs5NjY4OC44NTAyNzJdIG52bWUgbnZtZTA6
IHJlc2V0dGluZyBjb250cm9sbGVyDQo+IFs5NjY5Ny4zMzYyMTddIG52bWV0OiBjdHJsIDEga2Vl
cC1hbGl2ZSB0aW1lciAoNSBzZWNvbmRzKSBleHBpcmVkIQ0KPiBbOTY2OTcuMzYxMjMxXSBudm1l
dDogY3RybCAxIGZhdGFsIGVycm9yIG9jY3VycmVkIQ0KPiBbOTY3NjAuODI0MzYzXSBudm1lIG52
bWUwOiBJL08gMjUgUUlEIDAgdGltZW91dA0KPiBbOTY3NjAuODQ3NTMxXSBudm1lIG52bWUwOiBQ
cm9wZXJ0eSBTZXQgZXJyb3I6IDg4MSwgb2Zmc2V0IDB4MTQNCj4gWzk2NzYwLjg4NTczMV0gbnZt
ZXQ6IGNyZWF0aW5nIG52bSBjb250cm9sbGVyIDEgZm9yIHN1YnN5c3RlbQ0KPiB0ZXN0c3Vic3lz
dGVtXzAgZm9yIE5RTg0KPiBucW4uMjAxNC0wOC5vcmcubnZtZXhwcmVzczp1dWlkOjRjNGM0NTQ0
LTAwNTYtNGQxMC04MDMwLWI3YzA0ZjM5MzQzMi4NCj4gWzk2NzYwLjg4NTg3OV0gbnZtZSBudm1l
MDogY3JlYXRpbmcgNDAgSS9PIHF1ZXVlcy4NCj4gWzk2NzY1LjQyMzA5OV0gbnZtZSBudm1lMDog
bWFwcGVkIDQwLzAvMCBkZWZhdWx0L3JlYWQvcG9sbCBxdWV1ZXMuDQo+IFs5NjgwOC4xMTI3MzBd
IG52bWUgbnZtZTA6IFJlbW92aW5nIGN0cmw6IE5RTiAidGVzdHN1YnN5c3RlbV8wIg0KPiBbOTY4
MTYuNjMyNDg1XSBudm1ldDogY3RybCAxIGtlZXAtYWxpdmUgdGltZXIgKDUgc2Vjb25kcykgZXhw
aXJlZCENCj4gWzk2ODE2LjY1NzUzN10gbnZtZXQ6IGN0cmwgMSBmYXRhbCBlcnJvciBvY2N1cnJl
ZCENCj4gWzk2ODc5LjYwODYzMl0gbnZtZSBudm1lMDogSS9PIDEyIFFJRCAwIHRpbWVvdXQNCj4g
Wzk2ODc5LjYzMjEwNF0gbnZtZSBudm1lMDogUHJvcGVydHkgU2V0IGVycm9yOiA4ODEsIG9mZnNl
dCAweDE0Pg0KPj4gDQo+Pj4gDQo+Pj4gQW5kIGNhbiB5b3UgdHJ5IGl0IHdpdGggdHdvIHNlcnZl
cnMgdGhhdCBib3RoIGhhdmUgQ1gtND8gVGhpcyBzaG91bGQNCj4+PiBiZSBlYXNpZXIgdG8gcmVw
cm9kdWNlIGl0Lg0KPj4gDQo+PiBJIGRpZCB0aGlzIGV4cGVyaW1lbnQuIEkgaGF2ZSBvbmx5IGEg
c2V0dXAgd2l0aCAxMiBjb3JlcyBzbyBJIGNyZWF0ZWQgMTINCj4+IG52bWYgcXVldWVzLg0KPj4g
DQo+PiBUaGUgcmVzZXQgdG9vayA0IHNlY29uZHMuIFRoZSB0ZXN0IGRpZCAxMDAgbG9vcHMgb2Yg
Im52bWUgcmVzZXQiLg0KPj4gDQo+PiBJIHNhdyB0aGF0IHlvdSBhbHNvIGNvbXBsYWluZWQgb24g
dGhlIGRpc2Nvbm5lY3QgZmxvdyBzbyBJIGFzc3VtZSB0aGUNCj4+IHJvb3QgY2F1c2UgaXMgdGhl
IHNhbWUuDQo+IA0KPiBZZWFoLCBJIHRoaW5rIHNvDQo+IA0KPj4gDQo+PiBNeSBkaXNjb25uZWN0
IHRvb2sgMiBzZWNvbmRzLg0KPj4gDQo+PiBNeSBGVyB2ZXJzaW9uIGlzIDEyLjI4LjIwMDYuDQo+
IA0KPiBZZWFoLCBtaW5lIGlzIHNhbWUgd2l0aCB5b3Vycy4NCj4gIyBjYXQgL3N5cy9kZXZpY2Vz
L3BjaTAwMDBcOjAwLzAwMDBcOjAwXDowMi4wLzAwMDBcOjA0XDowMC4wL2luZmluaWJhbmQvbWx4
NV8wL2Z3X3Zlcg0KPiAxMi4yOC4yMDA2DQo+IA0KPiANCj4+IA0KPj4+PiBJIHJ1biBhIGxvb3Ag
d2l0aCB0aGUgIm52bWUgcmVzZXQiIGNvbW1hbmQgYW5kIGl0IHRvb2sgbWUgNC01IHNlY3MgdG8N
Cj4+Pj4gcmVzZXQgZWFjaCB0aW1lLi4NCj4+Pj4gDQo+Pj4+IA0KPj4+IA0KPj4gDQo+IA0KPiAN
Cj4gLS0gDQo+IEJlc3QgUmVnYXJkcywNCj4gIFlpIFpoYW5nDQoNCg==
