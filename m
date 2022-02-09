Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE1054AF52C
	for <lists+linux-rdma@lfdr.de>; Wed,  9 Feb 2022 16:25:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234491AbiBIPZv (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 9 Feb 2022 10:25:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235800AbiBIPZr (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 9 Feb 2022 10:25:47 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7471C0613C9;
        Wed,  9 Feb 2022 07:25:50 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 219EkT35020152;
        Wed, 9 Feb 2022 15:25:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=U32QqwDyhWJdb9CZHJsfF9/n/zF9LnOm9tzd1W3kxD4=;
 b=yocaVGQmF2FCcGc+OEOSAK6aoWsm5rImwJ7pCFBKsYJ8pnmQaq44ROYmupDWIhNnsLj8
 HwQ6DbQrGCjneG0vQOjJaX5tVv71rm1vrWMkGp0S4JBMOOCrz2v1M3PNvwplbfbh1zPi
 rTPE6MAUvS9bxS5eg11pOlgYaEjn7I9Fzll4DDzOQ+OdK6vuBmnMakw1DFsRzi/lOQlJ
 bas26UWRoVk/iFtqM4GcGlnY0xC97qELgXJqBtmSI2ODNFuga7JWpp8OTGnyGec9RsH9
 uUm75BI50dqrEQ65qm0kzWb1g8KttE0/3HS9lFzaoI1MSwGn/r2O2j4hJnKVLGlvsS5r EQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3e366wx82m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 09 Feb 2022 15:25:41 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 219FH01g022949;
        Wed, 9 Feb 2022 15:25:40 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2175.outbound.protection.outlook.com [104.47.56.175])
        by userp3020.oracle.com with ESMTP id 3e1jpt4r7c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 09 Feb 2022 15:25:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EySerAXGZaEAq6uqiaQ8rBAu4jm8an5Ya/5C03HDyvZyPXYAE1NVJFVlVH/oAadhF/U/HR1JS/4QhayCZkjI2MoQiS2fuzuwDhscY8GFJnHGxki2sfqfL4FLac1HVFnsPZzhTnvBQLT2KtoKOPvrycEStiZIxEOoXIY1iRMb31RKsqIYHf11Mg3EGP7SQtlBdvctEITGggNFpzDe13Yor5XF0e4IVQ2xvcWJRPOw6ggUf2h4vTUuwg+9b1h8TLnKrZDaEdwpnJFoPp7kY/5czp120R8mGOaeDbxQuK7g1nIbEu212prMijTQcK+CLhgqCDy/gLcFTr563v7WmBIKiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U32QqwDyhWJdb9CZHJsfF9/n/zF9LnOm9tzd1W3kxD4=;
 b=OlrK1OQZg0SUfKuovjbnc5Yt4+XGrVqOBzRXvSf4LE5i0JG1F/+SZ3/LUeV5JJuOhnlVwyUPSIYxWNV8hFk9myH2FB+JW6DxiYvIOLjXmwoDHLzNr5gCWFYbz1Ijcaip/Pb2vyMEmg9R1gdacwfOPFx5bUdCnABAI6PQbeHtG5lE0bXgyaGoUJkJbCDtSMFtA98KeOOk0ewJGDv5N4D1PKw9IfQDp4TTkivxsuZRB+PI9uYkvNvdzqYw2Ur1xJMIcNCi+Nyh7ShFDZ+ibXpUa4yOv9XZ3gBaI3HkkfjVuUTrCPSqviH9qVNkwZ48b08gGiRF3vXvBWYUBt0JbkTiYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U32QqwDyhWJdb9CZHJsfF9/n/zF9LnOm9tzd1W3kxD4=;
 b=uLg/IzLylTOQpijjMaYeA7Wd9FGnTM/b/g2d8Jip16QmeAzQB1TpcKWxbSKLkeVxBWBHgocLfdJAHJxIgdOH0pmc3cCQPnM9KVu0pPtI54HrSHB0YEU3pT9avr2Ki8d5fvQLm/lE4gZn0rNEYvWQFI3cuXhhBF0uKsEU+3aE4HY=
Received: from SJ0PR10MB5600.namprd10.prod.outlook.com (2603:10b6:a03:3dc::12)
 by CH0PR10MB5387.namprd10.prod.outlook.com (2603:10b6:610:c9::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.17; Wed, 9 Feb
 2022 15:25:38 +0000
Received: from SJ0PR10MB5600.namprd10.prod.outlook.com
 ([fe80::5b6:33a0:d015:36a5]) by SJ0PR10MB5600.namprd10.prod.outlook.com
 ([fe80::5b6:33a0:d015:36a5%3]) with mapi id 15.20.4951.019; Wed, 9 Feb 2022
 15:25:38 +0000
From:   Haakon Bugge <haakon.bugge@oracle.com>
To:     Leon Romanovsky <leon@kernel.org>
CC:     Jason Gunthorpe <jgg@ziepe.ca>,
        OFED mailing list <linux-rdma@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH for-rc] IB/cma: Allow XRG INI QPs to set their local ACK
 timeout
Thread-Topic: [PATCH for-rc] IB/cma: Allow XRG INI QPs to set their local ACK
 timeout
Thread-Index: AQHYHbg0ihvWiMLSzk2dMUKcOGRKHKyLURsAgAAGCIA=
Date:   Wed, 9 Feb 2022 15:25:38 +0000
Message-ID: <E24B4423-2BAC-4391-826C-C948CB367871@oracle.com>
References: <1644412980-28424-1-git-send-email-haakon.bugge@oracle.com>
 <YgPX4lxiNcT7Gx9t@unreal>
In-Reply-To: <YgPX4lxiNcT7Gx9t@unreal>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3693.40.0.1.81)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ac0b5521-7b86-4e97-16a3-08d9ebe06cfb
x-ms-traffictypediagnostic: CH0PR10MB5387:EE_
x-microsoft-antispam-prvs: <CH0PR10MB538733E5337AA086D7522643FD2E9@CH0PR10MB5387.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uQez2Fh2KYgXeL0fnKu2TFCIgYcwK8D28tHjD0JUMCEzE8/ypsDG3FCjrFo2XavgSMRpzhEew22nXUEcXklDVRzKtnt960Ar61CwfuMHGWzFG9TqoMul8wzX+blUUtr/CauffRYIOgQgMsc68HQPBPXdCpGA4KV1qkwWF+u9i245lYPA4hBAjBQg+by7Nvn0xOSYWrKncD2OLrAGlTlYdBR85NxUkgk7aMWKKOza2d8ou67nSx7crOhcQgOtUTEASAT76yaejrSEk9s1pRMsRcbzRrU2leZQia6MQO8qBnlNptQjh+u6qnzzm23RGzlvbFc+3WFtXG5dL3td1HnKu0uqS+ztddIaxttojqGgyQsCAMNbHX5JB196eTytUODb9S9DxfdP/08VAHe7DB0X6Y/OIRnBRaCoFCDYowrQU2HMwIB0KoiSm1ec7JWMLjaTLBp8bkRLEoxiDJIZ3o1UJ1NiRlPviHVT1Fz3LEK2UfsqJLIWtC7KLSGcKp+NZ4h9hAsJIxM0g5MvpoO98H+ZZ5QHAH8ueJNobNM1yGzifPBRFccMaETxGWcSEMGuWyKKWkL1abu0QR3sKQkx8ZqLRN0ZXAZAjHXoRyAwCPAfouHd3ELEuRByTRpw7vofAbgk94QAgqrHhQyxVgPN7wEx9cGU9QBb+s6l1E/J7QgfV1OfXuZlrxtuClwTogP33WwifoDeOHzkoftC4rw5Py3qdx4yXaGEdIdwta/HSdEXdxR+ni55QE0/yOVyi9/+nuZs1LNg+wvnOOm0c2a0m8n35Crf3gJjQqnLMQ3tOQe6R+fTklFc8nY9rVguMa0IvcgncNP6vh6a0ke00AcRbeFHIA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5600.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(26005)(44832011)(66574015)(83380400001)(122000001)(4326008)(966005)(186003)(2906002)(36756003)(38100700002)(6916009)(5660300002)(53546011)(6506007)(76116006)(71200400001)(54906003)(33656002)(508600001)(2616005)(66946007)(66556008)(64756008)(66446008)(91956017)(6512007)(8936002)(316002)(66476007)(38070700005)(86362001)(6486002)(8676002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?L2IwWi9mV0dpZ1lPN0hCMlUwaVB4MzVmN2djTXZMMEJOVit5S3NmTlhMa0xE?=
 =?utf-8?B?cUY2S1d5UzN4dUZnWW1iRFUvVGZvVWVrMFAvZURLMjhlUGltKzlwYm9oQmdY?=
 =?utf-8?B?KzlBcjVmWTVFaEtMME8zNmdVZ2JYNEprbFVVSVNWdTljUWFoMHBMOXFMTkVr?=
 =?utf-8?B?L1pLOS92S1V2M2FzTEptL1M3c2lkMmZ1em02UG9qSFpTcHdQOStxYm14Z2Ny?=
 =?utf-8?B?SzYrSXJneTJ5cGRTM3N6TndDdTR2a01nbEp2bHR0eFN3THQyc3hsbDZCYmRP?=
 =?utf-8?B?VzdENGFWeldIdjNpZnpiZVdyWEIxNXI5SEwyZU9qbmF3bENoRmRYRUp4d0pM?=
 =?utf-8?B?amZDcFgwYlFDS2RpK1hDMWdEZExZYUpPR2h4a1ZQZVpXN0dKOTlYTXF3aVlm?=
 =?utf-8?B?UDN1bS9CL3lIWDdKRFQ3M0Q2TWRXb0JERWdYaVppb0c2N2E5UE9heFVtQ2tx?=
 =?utf-8?B?bWJqRnVXUnFCYlEwZm9mOXJ5azZUSXdzTUhKeXlJT0g2UE9KVmI1NXUxbTdE?=
 =?utf-8?B?VmsrMkpjTVRYQkpIT1B1Z3NJVGVEMFRBZFppNWZQL1ZFSWxxVUhUSzdyZEk4?=
 =?utf-8?B?aG4zRUk1UWlJVEFlL05GNkVHRDEzQW5LM2pRS21tOXAxRmtVTkZQZmpnbG5q?=
 =?utf-8?B?RkpMeWhxTzMyck55NW12TWZaRWVWS3lTbEwrenBKQXhZVC9ncDIwb3U5ck1N?=
 =?utf-8?B?UzFJNWc4MGl4YytubUl0emxhVE1nMWZSUHNtaUZpeVNPZlhMdmRORTZKdlpK?=
 =?utf-8?B?OFlyOGlhdDYyYkREM29IbUJXeTRubVV6eHJqZlh1SWZsV241TEpaaHZBaWJG?=
 =?utf-8?B?Q2l5RVFaTlFsMlZMRFNCK0w3OFdvcVZMNkNoVk5vL1E2NVhnYzRwVngwS09H?=
 =?utf-8?B?WW1TcnEzY1N4VzlEMEFCNDhHSEE2am9iNGl6QU9SY0RHaHBnQjl4bWF6M0RD?=
 =?utf-8?B?azhrL1BGTmZRbHdTZGhMZmNxYTIzQ0krdkh4Z3JHTm01aFV0KzM1MUNZVmIv?=
 =?utf-8?B?d1lwb0NUM1V1VDFTZG1SOTNrbWZpVnFBbUswYTg1WG1MYWViV0NNcnlPdHhi?=
 =?utf-8?B?RkYxWGlmWUtEWVB0WmxXcFhpMjFWS1dna2pKbVFYSUtmbHVnZnNqQ1dTRjZJ?=
 =?utf-8?B?OUc5ZEd0aVAwKzlPRW9RazljT0QwTHZiWGtWMGdyQWR5dlpEelpqZWZlbnUx?=
 =?utf-8?B?am5mVFA5NWVoeC9kc2tYY09nK3RpOUVSTk1iZ0FtZW9oVTRjZElPdDJVVVd4?=
 =?utf-8?B?MzlBYi9jUy85UURkQnlIbTlDNWwvbU01K0xQV2w1NGtVUXRFWUk3dXhZeWFu?=
 =?utf-8?B?OGpmMkZ2UGpvSzNhS3FmcEY0SXYvcE9TRmhPbE1QZVp5SHU5VDBaOGc5c3Nx?=
 =?utf-8?B?b2dqL2dLNTBiNUxUK0J1TVROeVZNSyt3dlFSb2ZPMllpVXM2QmhsTHg1cGZk?=
 =?utf-8?B?UG5tbFFKbjdZMXYyMHRRV1c4YVYzRjlHSUxGYTNXU3VKMkdTY3ZpenJrOXA5?=
 =?utf-8?B?R0UydjBYSEM2U0FDL1ZEb284WTdzdmtoMGlrUDdoWE9WNTNQOEU1eVlDVHBY?=
 =?utf-8?B?RnJPYmMwejZEYmZvUlgxOHNkeG9RTlVGNjVGb1BGUUJSUnVWMzVxb0FyS3Fa?=
 =?utf-8?B?R1J0NG5JRytUMUE0ZlV0SUtnNXRUOW5JMHhNdnJ0eG83NUtBeEJkZmN6bm5E?=
 =?utf-8?B?ZTFoRFdaeHA3Z3Rkc1V1bWJCQWNFNnRSaklreVk3Tmsvam1RS0s3UGpnRUg3?=
 =?utf-8?B?UXBRcmZmaFJrQ1hmZ2Q2aTNaQ256R0gvSWVDWGlZZ2U1RkwyQlB1UjkwTzBP?=
 =?utf-8?B?cnVuUTRtdXkvd0RpVjBTOXhzeUVsTy9DbkcrT0RvWUd3OWZtcVcyRS9wamZE?=
 =?utf-8?B?Y1krWStOSTJmdmE5V2Q0TU0yeWkrRDJHaUJyR0JyTlI2M1A5U2RmSkxrQ0Ns?=
 =?utf-8?B?d3NqaHk4dUl5ZkZQSW04eXIycWo1eHZTd3hqL092cS9uSTcvSnV2TXNRM2pt?=
 =?utf-8?B?SFhrdVkvMlo3d3EwdGtyMCt3eXhYaDJ0VWN1YnNFd1pGUzNBKzZOKy91bUZ5?=
 =?utf-8?B?TU1hZWxVeDg2YW9RbnNvQWVLK2p3MGk2bGVLQ0VkVGt5UnpsT1ZKMHVTQkJ5?=
 =?utf-8?B?dkt2RGs1Mko5eHhaRTFIa3ZkbEsvNElQd0dvR3IzNSszV3BWUlN3T0NIanJ4?=
 =?utf-8?Q?x2yxoJraV/y5pbrQ1A0KnrQ=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0B63087D23859140BD4640460AE8FF45@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5600.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac0b5521-7b86-4e97-16a3-08d9ebe06cfb
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Feb 2022 15:25:38.2763
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ERoXnon8bGtuvVBko+6OEJFDd1KJR9mPirl2mjL3CCnFUPEnb773tbRVJ46CO41fbaOM54HuzZOyn/QKwmx+FA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5387
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10252 signatures=673431
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0 bulkscore=0
 malwarescore=0 suspectscore=0 phishscore=0 adultscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202090087
X-Proofpoint-GUID: yQKcJ3MmsPCmo4SecQtVQaP0hdLAjqBL
X-Proofpoint-ORIG-GUID: yQKcJ3MmsPCmo4SecQtVQaP0hdLAjqBL
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

DQoNCj4gT24gOSBGZWIgMjAyMiwgYXQgMTY6MDQsIExlb24gUm9tYW5vdnNreSA8bGVvbkBrZXJu
ZWwub3JnPiB3cm90ZToNCj4gDQo+IE9uIFdlZCwgRmViIDA5LCAyMDIyIGF0IDAyOjIzOjAwUE0g
KzAxMDAsIEjDpWtvbiBCdWdnZSB3cm90ZToNCj4+IFhSQyBJTkkgUVBzIHNob3VsZCBiZSBhYmxl
IHRvIGFkanVzdCB0aGVpciBsb2NhbCBBQ0sgdGltZW91dC4NCj4+IA0KPj4gRml4ZXM6IDJjMTYx
OWVkZWY2MSAoIklCL2NtYTogRGVmaW5lIG9wdGlvbiB0byBzZXQgYWNrIHRpbWVvdXQgYW5kIHBh
Y2sgdG9zX3NldCIpDQo+PiBTaWduZWQtb2ZmLWJ5OiBIw6Vrb24gQnVnZ2UgPGhhYWtvbi5idWdn
ZUBvcmFjbGUuY29tPg0KPj4gU3VnZ2VzdGVkLWJ5OiBBdm5lZXNoIFBhbnQgPGF2bmVlc2gucGFu
dEBvcmFjbGUuY29tPg0KPj4gDQo+PiAtLS0NCj4+IA0KPj4gVG8gYXZvaWQgZXhjZXNzaXZlIGRp
c2N1c3Npb25zIGFyb3VuZCB0aGUgKmlmIChXQVJOX09OKCAuLi4qDQo+PiBjb25zdHJ1Y3QsIGp1
c3Qgc2F5aW5nIHRoYXQgaXQgaGFzIGJlZW4gc2FuY3Rpb25lZCBieSBKYXNvbiBoZXJlOg0KPj4g
DQo+PiBodHRwczovL2xvcmUua2VybmVsLm9yZy9saW51eC1yZG1hLzIwMjEwNDEzMTM1MTIwLkdU
NzQwNUBudmlkaWEuY29tLw0KPiANCj4gQW5kIEkgdGhpbmsgdGhhdCB0aGlzIGlzIHdyb25nLCBi
ZWNhdXNlIGl0IGNhbmUgYmUgdHJpZ2dlcmVkIGJ5IHVzZXIuDQo+IDEuIENyZWF0ZSBjbV9pZCB3
aXRoIGFueSBRUCB0eXBlIHlvdSB3YW50IC0gdWNtYV9jcmVhdGVfaWQoKQ0KPiAyLiBDYWxsIHRv
IHNldCBvcHRpb24gLSB1Y21hX3NldF9vcHRpb24oKQ0KPiAzLiBTZWUgV0FSTl9PTi4NCg0KWWVz
LCB0aGlzIG9uZSBpcyBjYWxsYWJsZSBmcm9tIHVzZXItc3BhY2UuIFJpZ2h0LiBXaWxsIHNlbmQg
YSB2Mi4NCg0KDQpUaHhzLCBIw6Vrb24NCg0KPiANCj4gVGhhbmtzDQo+IA0KPj4gLS0tDQo+PiBk
cml2ZXJzL2luZmluaWJhbmQvY29yZS9jbWEuYyB8IDIgKy0NCj4+IDEgZmlsZSBjaGFuZ2VkLCAx
IGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQ0KPj4gDQo+PiBkaWZmIC0tZ2l0IGEvZHJpdmVy
cy9pbmZpbmliYW5kL2NvcmUvY21hLmMgYi9kcml2ZXJzL2luZmluaWJhbmQvY29yZS9jbWEuYw0K
Pj4gaW5kZXggMGY1ZjBkNy4uMDA2ZWE5YyAxMDA2NDQNCj4+IC0tLSBhL2RyaXZlcnMvaW5maW5p
YmFuZC9jb3JlL2NtYS5jDQo+PiArKysgYi9kcml2ZXJzL2luZmluaWJhbmQvY29yZS9jbWEuYw0K
Pj4gQEAgLTI4MTEsNyArMjgxMSw3IEBAIGludCByZG1hX3NldF9hY2tfdGltZW91dChzdHJ1Y3Qg
cmRtYV9jbV9pZCAqaWQsIHU4IHRpbWVvdXQpDQo+PiB7DQo+PiAJc3RydWN0IHJkbWFfaWRfcHJp
dmF0ZSAqaWRfcHJpdjsNCj4+IA0KPj4gLQlpZiAoaWQtPnFwX3R5cGUgIT0gSUJfUVBUX1JDKQ0K
Pj4gKwlpZiAoV0FSTl9PTihpZC0+cXBfdHlwZSAhPSBJQl9RUFRfUkMgJiYgaWQtPnFwX3R5cGUg
IT0gSUJfUVBUX1hSQ19JTkkpKQ0KPj4gCQlyZXR1cm4gLUVJTlZBTDsNCj4+IA0KPj4gCWlkX3By
aXYgPSBjb250YWluZXJfb2YoaWQsIHN0cnVjdCByZG1hX2lkX3ByaXZhdGUsIGlkKTsNCj4+IC0t
IA0KPj4gMS44LjMuMQ0KDQo=
