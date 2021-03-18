Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A376340E1D
	for <lists+linux-rdma@lfdr.de>; Thu, 18 Mar 2021 20:22:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232654AbhCRTW1 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 18 Mar 2021 15:22:27 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:46208 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232785AbhCRTV4 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 18 Mar 2021 15:21:56 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12IJKSXC088754;
        Thu, 18 Mar 2021 19:21:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : content-type : content-id : content-transfer-encoding
 : mime-version; s=corp-2020-01-29;
 bh=2kPDgHjyKV2vTjYCbWh1Xg3PEqGKLT+30tBYUoR23tQ=;
 b=NsJBrN05hZD3ISAFOuJb5wry3D9o3/kWBGpACe0/dCaOV8o9fdI6mpWSemRQGyQQRZCw
 XVHckFoszGE5x38ONbRmH/ginon7FJRfvAHOlYBdt4AMX3E/K8wbj7cdlJU+jl52ac6e
 wWMSMcITsfaZfI2H4ewuxtw6/qiVw/3CRaztP2yZZa7q6Uk/+7Ajg1Q8A3CSBO5pdxIF
 aZT36n2CcFUApVwW55pqWWWwRN1tPblkuBEV0oRh3RlYJkh5ajOjMMvJlddWi7TrScD+
 4V943y+NrjYhPEPNwIIfsXI5oGU/jincqZEskx1fU+3KYcLBybvG5IRKbPoCm/XXnV53 uQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 37a4ekwms7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 18 Mar 2021 19:21:53 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12IJKuW6022945;
        Thu, 18 Mar 2021 19:21:52 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2175.outbound.protection.outlook.com [104.47.57.175])
        by aserp3030.oracle.com with ESMTP id 3796ywkv7d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 18 Mar 2021 19:21:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZS2sFOL4olGtLrOqrh7zZNwdoaOeQK53D4w/exFBoxg/XuHBtZOj6c9w9QDY/CSxjwKZCgiOO+fUV81hl64o65PrulUCn5j4vh9mdVwvKEjvb8iKAa7LrOHrCHxskuGEtpbG+uTeBA6ys8t7UDeujIaAylNgWzhjRBjYAnmJ54bi+RPOFXxNG+TVV5ST7poMCBq652byqn+JjAgpOCE0Bvv7pinuWn8ub0WGvMbRhWWxyMRKjm7Pe+cef0Q4OLF2oec/Y2WSrcaQqGgfY8Om/OPM32qj2GIAlE+yCxi3HX1Ud5BRnilReL8MBgfjkYoPXrT1yExv75cT6OWfCMzoVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2kPDgHjyKV2vTjYCbWh1Xg3PEqGKLT+30tBYUoR23tQ=;
 b=nObYH4Av7C8m3FXWYJhwv014vrnl2F48haS2eIUHg8EikQO+SajOzAfMMoX9JsBCfXBPhY7hAujFgLg8p8BwXA9pq6rjTJXUXtphsx9ccdD3GwWELLg2rxR/3Xo3ghyoqBCVix1zkholGHlWjmnfcLC5mv7xSxqeAfsc84tmgieruPXpCeqF3jqqMU/qCWXm0qvvPmEJNllc6e+3AwW777qoa36ydmya5zJY2GLm0Qanm3+S9TzuH79yBqHn0+M+BXqIFMSqD+WrLIlpWQWVF3w42errqArFsDH8igw1cEcrOVfK8OSJXdrNyFB27rkCoxxH07AjO9OJM2fzExv2hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2kPDgHjyKV2vTjYCbWh1Xg3PEqGKLT+30tBYUoR23tQ=;
 b=Ts5L6UgdcdiX7EN8ks2K6QSyiDTOrT4zV0Az9zVoU4ZeyFVTiUbzM+6MczNf5XTU9CiL9vB0TdlWTh3nKWtTpjHTo71zuU9PeJefKQ+VcnkZCKYuKVnCwiziZVzPhKPU8s7ghsuiqHaI5oRQah2VoAi2QKVcahexb78Xqae2vEY=
