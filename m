Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C6D33F4EC6
	for <lists+linux-rdma@lfdr.de>; Mon, 23 Aug 2021 18:54:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229674AbhHWQzK (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 23 Aug 2021 12:55:10 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:10614 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229471AbhHWQzI (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 23 Aug 2021 12:55:08 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.0.43) with SMTP id 17NEbYlI006594;
        Mon, 23 Aug 2021 16:54:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=YD24laKg9gmcjMTaFuxq8txchy3rM47AfT5ZmpBP4MM=;
 b=mJEP2QCuOPoUHVXyO3BbAbIJVVUaz9xF+cvg4AIAvit9bhl+DCaMqkC2YJ6UM7Ui7sp5
 DvgBxomg6WLhB/gfNWBTcAa2aaB7qvgTSpIFLUtYhlPeMYdBoTCGRodyMztW2DmFU+1X
 91pMMJQ6GLbLwROEupOf4JmvbNsf3XUCVaBNNt5XXIYvqORoVBGIV/BDQvxRnCwDX3O3
 XN/vsfDdwOt4Bdnn9Ol/wRKilIPSZYlsH7mVD/vzLvdHRGQyl4wSs3l1mktmWPRFh7vv
 UO7qOAEXMd0o0sZqKcfHFFoJXfrW495yoOb57Jg4rd0bdTffUkIxrOWm4XtJu34/6WqI 7A== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=YD24laKg9gmcjMTaFuxq8txchy3rM47AfT5ZmpBP4MM=;
 b=lys0M57Jd8JvvdpeaYb9qHQyv+ca++kraLVbQBCCM00tY3xUtF8Ijx3V/HeOlZdh+Vkt
 X1pyoI3G+KsQgElXPM0mKV6TdKlyUJcmHTeuDUMg5XANltFbFK7N8nVHUi1bE7R9E6D9
 MqoV5Hxj6pN/yPBzc4jdRTaSXgxoChXwfysbCOsoDuLcGVjGFNwCHWcCxs4fcymnHETL
 CtvWLnZDC35U/3BMu0Xtpyo4w805h9uDChSdMJNhYsqVU7CKAUF8sBMDrN1PiGZ/9FpD
 15Yn8h4GWMsjkr0APUXDpxoM8F5PRBUbZLUdPwn9TnnwquyqFxTtQq9TvOn5DGG4eYwu bg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3aktrtt6vj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 23 Aug 2021 16:54:20 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 17NGpDDB164120;
        Mon, 23 Aug 2021 16:54:19 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2171.outbound.protection.outlook.com [104.47.57.171])
        by aserp3020.oracle.com with ESMTP id 3ajsa3nxhc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 23 Aug 2021 16:54:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gNMJ+HU6Q3m0RJPlxWGlJ1oveQQYFLuG25rj3HCJMF74Znthd5N8A/omsR/ck8PhEy3osoZ6G/rPl/nXv+2D9n3DQGKBEqNk9EGYBNXtok0fYuSUXOmfihtmEHwHrLnlGva2qjUxVhszlxmWULbK29n5rq/K/KuqEVBXQ2g2uewLRcmdbQnWl4PIKHh95k2Sb8s+5YctJBDEzgHsCF91soTqClh4ABLIUYxJLqXM7qpTt8SXZNbVApRr3Ep+ndQlo2rI+SGkRpXozV3lkTgwlHSW8mSyUgNMaUNMbgFxkB7MyNbs2tqB3/jdv+9prp9pGv1k628kKNJH7eDUm9D6ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YD24laKg9gmcjMTaFuxq8txchy3rM47AfT5ZmpBP4MM=;
 b=h9rIket8+PtHlIdVSoDjO9/hqOOuZkoGJIbn61UMQYPDTkn0pn0eM/EnXUP28vE65GE4tTSx05Skxq1qALChwP4+s3NhpFkgY0rfj9pCBTt6dZ5g040OxOLY2P4wxRaq6c7yYfjFTXWA2fTmg1rQ6qC6QSEQ75bfE/74AgDk/Jzm90viS5sKdqpjoJ6BeTeBu0cC7onH3q4/ramaP25cVt5fqkA/5zlRQgw8bFyeBZXo6CQZfTrIUYb4JiplFn3t10Ias0cjJou1xDikmWIvpZevSs90jI9vHwq4Mspa249Hu5F0pEDL0fxNOydJeZsV19awV7yPgkcpw1XQjRPdhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YD24laKg9gmcjMTaFuxq8txchy3rM47AfT5ZmpBP4MM=;
 b=JFWCQ/ke4oR8aCprU/Eg4GBLq+L29ODz1mS0v8ZSOIouYZ/0Yu+D92a7cJveNQGCpbUwnnFQnp127/EtZ4fPWg02Z3rv1EhBesuN7IZInRErvjsiAjQDvZ6TZ8CoiuNEFhYf4F7GC93dyPbqEEmvrzNGi+ruPYVXRAryH/PnGVU=
