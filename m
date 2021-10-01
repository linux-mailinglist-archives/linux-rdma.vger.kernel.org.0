Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8520141EB5B
	for <lists+linux-rdma@lfdr.de>; Fri,  1 Oct 2021 13:05:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353442AbhJALHH (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 1 Oct 2021 07:07:07 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:52672 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1353235AbhJALHG (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 1 Oct 2021 07:07:06 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1919kHCd004210;
        Fri, 1 Oct 2021 11:05:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-type : content-id :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=rVpCmWbLwEBQMCyZ+wV+5RFCcHzVDzJG3CEED8CEIV8=;
 b=O+VbFFTrpilP4ijITCFWmMmGh1gQLM3VHtADVmDjnWsl5+cQNk3WeBHSR2ziB/HRj8od
 VsK+i7dknUhW5UpbNAepxbxOnbr0I8iBH2jbu5n3hn2K4S/DUB3l6J9D4ua4dBMtaYA9
 Ca0WrukVXNMjRcmTnQeom9IguEdQ37dpBX/21U7mIf97giw1iFVnlXjpVYlUOQQEGu/l
 LG3KZQtmb2ejzVV4G+LgMXK8brKkwS7d+S5GPIAwGSuBjWXHZBrpaP3djIMrcyE96tSr
 qViblXULgIc3bcZH7RHLcKb4KYECamIN+AslsYjbR2hBnSWyM4K9Dgyi2SxOQ4ennZiH EA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3bddu8xx93-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 01 Oct 2021 11:05:18 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 191AxrdH035982;
        Fri, 1 Oct 2021 11:05:18 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
        by aserp3020.oracle.com with ESMTP id 3bceu8fxb3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 01 Oct 2021 11:05:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dn4KOSn86SIyKx7oB9OlCFKf4T+51nhjBq8hQsURr/esVx3DalPE5AQAjoepI9Xd75kmeJTEaOOpXuzeSWsZH1q0pBHogv51C6d63TSZsXWEK9QDR/MTekUZ7qIXdSxu810qk39WVuxgl1oz31NgsUpX1bl1+MyLl0v37jG6wnGZp5HjD2+yNzEJZX5KKPx7OPS7/XMlzTaycyH4uxUokBqNP0GDUyug7SA5PlE0YNKxZdS3g1aSnZF+n1wqVxVaX0ZGWE3zt9G+rMdWOcVtnYhPdeG7whNuZag9tmQ9J5F1k1++DflW/nXJmwk6cFdQWoTWwzk4K/vkp6X9bJjfdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rVpCmWbLwEBQMCyZ+wV+5RFCcHzVDzJG3CEED8CEIV8=;
 b=Xec1dGhMaodbaiYaZBLj6qOznv95U2EhJOQB5Ayvzj2bDfPHDsXn0WbqtRVK6XG9GO64xmQQsu+u+Nae17Gin4ozkOFpWUjCCIGt7Tmn9VO+T2WU8uft2JTCLD/y7ZHFO1GieP7gBVeCQhB0mBb0E92xByfGTbz0hOvV/qN9Q3C2OTqLGrOEL5FsP82j+oKCFL91evJq7gUdj0hHrnrB0wvTvb+TxPfxJ+NQN9Xu3jd07a2hmScM23/ugjk+aBiShIC3kdQBw4fjdx4QBeiATXQAE/++aSlkM5rinlRG10qc3IglDDNqi85vma+kGOaIS9DcXYLKmtC+Uy2QmCnwJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rVpCmWbLwEBQMCyZ+wV+5RFCcHzVDzJG3CEED8CEIV8=;
 b=qik9C85489Be2pjnpEXfSDgsnDCTELQMsVAmwOyIdJzTUTp8DDpPwWcgLnb3B/7O4FJiRKjG+/3bCJt6eslyLXLeGJ/Z4sbMQwFkwoERXFJlh0fTqG3JprlK6bBnm3R9B3uLbqqVXFG+nowOgdJ29ckpUbq/oIZHNZqFel8WGzk=
Received: from PH0PR10MB5593.namprd10.prod.outlook.com (2603:10b6:510:f5::16)
 by PH0PR10MB4805.namprd10.prod.outlook.com (2603:10b6:510:3b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.14; Fri, 1 Oct
 2021 11:05:16 +0000
Received: from PH0PR10MB5593.namprd10.prod.outlook.com
 ([fe80::7538:df56:577d:66]) by PH0PR10MB5593.namprd10.prod.outlook.com
 ([fe80::7538:df56:577d:66%5]) with mapi id 15.20.4566.019; Fri, 1 Oct 2021
 11:05:16 +0000
From:   Haakon Bugge <haakon.bugge@oracle.com>
To:     Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Bjorn Helgaas <bhelgaas@google.com>
CC:     OFED mailing list <linux-rdma@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Enabling RO on a VF
Thread-Topic: Enabling RO on a VF
Thread-Index: AQHXtrQ2Snh1/80S5EW81QFY8okd6A==
Date:   Fri, 1 Oct 2021 11:05:15 +0000
Message-ID: <48FF6F8E-95E2-4A29-A059-12EF614B381C@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=oracle.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7a943b83-dcc0-420a-55c6-08d984cb5951
x-ms-traffictypediagnostic: PH0PR10MB4805:
x-microsoft-antispam-prvs: <PH0PR10MB48052632694C23D395AFAE8AFDAB9@PH0PR10MB4805.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: feUjEiMlVSuIVsYsdhgCNGgg0rlcUXx2AY8EEbpN7mabhpYlctg8oVgYOp/gyUj99HGkDme2ReMpTXpENWQj1LoJd5dlBiW2mbYy5MBvFC8I+11GNu+zwUQf3JFA8NAS8krLF9V1c21jo67RIf/BelKum/UirZ3MQHNm631FjVVWhBKdUevCxjf3nDsb5d5sxP8qw4oO9xudemqPIkfTlllvaloZenVcvhNaFCR++CLrKaHt5D1B6Fo6iwmk/PvUSs8LW/7i6GC//k+16rB4+0hrjXinY/2OVY8KMxaTaCxM4o/0+pGK71ze6lW4HCxy8IbkqsLZg31y9MDOtSB6w0VvsNStFsq5GtPPbEJEcMzzt71AeP2TGxYs1HRAjquvdqpXoaoLPltxTRWGwU9INV6LTdP3HikHjOfXUvUTUs0VxWnnggXqm22Gk33061z7cz1G/C1+GXyhXuoKbXYkp+ts/xy8j7FscG5EsJGlF6c0ESBrYtfvetbtmFVDfw/qTG7fER8B64wDDSdmkCKtSHYamNp4FcNyEuYuFlWOGxQoJ7QTIO4t0iTI9CfUc3/OP2PCYG4BzJw1Udq4xdWy4ExA88/yzYrMsREKR3AHEX1o9AGQJfjRomxxhaVVHn93iY/juIUW/KKld1KVpxZIbEZgX06g1JcmtIQTI2A6tfdhnTAIF3e6n+SJLc6UQHgR+q0pZ4X44HgWcak/PB4mlAWPdIP+4SYPZt9Klp3bmGQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5593.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(122000001)(8676002)(6506007)(2906002)(6512007)(6486002)(4744005)(44832011)(66946007)(26005)(33656002)(36756003)(110136005)(54906003)(38070700005)(66556008)(66476007)(186003)(64756008)(66446008)(2616005)(4326008)(71200400001)(76116006)(91956017)(38100700002)(8936002)(5660300002)(86362001)(316002)(508600001)(83380400001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?S1I4cDlJM2dQUEF0VDFtZGh6U05YeUZyOElLWXBqQktzYkplMU81empDcFZ0?=
 =?utf-8?B?cXpXRHZzb3FPMGNWWmhlRDFmdnBCY0F0TUN4Y0ZzYUNqdlJjdFd4UHBrcFl6?=
 =?utf-8?B?SkhZTHVFejZ2c1dBMm55eFJCYUV0SENyUUIwRUZ0ekFKalFJVnFHd2VKc05q?=
 =?utf-8?B?NzRiTkhQb1F2Z2RuN0hyejlidDdpbmtjaUZpNEprY1F3TkxFWmpXbTExaU83?=
 =?utf-8?B?SjR3UjMyUzAyV3UxSzZTL1JWYnNHKy8vbEtWV1FhWGlRcklqQzB1cE13a1pL?=
 =?utf-8?B?bXp1aUZ2UjFvTkhWL3R6UW55TEloTm82OGN3ZUJxZ215ZVVPaXVNZFhobUkx?=
 =?utf-8?B?bEVTUThuU3cyemhwN0RyR0g2Z0ZHdkl4YTVFdFhmQUdiL3ZqNkF4eitKRGlw?=
 =?utf-8?B?TVp1QmtUWDFsdzRESlRrb1kwK0llQ0hCMFBVSzc0VG9qc3dZTXpLd3JKUURW?=
 =?utf-8?B?bHdUZ1lqN3NmeVI0bDNobXlXU0hJWHI2Q2hHRzlnaDMxTkJTcDZ0bzhMY050?=
 =?utf-8?B?eTlvYk4zckk0bGlRVEtYUnVvU2Nmd3RLM0ZPejhlOU9kU0dScStKVWd3cDQx?=
 =?utf-8?B?UFF3cDEyV3ZMYndXTXdIR0o2eXNkaVZFRkpFa2JnbzM4WWhFd0kyamlEQXJS?=
 =?utf-8?B?NUVaZjQvYVVtazM3aFZxMVg1TEhHK3FUNnR5VmZqUENjbC8yYjRUZ1hNT3ls?=
 =?utf-8?B?MXU4LzJkZVVrbHRBUGlSYXFKbExtajhVdEhLcTVrQk5KcVBKcnZQcHNZYkRQ?=
 =?utf-8?B?RTUrYWRGeGtPZHR2U0JvZk02Y0hlczYxNmF1NVA0WGFQR28wZXVRZUxkYWxL?=
 =?utf-8?B?L3lJK2Z0YW1peDNHVG9NakpMcXBpOUwvblFoUVNFY3oraUZudzM1eDROa0dG?=
 =?utf-8?B?dmVtRy9JUU0vVlpia0I4bk5ZWjg1ek9vSFB5M3QxZ05hSDJEcmdxNUxxMTZT?=
 =?utf-8?B?bTgwdkNFVzFRaVRjQVhoTkd2cWJxR3ZDUGYwV0RGYlo0ZXZ2SVVWQUY3Y2VN?=
 =?utf-8?B?NEFTU0d0UnhDNWd0bkF6OGU1Vk1IQTlFSTNEMEI4eVVZUWIvY2FicldnandB?=
 =?utf-8?B?ZEtyd3NEc0N1d3JsRktGNUV4UHZyZ1UrZU1ZZStHRkIrU0xnM2xsenA2RzFk?=
 =?utf-8?B?WVdsRGNDd0tGbDdPYnM1d3lEZ3dieDBWdkpmNURxa2w1VC95WVZCdXNUU2lC?=
 =?utf-8?B?bEhDblpQT2FLaVAvNUpBNWRLSUlHalQxN2pXWVBaQk9nU1Y3dEtEbjlKN3B4?=
 =?utf-8?B?cjBTZzNybHc3WGNhQnlKNUVidWNSclgyTU13Q0Y1MnhOZzFzN3hrQ2p6VUo4?=
 =?utf-8?B?R1F3clpMMHZiaXBROFI2UkhjN2NRZGpZaGFienBuSHhSN1Q1eThqZG9EVmlL?=
 =?utf-8?B?TGFSdUduMGpTMXo1TlliSnJCRUV4Q282MTFUS3Jxa2tYM01NaFBGaXQ0RGpn?=
 =?utf-8?B?MVpsVkVhZnVHMTNUN3cxcXdPcmtoekZVcGg2USs4em1TY3U1QytzWVVyVzN4?=
 =?utf-8?B?cURzdHFXWWo5cUkrWFFnWU5GRW5CT2hRSTVpbnV1bFNhd1lkTmNmNjVaRS9V?=
 =?utf-8?B?c0JIdk5PV0VxeWVYQ1VxWXZDZm0ySEF2MUc3MGxCZXVURHhKSDk5TnFCcm1G?=
 =?utf-8?B?cmx2VHcvdEZDempubjN4eFY0bDZpK3lhN09QMDlqSExKVjg0ZS9PRXFtSnRw?=
 =?utf-8?B?QmpYcVBEQ3Y1ejV5RmM0TGtiUzlvVVFqRGdCODNxVWFpQlVEdWd1UXNIRTNv?=
 =?utf-8?B?dzl0NWVsWlVzdThNZ2dQazlxcHdjcnBwbzZ6OUdhVHlRekxORjY2Q3pnd09O?=
 =?utf-8?B?aUpoQ3JKVllIcGxSM2Q4UT09?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <19700E842DB293409522B44512A95888@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5593.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a943b83-dcc0-420a-55c6-08d984cb5951
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2021 11:05:15.9543
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BRaCmtqr9Zll+60EBFloo4STW+iyk9vAeU3VsK0Ub3l9KBlNzmWE9z/WTmZvlFkD0hP1gLBuqViOgZaDPbVdfQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4805
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10123 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=0 spamscore=0
 adultscore=0 bulkscore=0 mlxscore=0 malwarescore=0 mlxlogscore=496
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109230001
 definitions=main-2110010074
X-Proofpoint-GUID: zpcPqitG26_cWiq2VFmsQBgF3GRS_EAy
X-Proofpoint-ORIG-GUID: zpcPqitG26_cWiq2VFmsQBgF3GRS_EAy
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

SGV5LA0KDQoNCkNvbW1pdCAxNDc3ZDQ0Y2U0N2QgKCJSRE1BL21seDU6IEVuYWJsZSBSZWxheGVk
IE9yZGVyaW5nIGJ5IGRlZmF1bHQgZm9yIGtlcm5lbCBVTFBzIikgdXNlcyBwY2llX3JlbGF4ZWRf
b3JkZXJpbmdfZW5hYmxlZCgpIHRvIGNoZWNrIGlmIFJPIGNhbiBiZSBlbmFibGVkLiBUaGlzIGZ1
bmN0aW9uIGNoZWNrcyBpZiB0aGUgRW5hYmxlIFJlbGF4ZWQgT3JkZXJpbmcgYml0IGluIHRoZSBE
ZXZpY2UgQ29udHJvbCByZWdpc3RlciBpcyBzZXQuIEhvd2V2ZXIsIG9uIGEgVkYsIHRoaXMgYml0
IGlzIFJzdmRQIChSZXNlcnZlZCBmb3IgZnV0dXJlIFJXIGltcGxlbWVudGF0aW9ucy4gUmVnaXN0
ZXIgYml0cyBhcmUgcmVhZC1vbmx5IGFuZCBtdXN0IHJldHVybiB6ZXJvIHdoZW4gcmVhZC4gU29m
dHdhcmUgbXVzdCBwcmVzZXJ2ZSB0aGUgdmFsdWUgcmVhZCBmb3Igd3JpdGVzIHRvIGJpdHMuKS4N
Cg0KSGVuY2UsIEFGQUlDVCwgUk8gd2lsbCBub3QgYmUgZW5hYmxlZCB3aGVuIHVzaW5nIGEgVkYu
DQoNCkhvdyBjYW4gdGhhdCBiZSBmaXhlZD8NCg0KDQpUaHhzLCBIw6Vrb24NCg0KDQoNCg0K