Received: from CY4PR10MB1989.namprd10.prod.outlook.com (2603:10b6:903:11a::12)
 by CY4PR1001MB2216.namprd10.prod.outlook.com (2603:10b6:910:43::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.32; Thu, 18 Mar
 2021 19:21:50 +0000
Received: from CY4PR10MB1989.namprd10.prod.outlook.com
 ([fe80::ad28:97d2:76cf:3fa5]) by CY4PR10MB1989.namprd10.prod.outlook.com
 ([fe80::ad28:97d2:76cf:3fa5%11]) with mapi id 15.20.3955.018; Thu, 18 Mar
 2021 19:21:50 +0000
From:   Haakon Bugge <haakon.bugge@oracle.com>
To:     OFED mailing list <linux-rdma@vger.kernel.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Leon Romanovsky <leon@kernel.org>
Subject: cm_process_routed_req() does not resonate well with RoCE systems
Thread-Topic: cm_process_routed_req() does not resonate well with RoCE systems
Thread-Index: AQHXHCvyPxEw2t2zlUCRAd9kg3Zpdw==
Date:   Thu, 18 Mar 2021 19:21:50 +0000
Message-ID: <566B6781-C268-4B1C-A359-44B2FE14B91A@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
x-originating-ip: [51.175.204.144]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 34f48191-0aba-4f91-4bbc-08d8ea4314df
x-ms-traffictypediagnostic: CY4PR1001MB2216:
x-microsoft-antispam-prvs: <CY4PR1001MB2216FE2785A634D9E87F6667FD699@CY4PR1001MB2216.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZfFMxSLZymDHA46y1PZ43bekhIbxWjjrdZR6R6EGWHvWI79ywfYOXqGNIamSArB8ozpDEpuYB5dUPWwrfpIt1Yjr4z+dbbjo1xPgUcQtjavdMJu0Dyrah7pzUNlt86UBc/tQAeeGgUgZxsMYSKpk4YMH2A27ibj0r0EEKgb0wKR8b47VcqG3ODNU+o3bOe4Vn+6yo48xrGA7QQy12f3o5atO90fJJf8rZtSVem9P5RXSgDB4kLRIeaDVpJSUisqopw8LDzop9EPqI7kTIvq3jUpoOAZB+0+OH+ttuShDkgUM1f0Pj2Vd0NJDBt/HwmxCIVDWtc7JnQEg55e76nXZ45KH6OU+N2zwQxrQwviZvE7e7UT1PvaycrNcxm3wZJPQKgGh4pq/w9vfQ9uP6zLtyE9gA73afRSTUAGiguJnV5ktoE52Fm9OHmR74Vyvfm6xwqg8mAKb7pfy5a9u+N0zx6/DlnFAuLm+64vplbQ8Lz1kT3l7i6tGvYcMG3AfB2fGQ/QW8xcD8WajDvAzzQu4s6zIrsbVaK7XOuLN646w3XOHIwuAcMrLfWV3sLteaPWJNJkQXXic5gJ/uHp98ZVOrv2rgBhmvhuqq32iciTBYQc8GjOY87POlxZPpVIJhP4xVR8SljT6/qJxcUkO/tRHAA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR10MB1989.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(376002)(39860400002)(346002)(396003)(136003)(316002)(36756003)(2616005)(66946007)(33656002)(110136005)(6512007)(8936002)(38100700001)(8676002)(478600001)(6486002)(44832011)(26005)(5660300002)(186003)(66476007)(6506007)(66574015)(66556008)(91956017)(71200400001)(66446008)(2906002)(76116006)(64756008)(83380400001)(86362001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?QU1ZVmF3ZHMvTVFGcnlQbWxMdzFWbEorWmFSbmkxL1lObDIzUUhNV2FFL1I2?=
 =?utf-8?B?bTFvbGN2dHJSYkZHRlF1azh4UzIxT0lYcHNaTWhTOEpkeHBwbHExVnBTUXg1?=
 =?utf-8?B?Q0p3VkpoaStuMmpJa0tXcnBSdXRDM0ZELy9jeDJEVDZicXZIYi9VdmRLc0Mz?=
 =?utf-8?B?NFNpdi9DbnYvY1dsYkVyL0F4ZjNxUUFwQlZkOWZYK0tqdFA2ZEJ3WUoySGlq?=
 =?utf-8?B?TGJlVXlqNTNESUxqZ0U0UkxiMGd1RmtqZ29Hd2l6YUE5czAvblk5Ri9PRUgz?=
 =?utf-8?B?N0JsYlY0NEFCd1pnOHliek1ZSVoycU5zV0FXVUNZN01PUklwZFFKdjI1NStl?=
 =?utf-8?B?NERIbmtZTzVYNUlTa1drSG9uVk96eXRiemY4ZlJBWkVVNkZvVUNjZExrSVhM?=
 =?utf-8?B?Q3ZWYW44dENHeGtNb1lmdWEyUEk4b0pIOTNGYnl5eGI4VkwrWnZwU1djbnVE?=
 =?utf-8?B?L2VKUkgzbk1xSlE5YWF5VVlnYW1QUEFoK0xPRnkrMzFCNGc4dnJ0b3YxQzRu?=
 =?utf-8?B?aENQR0R3TFRWbVFwc3ZqeXZ4WWYwK3UzRWpieXpSVmlTRlNzVmtHRExmT05B?=
 =?utf-8?B?aU5QMUpYdlJ3VnJOTEJxRGYxOEtsMHY1WTVZRUtFbjY0N3Y4OTNzS01mSnZq?=
 =?utf-8?B?TGdwTW1qdkwyN2ozYlA2eWozd0JDNUtvTXJLMGxQYzAva0szb0FTWFBJM0Zn?=
 =?utf-8?B?N29qcllucFF4RXZnUUV2dW9YdnpGMTB2SGdDN3diTGxPN1V0ZVpuVzRwMzZJ?=
 =?utf-8?B?RmJkTEZ0SDVpd3BPS2ZUekplRjFzdTk5dUhIQzRNTWNqS2hsTzVoNno4VG9Q?=
 =?utf-8?B?TVF0OGdNMGtBWEIvUlBUeEVjN2NGSmlpbnBNWWdhNU1jSUl2ZE8vT2hiQ3ZX?=
 =?utf-8?B?STNzY0I0aEJvL01sdjVMWUJyVWlwbjBReFZROVhEMDF4aTc3Z3FBQnhjTFhV?=
 =?utf-8?B?MG15emJ0OU5nZ2lXKzJWbCs0RitzV1B3QkdiUjA1RFdRNnF1VFJhVUZKNzdi?=
 =?utf-8?B?RDFITlE0NlVCS0xGNE91dW4vSHE5RktFZWdmRzROWUhna0xrMzZ2a0xQcTR0?=
 =?utf-8?B?VzZsVXFwSi9kcjdYYXM4WGgzOGx4OHZpUmNIbXd6YkUrY1YwS2l0K1E5QzdR?=
 =?utf-8?B?Nkp6MVo3SDZHNzJVbnBxbVYvMU5oS2lDbno3c3Q2dmdpQ2VYVHZQb3FvK1Rz?=
 =?utf-8?B?bXJMN2RQTGk1SEI5dTJRMUI5bk1JV2FLS1VZcGFnZEZ4RFZzREN2YXQvTDJm?=
 =?utf-8?B?SENpcjhya1phYzA5RkRHOWFKci8zN2VQRFpOL3BjZ0ZiSkVkYzNLU2RJMUhl?=
 =?utf-8?B?THNySHhmY3NDL09pMjdVTEVlVXFqYzBxQjBnV091eHRjYVhIaDdLYldSZTNm?=
 =?utf-8?B?T2pyM3RueTRITFF1TFo5c0Jzb2NuL05xemxOSzN6VE9VMEZ3T2xzY1kxNXFv?=
 =?utf-8?B?NW5nZk5zaU5BRThEaGVDdVh3TWxuREQzSVc2UGlBbnhSQ3lJK2lkVGpQb3BW?=
 =?utf-8?B?ZGI0aTF3a0p0K0VKWEZvei9MSC9tR1RGaGVrL3Z3MCtwcm9IZXBKeHJoTko1?=
 =?utf-8?B?YXkyTVU5a3pXL3JGSFpaaXZZTHRmajcxTkJlbHorS0FqRmZFa0JpTnlNNVdh?=
 =?utf-8?B?ckFPYmlJcHVIdHNOOUFRaDlabG9PVWV0Z2VvV2IrRy9zcHdCVVR1dFVqZS92?=
 =?utf-8?B?SVJ0UUJZR0s0a2pESitoUi9Md1U4RGNwQ2NvM0dKc3pUczZ5bUwyY0wrcVU2?=
 =?utf-8?B?SmtPanAvZGZmVnVDUmhhTHBBbFhrMWpyM3RQVStXMitBOXRpWm9WaVpmdURo?=
 =?utf-8?B?TXQxY0NzYkFtc0hkZUZkdz09?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <FF45414D58FAB64F8E0B110641B53D8C@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR10MB1989.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34f48191-0aba-4f91-4bbc-08d8ea4314df
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2021 19:21:50.5842
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ix3DC0QsV/L/xNsDLLFcb5x9+G7tTXmVk8ABD4FOYWAKMOt/4mMLy9oVbDcZXd1IRkbod4433D9TbyArpICblQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1001MB2216
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9927 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0 spamscore=0
 bulkscore=0 mlxlogscore=999 mlxscore=0 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103180137
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9927 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 bulkscore=0
 impostorscore=0 lowpriorityscore=0 mlxlogscore=999 spamscore=0
 priorityscore=1501 adultscore=0 phishscore=0 suspectscore=0 clxscore=1031
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103180137
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

V2l0aCB0aGUgaW50cm9kdWN0aW9uIG9mIFJvQ0Ugc3lzdGVtcywgYSBDTSBSRVEgbWVzc2FnZSB3
aWxsIGNvbnRhaW4gKHBhc3RlZCBmcm9tIFdpcmVzaGFyayk6DQoNClByaW1hcnkgSG9wIExpbWl0
OiAweDQwDQouLi4uIDAuLi4gPSBQcmltYXJ5IFN1Ym5ldCBMb2NhbDogMHgwDQoNClRoaXMgYmVj
YXVzZSBjbWFfcmVzb2x2ZV9pYm9lX3JvdXRlKCkgaGFzOg0KDQogICAgICAgIGlmICgoKHN0cnVj
dCBzb2NrYWRkciAqKSZpZF9wcml2LT5pZC5yb3V0ZS5hZGRyLmRzdF9hZGRyKS0+c2FfZmFtaWx5
ICE9IEFGX0lCKQ0KICAgICAgICAgICAgICAgIC8qIFRPRE86IGdldCB0aGUgaG9wbGltaXQgZnJv
bSB0aGUgaW5ldC9pbmV0NiBkZXZpY2UgKi8NCiAgICAgICAgICAgICAgICByb3V0ZS0+cGF0aF9y
ZWMtPmhvcF9saW1pdCA9IGFkZHItPmRldl9hZGRyLmhvcGxpbWl0Ow0KICAgICAgICBlbHNlDQog
ICAgICAgICAgICAgICAgcm91dGUtPnBhdGhfcmVjLT5ob3BfbGltaXQgPSAxOw0KDQpUaGUgYWRk
ci0+ZGV2X2FkZHIuaG9wbGltaXQgaXMgY29taW5nIGZyb20gYWRkcjRfcmVzb2x2ZSgpLCB3aGlj
aCBoYXM6DQoNCglhZGRyLT5ob3BsaW1pdCA9IGlwNF9kc3RfaG9wbGltaXQoJnJ0LT5kc3QpOw0K
DQppcDRfZHN0X2hvcGxpbWl0KCkgcmV0dXJucyB0aGUgdmFsdWUgb2YgdGhlIHN5c2N0bCBuZXQu
aXB2NC5pcF9kZWZhdWx0X3R0bCBpbiB0aGlzIGNhc2UgKDY0KS4NCg0KRm9yIHRoZSBwdXJwb3Nl
IG9mIHRoaXMgY2FzZSwgY29uc2lkZXIgdGhlIENNIFJFUSB0byBoYXZlIHRoZSBQcmltYXJ5IFNM
ICE9IDAuDQoNCldoZW4gdGhpcyBSRVEgZ2V0cyBwcm9jZXNzZWQgYnkgY21fcmVxX2hhbmRsZXIo
KSwgdGhlIGNtX3Byb2Nlc3Nfcm91dGVkX3JlcSgpIGZ1bmN0aW9uIGlzIGNhbGxlZC4NCg0KU2lu
Y2UgdGhlIFByaW1hcnkgU3VibmV0IExvY2FsIHZhbHVlIGlzIHplcm8gaW4gdGhlIHJlcXVlc3Qs
IGFuZCBzaW5jZSB0aGlzIGlzIFJvQ0UgKFByaW1hcnkgTG9jYWwgTElEIGlzIHBlcm1pc3NpdmUp
LCB0aGUgZm9sbG93aW5nIHN0YXRlbWVudCB3aWxsIGJlIGV4ZWN1dGVkOg0KDQoJSUJBX1NFVChD
TV9SRVFfUFJJTUFSWV9TTCwgcmVxX21zZywgd2MtPnNsKTsNCg0KQXQgbGVhc3Qgb24gdGhlIHN5
c3RlbSBJIHJhbiBvbiwgd2hpY2ggd2FzIGVxdWlwcGVkIHdpdGggYSBNZWxsYW5veCBDWC01IEhD
QSwgdGhlIHdjLT5zbCBpcyB6ZXJvLiBIZW5jZSwgdGhlIHJlcXVlc3QgdG8gc2V0dXAgYSBjb25u
ZWN0aW9uIHVzaW5nIGFuIFNMICE9IHplcm8sIHdpbGwgbm90IGJlIGhvbm91cmVkLCBhbmQgYSBj
b25uZWN0aW9uIHVzaW5nIFNMIHplcm8gd2lsbCBiZSBjcmVhdGVkIGluc3RlYWQuDQoNCkFzIGEg
c2lkZSBub3RlLCBpbiBjbV9wcm9jZXNzX3JvdXRlZF9yZXEoKSwgd2UgaGF2ZToNCg0KCUlCQV9T
RVQoQ01fUkVRX1BSSU1BUllfUkVNT1RFX1BPUlRfTElELCByZXFfbXNnLCB3Yy0+ZGxpZF9wYXRo
X2JpdHMpOw0KDQp3aGljaCBpcyBzdHJhbmdlLCBzaW5jZSBhIExJRCBpcyAxNiBiaXRzLCB3aGVy
ZWFzIGRsaWRfcGF0aF9iaXRzIGlzIG9ubHkgZWlnaHQuDQoNCkkgYW0gdW5jZXJ0YWluIGFib3V0
IHRoZSBjb3JyZWN0IGZpeCBoZXJlLiBBbnkgaW5wdXQgYXBwcmVjaWF0ZWQuDQoNCg0KDQpUaHhz
LCBIw6Vrb24NCg0KDQoNCg0KDQoNCg0KDQoNCg0KDQoNCg==