Received: from DS7PR10MB4863.namprd10.prod.outlook.com (2603:10b6:5:297::17)
 by DM6PR10MB4057.namprd10.prod.outlook.com (2603:10b6:5:1d4::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19; Mon, 23 Aug
 2021 16:54:16 +0000
Received: from DS7PR10MB4863.namprd10.prod.outlook.com
 ([fe80::496:2301:77d9:de82]) by DS7PR10MB4863.namprd10.prod.outlook.com
 ([fe80::496:2301:77d9:de82%9]) with mapi id 15.20.4436.024; Mon, 23 Aug 2021
 16:54:16 +0000
From:   Haakon Bugge <haakon.bugge@oracle.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
CC:     Divya Indi <divya.indi@oracle.com>,
        LKML <linux-kernel@vger.kernel.org>,
        OFED mailing list <linux-rdma@vger.kernel.org>,
        Kaike Wan <kaike.wan@intel.com>,
        Gerd Rausch <gerd.rausch@oracle.com>,
        Srinivas Eeda <srinivas.eeda@oracle.com>,
        Rama Nichanamatlu <rama.nichanamatlu@oracle.com>,
        Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leon@kernel.org>
Subject: Re: [PATCH v4] IB/sa: Resolving use-after-free in ib_nl_send_msg
Thread-Topic: [PATCH v4] IB/sa: Resolving use-after-free in ib_nl_send_msg
Thread-Index: AQHXmD+ApxeC7LUgeE645hjC9dbb7w==
Date:   Mon, 23 Aug 2021 16:54:16 +0000
Message-ID: <842DBB6A-9563-4629-B829-329DD344284E@oracle.com>
References: <1592964789-14533-1-git-send-email-divya.indi@oracle.com>
 <20200702190738.GA759483@nvidia.com>
 <d078d705-9930-7abd-84c8-9b7d41aad722@oracle.com>
 <20200708011227.GM23676@nvidia.com>
In-Reply-To: <20200708011227.GM23676@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
authentication-results: nvidia.com; dkim=none (message not signed)
 header.d=none;nvidia.com; dmarc=none action=none header.from=oracle.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 753e91cb-a125-4137-d296-08d96656a4d2
x-ms-traffictypediagnostic: DM6PR10MB4057:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR10MB40579402D29DBDA24352ACFDFDC49@DM6PR10MB4057.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: c767kVqjcks2TXssp31yVZmND5CiusBc4KBOh+6OEOtQOotAHzZSecTycIWLblWLTMwO/zncC7RETNrsYLXT/EbNd+78UG5L638XhTYBOlt7fss2nq4A2mb86QfgLKi6nuVfdJAkdYROXoSLZfPct5K7i2dmwQEsIgj9FJCm8Huq4DQrZz/40ZPVJsfqPXnEXPD5SyDc9Ozcd6/R7RixoBk1OsVg/OicXj9SpI/dnkhseG87xTolF8FgMlLN4wQTihwwO/ZJMpuumwD3BLyrNO2QPvFidATiuBJCSGq702v/hPJh4iK47nXAFK/V3A2ofE4sTg2ZRv2h8VXOddXlGK1l4VQkKJCI5YpLd3bQhdIlnpu6xAQ7MU1vdth+Tvps/O3ikVrYrwATfDAp/dj8eH9Z5yPM9k0aZD1YW6ZmjCXyoMsi1L+oIQPgK4NJZ2VNaT4KNHnzLjW01/H+qKNGp0uzNM0LPibVYBP/aX9eTsnDekSdU5ZC+lY8X+wyrIrW3HH3MaawwyBLPhXg7wIuJZET7x5DQ8reR1SuN5edmxOXBkuYyGHdswL1nvEHQLTM7bfEo37i0vGuzW4a35hYa/TnVjjHoJe1fvVm+/1fWHG9H8T2vevFYW4ZXyeLLqZHUcRL7mnf551CPR2ZHa91wYC3mpaGvC0pgSYsIMuaNCwV2+m6tuwacoX80d9A58GTvgBOmwYaYJ572I+UPx8JVDDkarz0GwQpVP7YmY1JjfL1xowoPFrslbpQLUpu5XDii2q9OE0G8gf61gQMaOLJEzDOy1XSzKmvYPOaJSFC24xvDPo5bNLF6Mv6/18ooZna
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB4863.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(6512007)(4326008)(186003)(26005)(71200400001)(8676002)(6916009)(5660300002)(66574015)(53546011)(6506007)(91956017)(76116006)(966005)(66946007)(122000001)(83380400001)(38100700002)(38070700005)(316002)(6486002)(33656002)(86362001)(2906002)(36756003)(2616005)(8936002)(66556008)(66446008)(44832011)(66476007)(64756008)(54906003)(508600001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ay9VL25JeVFNSStzRjZWU2RaYzVzYS9tQVFpT0VHYnhqZnhnQ3NUdkhQUmkr?=
 =?utf-8?B?RXZaRWFUR2hjZnR5Zk1xbVpSeFJ4MU5zU0pnazZxTXcwR2EwVWlMRU9GSk1i?=
 =?utf-8?B?L0VCai95cjQwblZROTFWaGRLc0M3cFRnSXFVZmJSWGlKcjJpZGZhYWdyT1ZL?=
 =?utf-8?B?SGpZdGIwT1Q4Nno2S3R3TW1tdHlZU0tZOEFRN25sRzRYUVNDTTBraUhJRnN3?=
 =?utf-8?B?NDlrVmZ2d2M4NW5URWRmZklFazRZVFlJRlNYcmhDSXZzaE1PNVAxdE83UmFm?=
 =?utf-8?B?dmZXaHp6Z3V1YWkwc3ZLMDJPdWtyTnRIVWFINXdrNmtmRW81Vkl2V2RlMnZr?=
 =?utf-8?B?M0NXZkRmSENKNDZOR2VSMWFpd3piY2ZyL2wwMDBObWM2UHhSdW1uc3g3UERS?=
 =?utf-8?B?SHdNSmFKdjlVSFZrM0t3RG5jTWduc3ArUnh5dDFiVXNxNGNrN0VCejNVOUc3?=
 =?utf-8?B?UDFPdzRlcXprZ3ZhNVZhM0oyM0padEFKcGN2cHBQcEg2RzdPV3lDY2w4SGZq?=
 =?utf-8?B?U1FsL0p2V1hvaUZQQUpqbFloWHdaQzhjWVowbWo0NUtxQmh0NUREaElsYm1o?=
 =?utf-8?B?dk9lRDllR2prNWVGaG05a25ONmVWN3VsdTJRZ2tPYmhNTjlZU2hTU3p0KytJ?=
 =?utf-8?B?Qlo5K2V5YVFPeDRxWURaSlhDd28vVmRKTzllTnQ5OGFNVVowRmM0NzJsTjhZ?=
 =?utf-8?B?L3YybmRLMGdONlVOWlY4NSt5SWxJTDlXMXFwQjk5UTlLM0I2cUswTHhBRXNu?=
 =?utf-8?B?dDBRVkFQT2NtR0psMmhLSHA0OU9sTy93Y3FEVmJSUEN2bElMZ1RQV1RiSGRE?=
 =?utf-8?B?dVNKNERXWk1oRUY3ZFdBMkxRVTc0clhiVDdldEVVQ3p0SWp4dDFxOENpdlpw?=
 =?utf-8?B?Tm1yRkdNSkJXelQ3ZVhlMnZkZS9oZkFQeEJsY2MxYXdqVTJXdDVsMEdBcHNh?=
 =?utf-8?B?MDBveUhaa2RXOGZsT0E3SHd1dmd2M1dvUW01bWlzL2RVQjAxMW9mQTBLNWx2?=
 =?utf-8?B?bisxZ0ZncnYyMFBrbVFRWkdaY1BpNmw0WmRaNSsxalRTbGFnWm5qb0Y5MEVN?=
 =?utf-8?B?QlRmb1lCUnhObTVBY2pvdXBja3VHQVRJZ3JLOHJqRmlRYU03cGVVSFVEOWxo?=
 =?utf-8?B?RHVFNXZXcWU1NWlab2J4U3lPMnJkVHNLdm1mUk8rNlFCTjNaNU03TWwybTJZ?=
 =?utf-8?B?MGhyZjNHYVAyU0xUR01UVUdIZ3RJTkYrTTNyVlcwTEtXclc4bStBaWt6TUhP?=
 =?utf-8?B?aTNQUkNvckw0cmRDdUZiZVplU01Vd1FxblBqeFBhMm9YQ01BQXUzNFNIejNT?=
 =?utf-8?B?L3dLSFNzeFhHTnNaZHZqdEJUQUF4U1pZdEVNK1cxeEFLZHpRUEZnNnRDQ1Rv?=
 =?utf-8?B?NTVMR3BPTDk4NDhrTVJmMkRWVS9ESFZNK2IrR2tiRTlpOW1RV1JOb2NDc1Yx?=
 =?utf-8?B?TkFSUlJHRGtxNGx1bDRkRnQ0ZWg5Q2JlVndKOFR6MDNmZ1p4WjB1dnN0MDl5?=
 =?utf-8?B?RGFVQW1tclVCbFk2eWFqK3lOWjhUZDFOS2N3LzBpRDlCeEw1ZWNsUCtIMlgw?=
 =?utf-8?B?WTFiVHpzOUFWeiswUUpaQy91clR3cWhkSGJ1VkxvR3hXdytoUUNhTEh5NWNZ?=
 =?utf-8?B?L3dMY25nK1M5WWZidW91dFVpWWY5M2M2L0hMODhiNVpWRENsdm9ZNzdTdXFx?=
 =?utf-8?B?YzV0aVRJcEdvQzE1TEpySGlnN3N2YWlFNlkxZFhTUzRvUXlCb1ExUU5VOTNK?=
 =?utf-8?B?OFFxMHkySDNidXJZT2FoMFBDWnM4N3J0MDZKdUszTW1GNjRraWZWM2x5Rk9Q?=
 =?utf-8?B?ZW1TaGd4aTRTYlVPaW1Ndz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <08496BA21A194C449C17A31983580A9A@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB4863.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 753e91cb-a125-4137-d296-08d96656a4d2
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Aug 2021 16:54:16.5975
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8dcbWMyLZKpdPXdRwSUwcgnJPIEnh8VO9aOPA4XLLVWxnwrFl/UBPtU6Pntu/0GcAVBafr4CCGwbNK6eKtlYGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4057
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10085 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0
 mlxlogscore=999 bulkscore=0 mlxscore=0 adultscore=0 malwarescore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2108230115
X-Proofpoint-GUID: hImjiyBuJKy-ew5F17pJtpi5bwNCB-5V
X-Proofpoint-ORIG-GUID: hImjiyBuJKy-ew5F17pJtpi5bwNCB-5V
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

DQoNCj4gT24gOCBKdWwgMjAyMCwgYXQgMDM6MTIsIEphc29uIEd1bnRob3JwZSA8amdnQG52aWRp
YS5jb20+IHdyb3RlOg0KPiANCj4gT24gVHVlLCBKdWwgMDcsIDIwMjAgYXQgMDY6MDU6MDJQTSAt
MDcwMCwgRGl2eWEgSW5kaSB3cm90ZToNCj4+IFRoYW5rcyBKYXNvbi4NCj4+IA0KPj4gQXBwcmVj
aWF0ZSB5b3VyIGhlbHAgYW5kIGZlZWRiYWNrIGZvciBmaXhpbmcgdGhpcyBpc3N1ZS4NCj4+IA0K
Pj4gV291bGQgaXQgYmUgcG9zc2libGUgdG8gYWNjZXNzIHRoZSBlZGl0ZWQgdmVyc2lvbiBvZiB0
aGUgcGF0Y2g/DQo+PiBJZiB5ZXMsIHBsZWFzZSBzaGFyZSBhIHBvaW50ZXIgdG8gdGhlIHNhbWUu
DQo+IA0KPiBodHRwczovL2dpdC5rZXJuZWwub3JnL3B1Yi9zY20vbGludXgva2VybmVsL2dpdC9y
ZG1hL3JkbWEuZ2l0L2NvbW1pdC8/aD1mb3ItcmMmaWQ9ZjQyN2Y0ZDYyMTRjMTgzYzQ3NGVlYjQ2
MjEyZDM4ZTZjNzIyM2Q2YQ0KDQpIaSBKYXNvbiwNCg0KDQpBdCBmaXJzdCBnbGFuc2UsIHRoaXMg
Y29tbWl0IGNhbGxzIHJkbWFfbmxfbXVsdGljYXN0KCkgd2hpbHN0IGhvbGRpbmcgYSBzcGlubG9j
ay4gU2luY2UgcmRtYV9ubF9tdWx0aWNhc3QoKSBpcyBjYWxsZWQgd2l0aCBhIGdmcF9mbGFnIHBh
cmFtZXRlciwgb25lIGNvdWxkIGFzc3VtZSBpdCBzdXBwb3J0cyBhbiBhdG9taWMgY29udGV4dC4g
cmRtYV9ubF9tdWx0aWNhc3QoKSBlbmRzIHVwIGluIG5ldGxpbmtfYnJvYWRjYXN0X2ZpbHRlcmVk
KCkuIFRoaXMgZnVuY3Rpb24gY2FsbHMgbmV0bGlua19sb2NrX3RhYmxlKCksIHdoaWNoIGNhbGxz
IHJlYWRfdW5sb2NrX2lycXJlc3RvcmUoKSwgd2hpY2ggZW5kcyB1cCBjYWxsaW5nIF9yYXdfcmVh
ZF91bmxvY2tfaXJxcmVzdG9yZSgpLiBBbmQgaGVyZSBwcmVlbXB0X2VuYWJsZSgpIGlzIGNhbGxl
ZCA6LSgNCg0KTm93LCB0aGlzIGNvdWxkIGJlIGZpeGVkIGJ5IGNhbGxpbmcgcmRtYV9ubF9tdWx0
aWNhc3QoKSBvdXRzaWRlIHRoZSBzcGlubG9jayBhbmQgaW5zdGVhZCBpbnNlcnQgdGhlIHJlcXVl
c3QgaW50byB0aGUgdGltZW91dCBsaXN0IGluIGEgc29ydGVkIGZhc2hpb24uDQoNCkJ1dCB0aGUg
bWFpbiBwcm9ibGVtIGhlcmUgaXMgdGhhdCBpYl9ubF9tYWtlX3JlcXVlc3QoKSBjYW4gYmUgY2Fs
bGVkIGZyb20gYW4gYXRvbWljIGNvbnRleHQsIGZvciBleGFtcGxlIGZyb206DQoNCm5laWdoX3Jl
ZnJlc2hfcGF0aCgpICAodGFrZXMgYSBzcGluIGxvY2spID09Pg0KICAgIHBhdGhfcmVjX3N0YXJ0
KCkgPT0+DQogICAgICAgIGliX3NhX3BhdGhfcmVjX2dldCgpID09Pg0KICAgICAgICAgICAgc2Vu
ZF9tYWQoKSA9PT4NCiAgICAgICAgICAgICAgICBpYl9ubF9tYWtlX3JlcXVlc3QoKSA9PT4NCg0K
SGVyZSdzIHRoZSBzdGFjayB0cmFjZSAobm90IG5ld2VzdCB1cHN0cmVhbSwgYnV0IEkgcHJldHR5
IHN1cmUgdGhlIHNhbWUgcHJvYmxlbSBpcyB0aGVyZSk6DQoNCjxJUlE+DQpxdWV1ZWRfc3Bpbl9s
b2NrX3Nsb3dwYXRoKzB4Yi8weGYNCl9yYXdfc3Bpbl9sb2NrX2lycXNhdmUrMHg0Ni8weDQ4DQpz
ZW5kX21hZCsweDNkMi8weDU5MCBbaWJfY29yZV0NCj8gaXBvaWJfc3RhcnRfeG1pdCsweDZhMC8w
eDZhMCBbaWJfaXBvaWJdDQppYl9zYV9wYXRoX3JlY19nZXQrMHgyMjMvMHg0ZDAgW2liX2NvcmVd
DQo/IGlwb2liX3N0YXJ0X3htaXQrMHg2YTAvMHg2YTAgW2liX2lwb2liXQ0KPyBkb19JUlErMHg1
OS8weGUzDQpwYXRoX3JlY19zdGFydCsweGEzLzB4MTQwIFtpYl9pcG9pYl0NCj8gaXBvaWJfc3Rh
cnRfeG1pdCsweDZhMC8weDZhMCBbaWJfaXBvaWJdDQppcG9pYl9zdGFydF94bWl0KzB4MmIwLzB4
NmEwIFtpYl9pcG9pYl0NCmRldl9oYXJkX3N0YXJ0X3htaXQrMHhiMi8weDIzNw0Kc2NoX2RpcmVj
dF94bWl0KzB4MTE0LzB4MWJmDQpfX2Rldl9xdWV1ZV94bWl0KzB4NTkyLzB4ODE4DQo/IF9fYWxs
b2Nfc2tiKzB4YTEvMHgyODkNCmRldl9xdWV1ZV94bWl0KzB4MTAvMHgxMg0KYXJwX3htaXQrMHgz
OC8weGE2DQphcnBfc2VuZF9kc3QucGFydC4xNisweDYxLzB4ODQNCmFycF9wcm9jZXNzKzB4ODI1
LzB4ODg5DQo/IHRyeV90b193YWtlX3VwKzB4NTkvMHg0ZjENCmFycF9yY3YrMHgxNDAvMHgxYzkN
Cj8gd2FrZV91cF93b3JrZXIrMHgyOC8weDJiDQo/IF9fc2xhYl9mcmVlKzB4OWIvMHgyYmENCl9f
bmV0aWZfcmVjZWl2ZV9za2JfY29yZSsweDQwMS8weGIzOQ0KPyBkbWFfZ2V0X3JlcXVpcmVkX21h
c2srMHgyOC8weDMxDQo/IGlvbW11X3Nob3VsZF9pZGVudGl0eV9tYXArMHg1Mi8weGRiDQo/IGlv
bW11X25vX21hcHBpbmcrMHg0YS8weGQxDQpfX25ldGlmX3JlY2VpdmVfc2tiKzB4MTgvMHg1OQ0K
bmV0aWZfcmVjZWl2ZV9za2JfaW50ZXJuYWwrMHg0NS8weDExOQ0KbmFwaV9ncm9fcmVjZWl2ZSsw
eGQ4LzB4ZjYNCmlwb2liX2liX2hhbmRsZV9yeF93YysweDFjYS8weDUyMCBbaWJfaXBvaWJdDQpp
cG9pYl9wb2xsKzB4Y2QvMHgxNTAgW2liX2lwb2liXQ0KbmV0X3J4X2FjdGlvbisweDI4OS8weDNm
NA0KX19kb19zb2Z0aXJxKzB4ZTEvMHgyYjUNCmRvX3NvZnRpcnFfb3duX3N0YWNrKzB4MmEvMHgz
NQ0KPC9JUlE+DQpkb19zb2Z0aXJxKzB4NGQvMHg2YQ0KX19sb2NhbF9iaF9lbmFibGVfaXArMHg1
Ny8weDU5DQpfcmF3X3NwaW5fdW5sb2NrX2JoKzB4MjMvMHgyNQ0KcGVlcm5ldDJpZCsweDUxLzB4
NzMNCm5ldGxpbmtfYnJvYWRjYXN0X2ZpbHRlcmVkKzB4MjIzLzB4NDFiDQpuZXRsaW5rX2Jyb2Fk
Y2FzdCsweDFkLzB4MWYNCnJkbWFfbmxfbXVsdGljYXN0KzB4MjIvMHgzMCBbaWJfY29yZV0NCnNl
bmRfbWFkKzB4M2U1LzB4NTkwIFtpYl9jb3JlXQ0KPyBjbWFfYmluZF9wb3J0KzB4OTAvMHg5MCBb
cmRtYV9jbV0NCmliX3NhX3BhdGhfcmVjX2dldCsweDIyMy8weDRkMCBbaWJfY29yZV0NCj8gY21h
X2JpbmRfcG9ydCsweDkwLzB4OTAgW3JkbWFfY21dDQo/IHJpbmdfYnVmZmVyX2xvY2tfcmVzZXJ2
ZSsweDEyMC8weDM0ZA0KPyBrbWVtX2NhY2hlX2FsbG9jX3RyYWNlKzB4MTZmLzB4MWNkDQpyZG1h
X3Jlc29sdmVfcm91dGUrMHgyODcvMHg4MTAgW3JkbWFfY21dDQo/IGNtYV9iaW5kX3BvcnQrMHg5
MC8weDkwIFtyZG1hX2NtXQ0KcmRzX3JkbWFfY21fZXZlbnRfaGFuZGxlcl9jbW4rMHgzMTEvMHg3
ZDAgW3Jkc19yZG1hXQ0KcmRzX3JkbWFfY21fZXZlbnRfaGFuZGxlcl93b3JrZXIrMHgyMi8weDMw
IFtyZHNfcmRtYV0NCnByb2Nlc3Nfb25lX3dvcmsrMHgxNjkvMHgzYTYNCndvcmtlcl90aHJlYWQr
MHg0ZC8weDNlNQ0Ka3RocmVhZCsweDEwNS8weDEzOA0KDQoNCkhvdyBzaGFsbCB0aGlzIGJlIGF0
dGFja2VkPw0KDQoNClRoeHMsIEjDpWtvbg0KDQogICAgICAgICAgICAgICAgICAgIA0KICAgIA0K
DQoNCg==
