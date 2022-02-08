Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A8A24AD745
	for <lists+linux-rdma@lfdr.de>; Tue,  8 Feb 2022 12:32:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376392AbiBHLcW (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 8 Feb 2022 06:32:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356640AbiBHKx2 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 8 Feb 2022 05:53:28 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21BC3C03FEC0
        for <linux-rdma@vger.kernel.org>; Tue,  8 Feb 2022 02:53:27 -0800 (PST)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 218AiDkH011038;
        Tue, 8 Feb 2022 10:53:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=KEpPCGX8+e3RoL3bgz6WRa6g4qFg84Qq311doa9JEPY=;
 b=puYwfw5jgaWnBtnpi8nmP1lrAoiT3nrwNp5PS2bd7AM6Q2WvT77tn6qlV2sqK4HPD0Ox
 ljZzX5i2wqn+xCJnKgQx1yOYuihFsaGUsDjYFkpE9tQGB0/WMgMqTXWXsc5gVsQRKVV6
 Swk2yf845qRsfYnN2yCm94RmoBAzwCucr7v4QHMypibWiS9iyAXtMU1NFHxIi9xK6zVc
 Bpq4MI77M+1chtsFDbCZQMr8TIwxJm4Ca8oOrq/nYQEAkIg/IAdKl8AiGdycEg7WZ9Z9
 Ulc8wfxK8youPAm0azq3Bg5jAOTd3vEHX4nr2YEiIGpAmgRqsii6zfRpngABtG0UxBQs Pw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3e3hdsrxc5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 08 Feb 2022 10:53:21 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 218ApXQo048836;
        Tue, 8 Feb 2022 10:53:16 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
        by aserp3020.oracle.com with ESMTP id 3e1h25w61h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 08 Feb 2022 10:53:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IwXXOSRxLv0VGnMNrGQ06znjjofn7LUxe8yarGPNyKBKVc6EBiBSIFdvCdPuDx2wK47X2EmrsSPWPWL4w/6k0q8pYizL2x9BGrQNUDZ7OfN2y1/csORzo1CepYKlJF0M1j5fjzV2upKJCeVoXiUfE3fpYTftUSfHRFR+W0CrSuP8x3339WO2lT+G0+xNF7JD5YqZEOXL0dz1gLJrmeljXwZRQ2vjECtp79YfQxixsRu4H6LmgmywGHGXwjb3sEHZjO5u+KyPiAJaTAcIxf60bXiCWe8D2mz02+LJw666Wuhh9vWQ8doq7Jcoj8izoCXQ4G1J83J7hQSQAiPdb554pA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KEpPCGX8+e3RoL3bgz6WRa6g4qFg84Qq311doa9JEPY=;
 b=lg1opYSn5MdkGlzW0LbluUQ6DSFgYM83YBLC3qNsDa81eQp15N5uuB+eVF1HuNh4i8QUGrLZY1R6qLhv/CTVOxTocv8SF7P7fotrcC24aVC8gjQrpTp+M4+b+KKXRFcaNcQhsGOOpUwX6Wpe2gJEk2W5Gh17WRevI2+7+FTDAA679vFugRWb9I183a+Or/82UTkCSh4mXMxBACxVlLXvVH4LKKrDU79/QBeTLqfRscN3Kid/7Y8tImcfWHBvUzhO5/wOc85q7uBgkbOeeR/WAP3BLWgi1CCw0uUMC0cXy7xfVRVvgBhXOuoKBrkDht8YYrdkmPlv7BdRNVUyYuBIQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KEpPCGX8+e3RoL3bgz6WRa6g4qFg84Qq311doa9JEPY=;
 b=HOTLmgg8DRVl+CYmvpi4zjcFBg6iaFa8zS7It/Wme+Fw9PQeoqGbfSl41b3cRa0EQXH2QA1SX67VdimSojtGCrRd6c4iXWoCiU4kOr701HELdaZmvBfAlyZgMnMwAy9SvX5YTujJWJDi95r1BKY+CwNeBAwgwtK8adj1YU00z7Y=
Received: from SN4PR10MB5590.namprd10.prod.outlook.com (2603:10b6:806:205::5)
 by SN6PR10MB2541.namprd10.prod.outlook.com (2603:10b6:805:44::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Tue, 8 Feb
 2022 10:53:15 +0000
Received: from SN4PR10MB5590.namprd10.prod.outlook.com
 ([fe80::54fa:f1f7:d24b:e1b0]) by SN4PR10MB5590.namprd10.prod.outlook.com
 ([fe80::54fa:f1f7:d24b:e1b0%5]) with mapi id 15.20.4951.018; Tue, 8 Feb 2022
 10:53:15 +0000
From:   Haakon Bugge <haakon.bugge@oracle.com>
To:     Leon Romanovsky <leon@kernel.org>
CC:     Jason Gunthorpe <jgg@nvidia.com>,
        OFED mailing list <linux-rdma@vger.kernel.org>
Subject: Re: Seeking clarification on the XRC Annex wrt. a TGT QP having a SQ
Thread-Topic: Seeking clarification on the XRC Annex wrt. a TGT QP having a SQ
Thread-Index: AQHYHDLDx2/8ceuRlkGhgcyanM7+VKyIcUCAgAEKfYA=
Date:   Tue, 8 Feb 2022 10:53:15 +0000
Message-ID: <099658DB-B526-481A-B3BA-6F95BA74350C@oracle.com>
References: <6FD25F7D-6F5A-4990-A179-5ED213001BB7@oracle.com>
 <YgFsDXH5XdEBOT/O@unreal>
In-Reply-To: <YgFsDXH5XdEBOT/O@unreal>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3693.40.0.1.81)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d7798598-c642-46e3-7bc0-08d9eaf13543
x-ms-traffictypediagnostic: SN6PR10MB2541:EE_
x-microsoft-antispam-prvs: <SN6PR10MB25418B3119C1A18E26497EE6FD2D9@SN6PR10MB2541.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: clk54GU7MoHHaS9fcYWD5HGHrs5UJQl6JcOS18ySQyvF7N32o1c7lzYQzYEdEJPBrx1KMvuexk5zBG6pyyJh45yk1KojXVz7kUug91eAGc5q+kb/j47gmyrhejPIhEMS9lHxIdcWYE72T4HjCZmMXBCaoLiy3bUYvYubRDGItM2vgXl6rtxUQgRmOvyf6RiVSvz6fngFdXTNJevFlOJqoEfnojS8IKQyYPt9XTQN9DFpUbSd1PW8hVrtFlvYZqfLtlu+4pqgrdzOSeyDtcShAm6pi37lh23jLVOJpSqUmB4ztSDo+cyWZm/xwcwxzMkl2JBnDestWmPtxX3i+d0oUhGsNhMh7wVxf+7iUq6o+laTme4OiFwilEwnzal/A/R/we/phOWvspfsqMxYvYiC79vossIKq7AoOFi5SDWSsp6yX8374XecP3yfTJvWJmfxr//+5a+nuTaYTJlr81ssqwf1fCuxknNqlfQbZhbM6fAL5gQ3ivUASFGxEQN5H8/xpYQLcDdCTTt6BiOrQ3MiDEYEmbdbDJ6Ea8RmO1Nnduw7RNlsH0XStbzY5o1lhL/EIY9lm+DramsUoEBGiVj6lEgK0/eUa41cPjpW6tK+qd7TVuPOrnXS5T75wW1bC1gaX7i+jB7GwAa5t/knhKw2QKCqap1lP0KP35Nc3oGarkZpu/2iZYpfcGRteGA7CD+1ARi7PZ2LSdFCcgPq1RpLb9WSLLSmxbBD+VYpt3ib32J5QsvswfoQJAW//aelZ70g
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR10MB5590.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(83380400001)(66574015)(86362001)(5660300002)(71200400001)(36756003)(6506007)(66946007)(66476007)(53546011)(44832011)(76116006)(91956017)(6512007)(8676002)(66556008)(8936002)(4326008)(66446008)(64756008)(33656002)(186003)(26005)(2906002)(122000001)(38100700002)(508600001)(6486002)(54906003)(2616005)(316002)(38070700005)(6916009)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dFVyVTNOU0J3VklpWEY2L05Mc1ZhTW9zb1RnTTBaYWhRY1RhUkg5QzZqZzVQ?=
 =?utf-8?B?V1pCd2pRcmdPbER3OHY0aHhXUkYrNG8vckMvZkkwcnhFd0xKOWxyV3Nqanl1?=
 =?utf-8?B?TG1hZ1JjakhRL0ZlaEdJQ090aDlMWURUVWFVSVBrR2Fzc1p2eTloNndxK2t6?=
 =?utf-8?B?Z0hicFlHem1SdW5hdlNVN2Q1Ti9Jbm84UE9iTDBKMHF1akFkWTQwNWlqcnh2?=
 =?utf-8?B?MUxhWkxoOEhpN1NYR1FOZDd6OXp0SHdqcnpSeVZwQW1HQkdwbTllbFRlOHVU?=
 =?utf-8?B?T3lwdUxybmliREVUcW1mZEJpRCtqc1FPd0diVEJWQzdXUDBDTXUrWVh1Y085?=
 =?utf-8?B?cFNjRmVqcE10MG1lTTE5Q3pmc1EzaERBYkNsdHA4NGIyOG5DcXY0RlpnVC9v?=
 =?utf-8?B?K29QeXVuQVByWmZJSGhIQm1OMVZEMlpLMloxSWxMWWcxRzF4UnRtNFJUVTBq?=
 =?utf-8?B?c2hqbHg2MVNnVXJMQjFBTmJYR2JTWXNNMXdXSk5QK1ZXamZxUEViU0dHcWt4?=
 =?utf-8?B?R3RvUkZhcFh5YVZ4Wk5heWRxTTg0R09rdVUycC9sZnZwNU1QenNnY1dGcnhm?=
 =?utf-8?B?RlF5R2JZL1FjZzV1WVRtSGRnbURESVYxVTRCQXI0aU5oZjR3dXpRZXcxT2VJ?=
 =?utf-8?B?MXRuRE10TVRwQ0E4VzlkQmM4YjFabENadjNIamdndUNBMmlNelJsYXU1NXZI?=
 =?utf-8?B?cXU2WHE2bnZQazlhdWU3b29WQ1NNNm90WTdKQVZCUStwdGpvSmxnS0oybC9a?=
 =?utf-8?B?d0FCdVl2V0ZhdDVaUllZY2ZHWlZhS3BMbXlyY1o3Z0RlY04weUJCd3NCNC9p?=
 =?utf-8?B?NU9LWDgzT1JOdFBsWHExQk55MjNESWZvL3liTm5aWE5yOU41NmJaVnZjUFVp?=
 =?utf-8?B?Tk1oNG43ZllRdUUrbTdzV0YvY1h3ZWV1S0JJbWIyMWRXZ2lZeWU2cVpOT1pq?=
 =?utf-8?B?UjVCdS9oVVltVW5zT05WN29qRUt3blkyaW54MThVR1I1bnZoSzhQcFFqc1g2?=
 =?utf-8?B?LzVMNEZRcWhpNVFDWjdUMGtNQ2RqQk5Ec21OUUgwM0Zrc3V1L1BXU2tCS0lB?=
 =?utf-8?B?Z1djUy8xLzl0c0F3YU41Ry9FbEdGdkdPNzdsbEkvakRodHI5N3hkam1nWXNt?=
 =?utf-8?B?VlRGYVJiYnNCWkZ4dUlPWExQMHdpcmxXeENzQUM4djFlOFZNenR1ZjBqT1hZ?=
 =?utf-8?B?cnp0Ylc3NGJyK3lWQWhzN2xQOXJ4V1cyS2Z6RjBqSnlJMlB0Wlg0MFFINk1l?=
 =?utf-8?B?cGh3L1kzVG92cTAzOXBYay9HbTlBWjJsVDgzeG1TamRmK21FRk1XZytUYXpY?=
 =?utf-8?B?cGRlZGt1WEVtRHBUNEp3alNXMStvclZvZXMvVlEzenZUTmxCL3RSM2kvdmJ4?=
 =?utf-8?B?d0FFbU9nMTZVeTRoQlBjTVBpRXpoanY3VFRsZXJaZWdOTk9LWTJHNmQ2TTgx?=
 =?utf-8?B?T1BFUXVyOXFvc01BRGJwSm9JVGJFUXV4R01jeC9EUUVJQzhNTUFEbmZKN1FD?=
 =?utf-8?B?M2FQU1huTzVXVW5GOENGK0dTa3pETDRlc1dYaVNiTFprWlNZSnRyZ0FadzlM?=
 =?utf-8?B?SDEwUFFCcUIvbnIvSkl4NEpJTkZZbDA2a3pEMWZRZjFJbHFTc2l2Zm9Bb29K?=
 =?utf-8?B?dTNWVngwaXBUYUZQbUE2M3h2SzRxYWhDT3pBK1hMR1ZsSVlNMjI0Z1JIZmkz?=
 =?utf-8?B?d1BEamJQQ3NCTTRPZmR6OXpWQzlMU1duRTJNRjFQVVBobGcwNXpQamJOU3RL?=
 =?utf-8?B?NUxURmdkdHBwUGg5OHVEUWZDMVM3d2FOZnZuWERRbVBEalFmVGYrSEpRZUk2?=
 =?utf-8?B?SDhSbzdFeS9ZdWZkdFlJZ2NaUkxZK0U2cU5OTklZbW5yeFJPZ3VyVFhKYndB?=
 =?utf-8?B?V1g5MnNsNlJMZU80YlJJRFhRai92QVFaeVZla0trN0oxVFNUMkExTmxjVXhV?=
 =?utf-8?B?UGM2dUtjdStCdmppejk1V2VtclUxNEpzOVdzbGlqTzdJaEh6UWpLMlBoNGxI?=
 =?utf-8?B?VVc1TG52VFNQcHNUdVJsRTFlYzhKaVJIT1NpVjA5cWh4ZGx0QVhrZE9TSXlv?=
 =?utf-8?B?Uy84Vm9jOHl2L041U2MrU2FITVFBUXFaTXdLNGZlK1MxWk8yc25ndXlpeklM?=
 =?utf-8?B?amVpQVZXYU9hQ3BvWVRJdnlTbytHTm84MTVNOXNkbXRhTzMva1BqSFdTK05h?=
 =?utf-8?Q?pEGsSAESn3rgfVFpl8rd6YM=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2614134563134C4A91BE4BEC6CC6C4D3@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR10MB5590.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7798598-c642-46e3-7bc0-08d9eaf13543
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Feb 2022 10:53:15.0318
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: u6VeMAxPmSZ0C+qYsB+Ltlapm0ZaVlS7FdWugTOgEKa3SM6zfLItZqBGMTSWNVgvGOTS0MbEsrvSFX1sER3y8Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR10MB2541
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10251 signatures=673430
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 bulkscore=0
 phishscore=0 malwarescore=0 mlxlogscore=999 adultscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202080064
X-Proofpoint-GUID: ZsRwJsiPLoYLOXI7V6oI0FiIMjoCyK-o
X-Proofpoint-ORIG-GUID: ZsRwJsiPLoYLOXI7V6oI0FiIMjoCyK-o
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

DQoNCj4gT24gNyBGZWIgMjAyMiwgYXQgMTk6NTksIExlb24gUm9tYW5vdnNreSA8bGVvbkBrZXJu
ZWwub3JnPiB3cm90ZToNCj4gDQo+IE9uIE1vbiwgRmViIDA3LCAyMDIyIGF0IDAyOjU1OjM1UE0g
KzAwMDAsIEhhYWtvbiBCdWdnZSB3cm90ZToNCj4+IEhleSwNCj4+IA0KPj4gDQo+PiBJIGhhdmUg
YSBxdWVzdGlvbiB0byBYUkMgVEdUIFFQcyBhbmQgd2hldGhlciB0aGV5IGRvIGhhdmUgYSBzZXQg
b2YgcmVxdWVzdG9yIHJlc291cmNlcyBvciBub3QuDQo+PiANCj4+IA0KPj4gVGhlIFhSQyBBbm5l
eCAoTWFyY2ggMiwgMjAwOSBSZXZpc2lvbiAxLjApICgqMSkgYm9sZGx5IHN0YXRlczoNCj4+IA0K
Pj4gCVhSQyBUR1QgUVBzIGFyZSBzaW1pbGFyIHRvIFJEIEVFQ3MgYnV0IGRvIG5vdCBoYXZlIGEg
cmVxdWVzdGVyIHNpZGUuDQo+PiANCj4+IA0KPj4gTmV2ZXJ0aGVsZXNzLCBpbiBUYWJsZSA5LCBw
YWdlIDM2LCBpdCBpcyBzdGF0ZWQgdGhhdCAiTG9jYWwgQUNLIFRpbWVvdXQiIGFuZCAiU1EgUFNO
IiBhcmUgcmVxdWlyZWQgYXR0cmlidXRlcyBkdXJpbmcgYW4gUlRSIC0+IFJUUyB0cmFuc2l0aW9u
IGZvciBhbiBYUkMgVGFyZ2V0IFFQLiBUaGlzIHNlZW1zIHRvIGJlIGFuIGluY29ycmVjdCByZXF1
aXJlbWVudCwgc3ViamVjdCB0byB0aGUgWFJDIFRhcmdldCBRUCBub3QgaGF2aW5nIGEgc2VuZCBx
dWV1ZT8NCj4+IA0KPj4gRnVydGhlciwgbG9va2luZyBhdCBhIHZlbmRvcidzIGNyZWF0aW9uIG9m
IGFuIFhSQyBUR1QgUVAsIHdlIHNlZToNCj4+IA0KPj4gCU1MWDVfU0VUKHFwYywgcXBjLCBub19z
cSwgMSk7DQo+PiANCj4+IGluIHRoZSBmdW5jdGlvbiBjcmVhdGVfeHJjX3RndCgpLg0KPj4gDQo+
PiBJZiB0aGUgaW50ZXJwcmV0YXRpb24gdGhhdCBhbiBYUkMgVEdUIGRvZXMgX25vdF8gaGF2ZSBh
IHNlbmQgcXVldWUgaXMgY29ycmVjdCwgd2UgY2Fubm90IHNpbXBseSByZW1vdmUgIkxvY2FsIEFD
SyBUaW1lb3V0IiBhbmQgIlNRIFBTTiIgYXMgbWFuZGF0b3J5IGF0dHJpYnV0ZXMgZHVyaW5nIHRo
ZSBzdGF0ZSB0cmFuc2l0aW9uLCBiZWNhdXNlIHRoYXQgd2lsbCBicmVhayBhbGwgY3VycmVudCBz
b2Z0d2FyZS4gSXMgaXQgYW4gaWRlYSB0byBtb3ZlIHRob3NlIHRvIG9wdGlvbmFsIGF0dHJpYnV0
ZXMgaW4gdGhlIHFwX3N0YXRlX3RhYmxlW10/IFRoZW4gcmVtb3ZlIHRoZSBJQl9RUFRfWFJDX1RH
VCBsYWJlbCBpbiBjbV9pbml0X3FwX3J0c19hdHRyKCk/DQo+IA0KPiBJIHRoaW5rIHRoYXQgeW91
ciBpbnRlcnByZXRhdGlvbiBvZiBzcGVjIGlzIGNvcnJlY3QsIGJ1dCB3aHkgZG8geW91IHdhbnQN
Cj4gdG8gcmVtb3ZlIHRoZXNlIGF0dHJpYnV0ZXM/IFRoZSBkZXZpY2UgaWdub3JlcyB0aGVtIGFu
eXdheS4NCg0KOi0pDQoNCk9yLCByZXBocmFzaW5nIHlvdXIgcXVlc3Rpb24sIHdoeSBoYXZlIHRo
ZXNlIGF0dHJpYnV0ZXMgYXMgbWFuZGF0b3J5PyBUaGUgZGV2aWNlIGlnbm9yZXMgdGhlbSBhbnl3
YXkgOy0pDQoNClRvIG1lLCBpdCBpcyBjb25mdXNpbmcuIEZvciBleGFtcGxlLCBpbiByZG1hX3Nl
dF9taW5fcm5yX3RpbWVyKCksIHRoZSB0ZXN0IGZvciBYUkMgVEdUIGlzIGNvcnJlY3QsIHNpbmNl
IGFuIFhSRyBJTkkgUVAgZG9lcyBub3QgaGF2ZSBhbnkgcmVzcG9uZGVyIHBhcnQuIEJ1dCB0aGlz
IGlzIHRoZW4gaW5jb25zaXN0ZW50IHdpdGggb3RoZXIgcGFydHMgb2YgQ00vQ01BLg0KDQoNClRo
eHMsIEjDpWtvbg0KDQo+IFRoYW5rcw0KPiANCj4+IA0KPj4gDQo+PiBUaHhzLCBIw6Vrb24NCj4+
IA0KPj4gKjE6IElCVEEgU3BlYyBSZWxlYXNlIDEuNiBpcyBlcXVhbCB0byB0aGUgWFJDIEFubmV4
IGluIHRoaXMgcmVzcGVjdA0KDQo=
