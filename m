Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43CF23B05D7
	for <lists+linux-rdma@lfdr.de>; Tue, 22 Jun 2021 15:30:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230102AbhFVNc4 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 22 Jun 2021 09:32:56 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:50790 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230047AbhFVNcz (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 22 Jun 2021 09:32:55 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15MDHa0f004099;
        Tue, 22 Jun 2021 13:30:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=qpAIMrJcz3SQlioyvsKrru1YIC+7+STpBBsCDMpquEM=;
 b=lY+scOxUYVeUguPJHR/7dV6HIGq8r3uisk1A62Ec/vJMtyjbo1JlfAjnjsNGgi7diokJ
 RPOOW+V3QxW30/o90eySbT+lMRnGMQxuR/xelsdt8usqVPPK63gcRvMvqN0xVD8b/0Hl
 yTOOlAzbDkuTtUZCxTVYkUxTwJecsjHHdDRLPRT6pOEPiuP9oookEVpwofUhNwBzIoqn
 8FW7Th47/z5+bU39YkDpgBoxaL0sRfBtvkrU499bkX2zngbvukS/2Wlz4Vb5v4kx6xBi
 kdpKu066Xv10lTG5Fg0xFoJu4eA/jjIHkRGe6YOge4geDuG9iggJgm+c/sBkbx5N8eK4 qA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 39ap66kbpx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 22 Jun 2021 13:30:35 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 15MDFsN8129728;
        Tue, 22 Jun 2021 13:30:34 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1anam02lp2041.outbound.protection.outlook.com [104.47.57.41])
        by userp3020.oracle.com with ESMTP id 399tbsq12t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 22 Jun 2021 13:30:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hlh+Kjt8LFsV+49s41vjdK87XNTZY/LI+cy8okCZwd3TfzZcarizYuryHttezl39iOu5FLhbK7b5eEe2Lmnu8mO0YN2f2MD+3YInpZ4L6AHQQY81Vfpo7ekCrGC7+dIEc/92Z5XN9lX+lpha5rbMEGifI/OcKVGFmxKUmpVAFap0wEGt/50Djf+9kSjhBDtzF9RrGs8YAg6rSqXu0DvSIFBAJ2Dq237TS2Mr5xFIB1KyQwLx+4xCiB35nnkIIPwsHlw5W+jE7uVTfndkUhxKUgvaUOPneDGsfwssNhdg2QBF3dtTqPUC/TMW3yubmOLpOwfjca5vUmcB1zg/bsPd+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qpAIMrJcz3SQlioyvsKrru1YIC+7+STpBBsCDMpquEM=;
 b=gL0hF29IQM1pR+2xMPnji7Mj+76HK+dFO3eFnPaZptTnLc4iWkvmNkc1mwtEzJehEzMqK5+QtMWvE9ruxaHeR4pZupl0Iwz1xKrNYrTnxajKRr7U29cNCa6t5Kdgyy78F2XYERGAq13bSUCGzzay7l/C2Qtj9cwdriJ263QZIiFgmvO8Yn6NiqGrW/v+ltZXmGw0BNiDZAcnfcSIkIjXftWU2Wuf+W4JU6rGCXUJU1l1nQNTMssGekX6w0caN54GiX6nt82XUVsIVS6MzEd/DCCFQbTz/0hVH698JEZzmZj9hCMagqH5+rXpkMZJFUIQkMlfNldZt3mVcsiJCn4ePQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qpAIMrJcz3SQlioyvsKrru1YIC+7+STpBBsCDMpquEM=;
 b=LY0oxrqY1LVK4zP4MXRFeQ6S2HmramhAz1lHowW7+HZ6tpNrx2fs+miO6X57E1cJ6r7pIymhDB80ve0PJcSZ1AMmTdpKxqrEMbZVXBPiTT5qkT9HOFL/hL+gWON/9CFpKodwP2DsWGIMW6HOwNOfL+ar2VKT1sUQsNPIRIn/Gls=
Received: from CY4PR10MB1989.namprd10.prod.outlook.com (2603:10b6:903:11a::12)
 by CY4PR1001MB2182.namprd10.prod.outlook.com (2603:10b6:910:48::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.21; Tue, 22 Jun
 2021 13:30:32 +0000
Received: from CY4PR10MB1989.namprd10.prod.outlook.com
 ([fe80::2cda:5611:238a:17a3]) by CY4PR10MB1989.namprd10.prod.outlook.com
 ([fe80::2cda:5611:238a:17a3%8]) with mapi id 15.20.4242.023; Tue, 22 Jun 2021
 13:30:32 +0000
From:   Haakon Bugge <haakon.bugge@oracle.com>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Leon Romanovsky <leon@kernel.org>
CC:     OFED mailing list <linux-rdma@vger.kernel.org>,
        Mark Zhang <markzhang@nvidia.com>
Subject: Re: [PATCH for-next 2/2] RDMA/cma: Protect RMW with qp_mutex
Thread-Topic: [PATCH for-next 2/2] RDMA/cma: Protect RMW with qp_mutex
Thread-Index: AQHXZ2lyeXQxzGWdyEazNY7OyRoIbqsgBriA
Date:   Tue, 22 Jun 2021 13:30:32 +0000
Message-ID: <337D2165-2CFE-4E67-9F8A-282B444FD0DF@oracle.com>
References: <1624368030-23214-1-git-send-email-haakon.bugge@oracle.com>
 <1624368030-23214-3-git-send-email-haakon.bugge@oracle.com>
In-Reply-To: <1624368030-23214-3-git-send-email-haakon.bugge@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.100.0.2.22)
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=oracle.com;
x-originating-ip: [92.221.252.204]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3be3c2d2-a16f-4fa3-6110-08d93581e90e
x-ms-traffictypediagnostic: CY4PR1001MB2182:
x-microsoft-antispam-prvs: <CY4PR1001MB218222EBAE9DC7A3B7BD9BF7FD099@CY4PR1001MB2182.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: r+BJLptRNBlNOg4gTEvpwJmgBE/gfXM7qFx6oeRg23iyWzDD02bplHPIxDUPz63ZRf5HJnc/V01kQxLTqs6nFt46ZQNtb7NKmpn1OVgyw3Oon5IjdGhXu4KYCsjKvMNbUpEDYfNYZA7JddXp4jJ9JB3HzD2Gu08gHdbJAtxUWDlR92PF18W8nnHGgUu+Iv9JGjnNfW9jQ5h9Cm/fWCcezlFkvs+L6bjNOhHAnyF9yn4wG3dbDovLCuR8ZInzXdvkX2VEJZYR8EvK2F4TAKu8I4axvjjF59XdDi+p5bCIGIyq7+CAe3Ed02OjBQb1pF4y4KSu6ywr8d/pQlTSxgDbquL7djKO6mi6OKPYydKXWWM2q36B4r9965yn38SKwOr67CeYF3iz4GeDoM2whTF/cBr1IGhQ3IQTw4mqcOmUjrN/OXzquoNdd6DHcO0l2ODZ+UKDHIkk4rslUqQ58bU1D+2D/KWVGRAkNRFPOlt//svEU5GRAK0ArCcuNl2RxylQsJ6CWhJ9sjStdsYrrCpJoqbuzCwVRY/NCw1QnNfcEraTlY6alAWberBfqQGiWsvC/hYrkRYgKbl1IwH8gONvJb00232sOhhiY1I+lhbL/+J8hMKNVCtHKOq7f+lYwjHBk5DDriygSSdFb292LLSWsRvKEpKwqVGz2798v/nGvX8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR10MB1989.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(396003)(136003)(376002)(366004)(39860400002)(4326008)(5660300002)(316002)(83380400001)(54906003)(6512007)(44832011)(66476007)(26005)(66446008)(66556008)(8936002)(64756008)(36756003)(71200400001)(53546011)(8676002)(110136005)(66574015)(122000001)(38100700002)(6506007)(91956017)(2906002)(478600001)(186003)(86362001)(76116006)(2616005)(66946007)(6486002)(33656002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?b1N6S2IvQzhsS0ZDQjlzZy9FS0t4RExnaCtNRElZTDJlcjJ0L09HeHhCb3NF?=
 =?utf-8?B?SkI4ajN4dmUwZ2NKcVRWaks0QlA5ME1hWjlWblljMUlKclBlTnRHbGdOcTlZ?=
 =?utf-8?B?LzMwMlU2MDZVUkdxNU9JUGp5SGVhT0lXTGFUby9TMUI5Q0dHdXlZS0JQejZq?=
 =?utf-8?B?bWo4Z0hIa2l1S09WdS9PZUV1RjlMVlZwUmVaZ0xoU0tNd0FCZVlMYXFEcWNq?=
 =?utf-8?B?Sk9qTFNLMUYwOE5PYXZvOEVGa1pNZkF0Qk1DaUpHbys5OHRma1ltYTZGTkFh?=
 =?utf-8?B?VG5uYWdHSFBFUEhFV1dOV3RqRWkvbVNaMHFCaFRvS1E3V3lSdUpveG1zSHBU?=
 =?utf-8?B?L0NYakZQTFYzbHlBWG5aQS9DMkhOTEkrVS9jaWYzbDRlWVNaYzc3czhJZVF1?=
 =?utf-8?B?VmVHa2FVZ2hTcWRSMTRlWnZUNHpwRUY4UGxjM01tKzJ4TDJEaXJzSEJiY0hL?=
 =?utf-8?B?c05PODBRR3dZbE9xRkx5NjcvMHhrR2VqUEk5VWtRdmQxd2dwTEJuREpaVG1y?=
 =?utf-8?B?N0o1TGdjU2ZDTTB1VTJ5SWVzOGVaWlVkUnJ1Mmo0Wks3VUZkckJvNkNpcklQ?=
 =?utf-8?B?cDQybWgzU2daaXdTY041TjdmSVRLOHNjS1YzRDlSOGVYMFYydzBaKys0amht?=
 =?utf-8?B?cWVOMitFemR2N3Z4czBNMmhyZ0hFdWh6QnZOU2IwTzN6T2xoRmZXWjNFQ3Za?=
 =?utf-8?B?eHRWcHV2QmhPVHl4ZmlKU1dsY2pvYkpoa0V2L3ZYOVpaTEJLMkUzbG5qY0d5?=
 =?utf-8?B?bkFEUFRwWmt2SlVkcWRCUlR4aEVQaFdhTDF0OEVuMmhKSEd0NW9aUmk0OEZV?=
 =?utf-8?B?bFNLVEJHa0pCZTZlVFRlMVhxczY0OVBqaFJ1eWhWWXM4N2tIRXZTcmlSRzd0?=
 =?utf-8?B?NEpWakd4eEYyUm5PMUxtL0oraDlCOU1lMHl3cUl3YXp4MjBSKzYxbXdoaFB2?=
 =?utf-8?B?NlhGbmc4UmsvTlVxdkFwaStvVGxBZ1RQc0xWZ3BkckN6T2pHQkd4d2s5clhm?=
 =?utf-8?B?ajlvcDVZa204SW45dTYrZHc5akE4NjJ4cmEraTV2VDBWdnVHT2ZTOWVOTDFX?=
 =?utf-8?B?Qzd0RFJ1eGJadGFnSHVLUGNQQ3ZKQmFsTWtGUHVvU0owVFRZYTdNN0QzNTNK?=
 =?utf-8?B?aVVLanJVNE5uZ2x0ZmIyaWNobzNicFVQL0NCVWdzNnl2UFVZd285OVBvV2Vt?=
 =?utf-8?B?QTZBWG5oaHJYeFRIbE9IYVJtMjY0bFB4SG9sUWllUTV1Uzh0UWd4WVN4VFdG?=
 =?utf-8?B?MUZDdnorTkZQa0dXdHJmL3pESmJQQ2FraS9XWGtBemliOGNlYWNSOTNjYlBJ?=
 =?utf-8?B?bU1ySTNTaTNYREQwdG16akNwUGYxU1VLTTJ3d2ZuM3loNUZLNjdTc1RQVWFU?=
 =?utf-8?B?MEF6Wi8rM2dCb3lUUy9vSUQ0QjRYTzk3bDdXOHlIaW4zZU90U0I5TDRJak4r?=
 =?utf-8?B?YldQb0dQbFkxVFZCZlp0ditscVRoZWxKa1JJRTk3MFdCbkowTWRuNFFEd0Q3?=
 =?utf-8?B?VjNlcDJLTGFjdzRUUU9ydEUrZU5mZ3dxYVJUZmFkeUw1NkFYM0pyalgyMFdX?=
 =?utf-8?B?UmcxakJ6S2tvT2pPdzl2S3hlVTNlV0prZ0l3czlnRFpOR3Y5TDdQY2hGbGRx?=
 =?utf-8?B?LzNJUmdrVVlvN2JtaGtCVlI1aWRIejdjOWRYZW5PbUFiaTRmU01CSHlmdVFq?=
 =?utf-8?B?UGxpcDdKejdYYkRyeU93bWV3QWhPRVgwWWZnVXhzYm10UnpvY3BrczVGSVky?=
 =?utf-8?B?SHVrNnBpcU1jNkZaSis2L3FXMXZzbDlwT3p3Q3VrdXUzNVlES1BDN2l0S2hO?=
 =?utf-8?B?UHE0YzZyZklLR1Q5ejdvUT09?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <C759BE860A4C9445B128DFB31C32DD2B@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR10MB1989.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3be3c2d2-a16f-4fa3-6110-08d93581e90e
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jun 2021 13:30:32.5573
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EpDuRwTWies+ew8CJ8dPXpnBmAfgg6nFHQcS1/jAthVzKZG0RK6TDWo2iRAgmlBtuHsWkEJlqy/eUUd27+59RQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1001MB2182
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10022 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 mlxscore=0
 spamscore=0 mlxlogscore=999 bulkscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2106220084
X-Proofpoint-ORIG-GUID: 4WP7AQUnKFhej905gkhmVWXrmDQ4yA_i
X-Proofpoint-GUID: 4WP7AQUnKFhej905gkhmVWXrmDQ4yA_i
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

DQoNCj4gT24gMjIgSnVuIDIwMjEsIGF0IDE1OjIwLCBIw6Vrb24gQnVnZ2UgPGhhYWtvbi5idWdn
ZUBvcmFjbGUuY29tPiB3cm90ZToNCj4gDQo+IFRoZSBzdHJ1Y3QgcmRtYV9pZF9wcml2YXRlIGNv
bnRhaW5zIHRocmVlIGJpdC1maWVsZHMsIHRvc19zZXQsDQo+IHRpbWVvdXRfc2V0LCBhbmQgbWlu
X3Jucl90aW1lcl9zZXQuIFRoZXNlIGFyZSBzZXQgYnkgYWNjZXNzb3INCj4gZnVuY3Rpb25zIHdp
dGhvdXQgYW55IHN5bmNocm9uaXphdGlvbi4gSWYgdHdvIG9yIGFsbCBhY2Nlc3Nvcg0KPiBmdW5j
dGlvbnMgYXJlIGludm9rZWQgaW4gY2xvc2UgcHJveGltaXR5IGluIHRpbWUsIHRoZXJlIHdpbGwg
YmUNCj4gUmVhZC1Nb2RpZnktV3JpdGUgZnJvbSBzZXZlcmFsIGNvbnRleHRzIHRvIHRoZSBzYW1l
IHZhcmlhYmxlLCBhbmQgdGhlDQo+IHJlc3VsdCB3aWxsIGJlIGludGVybWl0dGVudC4NCj4gDQo+
IEZpeGVkIGJ5IHByb3RlY3RpbmcgdGhlIGJpdC1maWVsZHMgYnkgdGhlIHFwX211dGV4IGluIHRo
ZSBhY2Nlc3Nvcg0KPiBmdW5jdGlvbnMuDQo+IA0KPiBUaGUgY29uc3VtZXIgb2YgdGltZW91dF9z
ZXQgYW5kIG1pbl9ybnJfdGltZXJfc2V0IGlzIGluDQo+IHJkbWFfaW5pdF9xcF9hdHRyKCksIHdo
aWNoIGlzIGNhbGxlZCB3aXRoIHFwX211dGV4IGhlbGQgZm9yIGNvbm5lY3RlZA0KPiBRUHMuIEV4
cGxpY2l0IGxvY2tpbmcgaXMgYWRkZWQgZm9yIHRoZSBjb25zdW1lcnMgb2YgdG9zIGFuZCB0b3Nf
c2V0Lg0KPiANCj4gVGhpcyBjb21taXQgZGVwZW5kcyBvbiAoIlJETUEvY21hOiBSZW1vdmUgdW5u
ZWNlc3NhcnkgSU5JVC0+SU5JVA0KPiB0cmFuc2l0aW9uIiksIHNpbmNlIHRoZSBjYWxsIHRvIHJk
bWFfaW5pdF9xcF9hdHRyKCkgZnJvbQ0KPiBjbWFfaW5pdF9jb25uX3FwKCkgZG9lcyBub3QgaG9s
ZCB0aGUgcXBfbXV0ZXguDQo+IA0KPiBGaXhlczogMmMxNjE5ZWRlZjYxICgiSUIvY21hOiBEZWZp
bmUgb3B0aW9uIHRvIHNldCBhY2sgdGltZW91dCBhbmQgcGFjayB0b3Nfc2V0IikNCj4gRml4ZXM6
IDNhZWZmYzQ2YWZkZSAoIklCL2NtYTogSW50cm9kdWNlIHJkbWFfc2V0X21pbl9ybnJfdGltZXIo
KSIpDQo+IFNpZ25lZC1vZmYtYnk6IEjDpWtvbiBCdWdnZSA8aGFha29uLmJ1Z2dlQG9yYWNsZS5j
b20+DQoNClNvcnJ5LCBub3QgbXkgZGF5LiBPdmVybG9va2VkIHRoZSBhY2Nlc3MgdG8gdGltZW91
dF9zZXQvdGltZW91dCBpbiAgY21hX3Jlc29sdmVfaWJvZV9yb3V0ZSgpLg0KDQpIYXZlIHRvIHNl
bmQgYSB2Mi4NCg0KDQoNCkjDpWtvbg0KDQo+IC0tLQ0KPiBkcml2ZXJzL2luZmluaWJhbmQvY29y
ZS9jbWEuYyB8IDE4ICsrKysrKysrKysrKysrKysrLQ0KPiAxIGZpbGUgY2hhbmdlZCwgMTcgaW5z
ZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvaW5m
aW5pYmFuZC9jb3JlL2NtYS5jIGIvZHJpdmVycy9pbmZpbmliYW5kL2NvcmUvY21hLmMNCj4gaW5k
ZXggZTNmNTJjNS4uNmI0MTUyNyAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9pbmZpbmliYW5kL2Nv
cmUvY21hLmMNCj4gKysrIGIvZHJpdmVycy9pbmZpbmliYW5kL2NvcmUvY21hLmMNCj4gQEAgLTI0
NTcsOCArMjQ1NywxMCBAQCBzdGF0aWMgaW50IGNtYV9pd19saXN0ZW4oc3RydWN0IHJkbWFfaWRf
cHJpdmF0ZSAqaWRfcHJpdiwgaW50IGJhY2tsb2cpDQo+IAlpZiAoSVNfRVJSKGlkKSkNCj4gCQly
ZXR1cm4gUFRSX0VSUihpZCk7DQo+IA0KPiArCW11dGV4X2xvY2soJmlkX3ByaXYtPnFwX211dGV4
KTsNCj4gCWlkLT50b3MgPSBpZF9wcml2LT50b3M7DQo+IAlpZC0+dG9zX3NldCA9IGlkX3ByaXYt
PnRvc19zZXQ7DQo+ICsJbXV0ZXhfdW5sb2NrKCZpZF9wcml2LT5xcF9tdXRleCk7DQo+IAlpZC0+
YWZvbmx5ID0gaWRfcHJpdi0+YWZvbmx5Ow0KPiAJaWRfcHJpdi0+Y21faWQuaXcgPSBpZDsNCj4g
DQo+IEBAIC0yNTE5LDggKzI1MjEsMTAgQEAgc3RhdGljIGludCBjbWFfbGlzdGVuX29uX2Rldihz
dHJ1Y3QgcmRtYV9pZF9wcml2YXRlICppZF9wcml2LA0KPiAJY21hX2lkX2dldChpZF9wcml2KTsN
Cj4gCWRldl9pZF9wcml2LT5pbnRlcm5hbF9pZCA9IDE7DQo+IAlkZXZfaWRfcHJpdi0+YWZvbmx5
ID0gaWRfcHJpdi0+YWZvbmx5Ow0KPiArCW11dGV4X2xvY2soJmlkX3ByaXYtPnFwX211dGV4KTsN
Cj4gCWRldl9pZF9wcml2LT50b3Nfc2V0ID0gaWRfcHJpdi0+dG9zX3NldDsNCj4gCWRldl9pZF9w
cml2LT50b3MgPSBpZF9wcml2LT50b3M7DQo+ICsJbXV0ZXhfdW5sb2NrKCZpZF9wcml2LT5xcF9t
dXRleCk7DQo+IA0KPiAJcmV0ID0gcmRtYV9saXN0ZW4oJmRldl9pZF9wcml2LT5pZCwgaWRfcHJp
di0+YmFja2xvZyk7DQo+IAlpZiAocmV0KQ0KPiBAQCAtMjU2Nyw4ICsyNTcxLDEwIEBAIHZvaWQg
cmRtYV9zZXRfc2VydmljZV90eXBlKHN0cnVjdCByZG1hX2NtX2lkICppZCwgaW50IHRvcykNCj4g
CXN0cnVjdCByZG1hX2lkX3ByaXZhdGUgKmlkX3ByaXY7DQo+IA0KPiAJaWRfcHJpdiA9IGNvbnRh
aW5lcl9vZihpZCwgc3RydWN0IHJkbWFfaWRfcHJpdmF0ZSwgaWQpOw0KPiArCW11dGV4X2xvY2so
JmlkX3ByaXYtPnFwX211dGV4KTsNCj4gCWlkX3ByaXYtPnRvcyA9ICh1OCkgdG9zOw0KPiAJaWRf
cHJpdi0+dG9zX3NldCA9IHRydWU7DQo+ICsJbXV0ZXhfdW5sb2NrKCZpZF9wcml2LT5xcF9tdXRl
eCk7DQo+IH0NCj4gRVhQT1JUX1NZTUJPTChyZG1hX3NldF9zZXJ2aWNlX3R5cGUpOw0KPiANCj4g
QEAgLTI1OTUsOCArMjYwMSwxMCBAQCBpbnQgcmRtYV9zZXRfYWNrX3RpbWVvdXQoc3RydWN0IHJk
bWFfY21faWQgKmlkLCB1OCB0aW1lb3V0KQ0KPiAJCXJldHVybiAtRUlOVkFMOw0KPiANCj4gCWlk
X3ByaXYgPSBjb250YWluZXJfb2YoaWQsIHN0cnVjdCByZG1hX2lkX3ByaXZhdGUsIGlkKTsNCj4g
KwltdXRleF9sb2NrKCZpZF9wcml2LT5xcF9tdXRleCk7DQo+IAlpZF9wcml2LT50aW1lb3V0ID0g
dGltZW91dDsNCj4gCWlkX3ByaXYtPnRpbWVvdXRfc2V0ID0gdHJ1ZTsNCj4gKwltdXRleF91bmxv
Y2soJmlkX3ByaXYtPnFwX211dGV4KTsNCj4gDQo+IAlyZXR1cm4gMDsNCj4gfQ0KPiBAQCAtMjYz
Miw4ICsyNjQwLDEwIEBAIGludCByZG1hX3NldF9taW5fcm5yX3RpbWVyKHN0cnVjdCByZG1hX2Nt
X2lkICppZCwgdTggbWluX3Jucl90aW1lcikNCj4gCQlyZXR1cm4gLUVJTlZBTDsNCj4gDQo+IAlp
ZF9wcml2ID0gY29udGFpbmVyX29mKGlkLCBzdHJ1Y3QgcmRtYV9pZF9wcml2YXRlLCBpZCk7DQo+
ICsJbXV0ZXhfbG9jaygmaWRfcHJpdi0+cXBfbXV0ZXgpOw0KPiAJaWRfcHJpdi0+bWluX3Jucl90
aW1lciA9IG1pbl9ybnJfdGltZXI7DQo+IAlpZF9wcml2LT5taW5fcm5yX3RpbWVyX3NldCA9IHRy
dWU7DQo+ICsJbXV0ZXhfdW5sb2NrKCZpZF9wcml2LT5xcF9tdXRleCk7DQo+IA0KPiAJcmV0dXJu
IDA7DQo+IH0NCj4gQEAgLTMwMTksOCArMzAyOSwxMSBAQCBzdGF0aWMgaW50IGNtYV9yZXNvbHZl
X2lib2Vfcm91dGUoc3RydWN0IHJkbWFfaWRfcHJpdmF0ZSAqaWRfcHJpdikNCj4gDQo+IAl1OCBk
ZWZhdWx0X3JvY2VfdG9zID0gaWRfcHJpdi0+Y21hX2Rldi0+ZGVmYXVsdF9yb2NlX3Rvc1tpZF9w
cml2LT5pZC5wb3J0X251bSAtDQo+IAkJCQkJcmRtYV9zdGFydF9wb3J0KGlkX3ByaXYtPmNtYV9k
ZXYtPmRldmljZSldOw0KPiAtCXU4IHRvcyA9IGlkX3ByaXYtPnRvc19zZXQgPyBpZF9wcml2LT50
b3MgOiBkZWZhdWx0X3JvY2VfdG9zOw0KPiArCXU4IHRvczsNCj4gDQo+ICsJbXV0ZXhfbG9jaygm
aWRfcHJpdi0+cXBfbXV0ZXgpOw0KPiArCXRvcyA9IGlkX3ByaXYtPnRvc19zZXQgPyBpZF9wcml2
LT50b3MgOiBkZWZhdWx0X3JvY2VfdG9zOw0KPiArCW11dGV4X3VubG9jaygmaWRfcHJpdi0+cXBf
bXV0ZXgpOw0KPiANCj4gCXdvcmsgPSBremFsbG9jKHNpemVvZiAqd29yaywgR0ZQX0tFUk5FTCk7
DQo+IAlpZiAoIXdvcmspDQo+IEBAIC00MDkyLDggKzQxMDUsMTEgQEAgc3RhdGljIGludCBjbWFf
Y29ubmVjdF9pdyhzdHJ1Y3QgcmRtYV9pZF9wcml2YXRlICppZF9wcml2LA0KPiAJaWYgKElTX0VS
UihjbV9pZCkpDQo+IAkJcmV0dXJuIFBUUl9FUlIoY21faWQpOw0KPiANCj4gKwltdXRleF9sb2Nr
KCZpZF9wcml2LT5xcF9tdXRleCk7DQo+IAljbV9pZC0+dG9zID0gaWRfcHJpdi0+dG9zOw0KPiAJ
Y21faWQtPnRvc19zZXQgPSBpZF9wcml2LT50b3Nfc2V0Ow0KPiArCW11dGV4X3VubG9jaygmaWRf
cHJpdi0+cXBfbXV0ZXgpOw0KPiArDQo+IAlpZF9wcml2LT5jbV9pZC5pdyA9IGNtX2lkOw0KPiAN
Cj4gCW1lbWNweSgmY21faWQtPmxvY2FsX2FkZHIsIGNtYV9zcmNfYWRkcihpZF9wcml2KSwNCj4g
LS0gDQo+IDEuOC4zLjENCj4gDQoNCg==
