Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BEF77D988C
	for <lists+linux-rdma@lfdr.de>; Fri, 27 Oct 2023 14:41:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345883AbjJ0MlF (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 27 Oct 2023 08:41:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345881AbjJ0MlE (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 27 Oct 2023 08:41:04 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57249D4A
        for <linux-rdma@vger.kernel.org>; Fri, 27 Oct 2023 05:40:59 -0700 (PDT)
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39RCbq1j016889;
        Fri, 27 Oct 2023 12:40:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=tr4sXt1zYVBvsMp33Q+Hhv2xPIWvuei+DIaLImFjaTc=;
 b=NsQ7zUG7EEspKlZRx1IlrX1yi63rka1bEdk2pexQ2vzdX55aGld5O4X3dRqBU3VLUdlf
 CMI+z94xLCIeGHIZBTRFbgr/IdEp5Sxe54WTACtAQ7VSDM1QXHB2rju4HIEYwWddsthr
 AYtKUaUNL81qyFrfh+xGvlqCenuc8HfgA8Fj/SJaRY41motoftsZbl/MBd4caDsMBJbu
 hx6PwkCjyx+fQ6oCgTlBNM8l6Y6gySLR/nUo+qiWm/i6b9cD9aob1cjurOtEQ+Rmvt0l
 CRPC02pVyQt9NjeLH6dnCo35Bi+Q7AHGCsIl0fry/MR9BKYv1hdHKGESrDmJiHhZQG6C jA== 
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3u0dcf032k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 27 Oct 2023 12:40:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iWT3h2LFZNlCJKjhQpO0a/TtG0YFkCYOwJYCFZ5MwFX9yTMs0IASV9ilT+BV/bgDu4E8ndf1pUk9Qy3wwmYX0UluHw8aNza9CHjkKUYiFs57NOGENM+YDxxTYPBXuAZvmgvfkCEOZB6cJ5rFGaE53A4o3QD9yO98aQqhopwyu/m29mdIo4SfIZPZHzUZkuVazRnoSuUafJvAanQfLOM/g4BAPfBkO385hSoYFo0ZziRDqWTQjzQe1tYsqHDVdHANmOpxj/gvIeGOsCY2GSj64KDzwODbGhU1KMo1E97log8BEO5NuRk6+DfB0tSOTpBjM8qgKDXrUMv5vq/Erb7Z6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7jPlJSY7WzgHm6d9lKAJif0WGxhLKDdaocjlXdh8y9A=;
 b=VhJCmfvf0YrSOwlYV9ITEFhbk1dnUFl0T+qlr+5MjW6ZE1UXiYhpxALs/Bnzu+fvUIhf2QzXLhLlij0Lx75uVHgk4V4X460M0xU78XT4AQQc9CVLKo0E5a4KS9rWLJOumKfePvBKxWVlIT7Xg7tlwyoT+jX20MLON5hA9w8ctoETWItOHmv8FxWU+DSNNxSgxJxy0PtgfjX9UtDlIhlKAEwqkhN5zujyhKHzjqpIiZvjHLMFpAZBjX/A1b3p5pMFOGyOeW29QHg3GGBO6tJ3pN5BfXYg0nokmnTy4WH0StmNLdOXFRHuTCwTuwRnHcRAksBF1yk57qmpaZbdUDD8Rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=zurich.ibm.com; dmarc=pass action=none
 header.from=zurich.ibm.com; dkim=pass header.d=zurich.ibm.com; arc=none
Received: from SN7PR15MB5755.namprd15.prod.outlook.com (2603:10b6:806:349::10)
 by CH3PR15MB6117.namprd15.prod.outlook.com (2603:10b6:610:15c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.37; Fri, 27 Oct
 2023 12:40:27 +0000
Received: from SN7PR15MB5755.namprd15.prod.outlook.com
 ([fe80::878d:d9bd:7ce3:8445]) by SN7PR15MB5755.namprd15.prod.outlook.com
 ([fe80::878d:d9bd:7ce3:8445%5]) with mapi id 15.20.6933.019; Fri, 27 Oct 2023
 12:40:27 +0000
From:   Bernard Metzler <BMT@zurich.ibm.com>
To:     Guoqing Jiang <guoqing.jiang@linux.dev>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>, "leon@kernel.org" <leon@kernel.org>
CC:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: RE: [PATCH V3 12/18] RDMA/siw: Introduce siw_free_cm_id
Thread-Topic: [PATCH V3 12/18] RDMA/siw: Introduce siw_free_cm_id
Thread-Index: AQHaCNLDwQ77keVe50Ct2YrX6QsgCA==
Date:   Fri, 27 Oct 2023 12:40:27 +0000
Message-ID: <SN7PR15MB57558DB29895931CEBD33E6299DCA@SN7PR15MB5755.namprd15.prod.outlook.com>
References: <20231027023328.30347-1-guoqing.jiang@linux.dev>
 <20231027023328.30347-13-guoqing.jiang@linux.dev>
In-Reply-To: <20231027023328.30347-13-guoqing.jiang@linux.dev>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR15MB5755:EE_|CH3PR15MB6117:EE_
x-ms-office365-filtering-correlation-id: 0ac5518c-f10a-4938-9c57-08dbd6e9e5a1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mnZHKVa1GeQeeXEd1J9n2gxOSsYDL8TcGCLUHDOuWV8VsC5Oi/aaUI//DOV6K5eQ4Zym1zqL5uvf0udc53PzI/PG9vYeiXqyTUcr5PFFhPrlZE9JsyPbL30D/bouOgHa6gHawJ6BxC0UTo7SG7s5Tq+XpiLSc3KncFKyFVoq9/epRMhz+oqnmdu5xeiIvKPidksd7d9Pigpv0c6wTypvlzmI8Q39ThnkRTU5VGhNS+6aSdUIBknGStOa5lpyjDm1JPz3KOl1QQ0O875EBuS6HMkFMTp3bxiIj53kPzo3YTxN6894lPe99UAlFqtYE/v34Fs+OL9rdyLvmtPl5deGRqIiJufsBPzGrjUcounoq0/QBe34ozxK7IfSRYZBujITj2wrpuDawqG6LhneuOr+S89yHeYGP5r+Yt4wyckf0Vr9hbNNRDBYkBrZzu8uFtdxScXQdcpiWx5aD9FG3MCbeD8l1miwxtOcwJd6QF9nhkK2+Az7vcWLaqOUixZCkK9jc+MRwI+uejpsWrlHaVT9UIQwp7TRvvf6AxiSjoUJej3xBsxxX7+N7S6jC4kIjCixmvtDD3aBEgYkLglRgdzq8cuL0D4OEdv5zg/jFR3kB/wtCF/2V6vYss5Ojy8js/3s+MV0X+ltwNST96yx9ljV3Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR15MB5755.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(346002)(396003)(136003)(39860400002)(230922051799003)(230273577357003)(230173577357003)(64100799003)(451199024)(1800799009)(186009)(4326008)(8936002)(64756008)(8676002)(66946007)(66476007)(316002)(110136005)(41300700001)(66556008)(66446008)(83380400001)(966005)(76116006)(9686003)(2906002)(7696005)(53546011)(6506007)(71200400001)(5660300002)(52536014)(478600001)(33656002)(38100700002)(38070700009)(122000001)(55016003)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?KzVuR21MVFVZVFVjMmtpQjdGbngvRVc0Q1kxZU9rckhVVnNGaGM5NWpjVW9a?=
 =?utf-8?B?ZnhNeVJPWVJtOVREK0x1YWhMYWFrYUM5QnFJaHdLQTRJV3ZVRFRKK3pPNG5Y?=
 =?utf-8?B?aVVEVjFIa0lTanVqRXNzZ3Y4eXpFUEdyL1ViZENob096bUFDb2dyRUErNjI1?=
 =?utf-8?B?Y1M4c2d6RGl3Z1dtd1lYMDNSYzNTYlQ3ZjlVWHJhNkRYbVRucE1UQ255Sy9r?=
 =?utf-8?B?TWoxM1paaWRJYmxsQkxRS1ZwRkpyQ003bk5hZ2JhQU5BMFV5TW1WaUg0K29Z?=
 =?utf-8?B?RXZsRG5NZEVwTHRDaVg1N2V3bFBabzNnS0NtS2VDYm5WTmVmUjVZOWlkMUJq?=
 =?utf-8?B?VzJ3aUU1dlgvUmRRaU13QnNCa3dBOXNQaVRsNUJkSHFrTTh1YzR6bXA4RDRr?=
 =?utf-8?B?b2NWbFcvRURCUGFPMlNiSVIwK1lzbGdtQ1RTeU81U1AwSzgzMXBVeWRRMWNu?=
 =?utf-8?B?anh5bXN5bmpiOUY1aWhJU2N2UWxYb2h6OVBIVWNNbGVHWDZmQm1tQTJ6WEFJ?=
 =?utf-8?B?N1hKUmpGZGo5bWc4OXRrdk5ZWU9DaTNhQXhnbVpOaWJiZ25WVVlOSndLTzYy?=
 =?utf-8?B?T3QySDBJNHp5T0NjNEtiQ3V5VnBVaDJkZkVNREVJS0JjNC91bGxjVkI0TEtr?=
 =?utf-8?B?QUJSeDdWa21EU09iTGlEUVk2MDcyK1NrV2Q5U3FScG1jM2RLN21GTVR0ZXJt?=
 =?utf-8?B?RldGR1VtZHFtaS9CM2dwZFI0NzFhWXJ2eTIrSm1QV2FKZElhR2ZwSkFEYjJh?=
 =?utf-8?B?NHV1T3cxUlRpdTZUamRBNk0xQ0J1WXVKM2FQUFk3ZXZvOGJDRmJyMnAxZVM2?=
 =?utf-8?B?emJWRjNxM25vVEErSWwramtjT3F3NHVsQXNiUUpqa2l2VkNvV3g3UkRVUEQ1?=
 =?utf-8?B?bTNEUG1hT3JHT3QyaW9XOGtWRUFua0l1WDBXcExUV0FZWDRBU1QwNVRiVmNV?=
 =?utf-8?B?UGdnczBFYU5IMlo2RjVxbS9yTUM2NkJrVkpqRUtrMXhKNEdobmgzM2ZxUEdn?=
 =?utf-8?B?cHdVL09PZlpwVHZkb0k4dlJjUmFxU1RRQStoM2xsM21jOWF1VVJ6cEtvRCtM?=
 =?utf-8?B?KzJMK21zclo4cGxEZW5qQlFObUxXL0Mxd0VPNmdRRkZTZHdwaEd4YjR3b2NB?=
 =?utf-8?B?Tk1xT2FYaDhuNnZNdzhVZlpNMU9aNmZ3alRHNFhxbFU5eC9raEJJa0RkTmJy?=
 =?utf-8?B?RE9kUTl6OE10TGVGZTYvQkFZc3dadUMvOGQ2S0hCSGdPK25laTVrZ3d3b3Ex?=
 =?utf-8?B?STJiYXdPblFNWjVTM0ZGRlMxQUYxa1YyT0NaZlF3RUpxazZicytRM3EwdGRN?=
 =?utf-8?B?cDhySE5ESW5FN3NIWURCdFZPbHZiZHNRb1B3cjhnWDJESUczTUZsUEc1V0lE?=
 =?utf-8?B?L1FFOVdqSmluaXplM09EbUs2Yk4yYmJYUVJtZnJkV3lzWlNPSjRQZWNnOHRZ?=
 =?utf-8?B?U2thbis2Zk5CbVUybUpFSGdPRnovNEc4WTdtYUxaNWQvNHg4cDQ3bU9vcFl5?=
 =?utf-8?B?ZmZRVUJOUVJpSGxLSVYweTYrVGlCN2lkeFZQUVpsTUJTbThuektQM1c5cFFF?=
 =?utf-8?B?UnVEQkt2MW1HQ3U5V2NJS0hsWnhTaEdmUmVTTXlTS0RTYW9pUWkvZTVFNnBT?=
 =?utf-8?B?MS9xNDQxS295VUVyWnU4OUtWMzBxS1Y0ZWVweXg1QUJmSGthRklmdTFUYmlK?=
 =?utf-8?B?ak1yYXFvQ200RmxGZUtaZU0waEJzNk5aZS9tTDVqeGVGY0ovKzkvUTdkWDZv?=
 =?utf-8?B?cXlRM0lVYzNWZ2x0MzhTeWVGcTVUWGxxaWg2cTN6OUsyOWxDUDhxQ2NvRmxu?=
 =?utf-8?B?dzRPN1ordlZlVjdtbFBiWE9zNzBTTmtKSXFNMktHdHpMRWQ5VTQ2QWFMT3RM?=
 =?utf-8?B?MzhXMEpLR2R0Rjc4c0h4Sko0NmM3SDZDNUMrMkV1bWVtdmhpejVKV3M2TGhR?=
 =?utf-8?B?dGVUbjB6MlRaTkx3c0I3OXVxV3RMVzh2U1owRSt6UlVKR1RzVE1ETHlvL2kr?=
 =?utf-8?B?aWo1MGYwUXJLUk5tMFQ2elpaNWpSbVU5WFd1aGdnUXVZNW91MWcvTDZVdERi?=
 =?utf-8?B?TVlVODA4c1V6WFNSYWF1Yk1wazNaVnJHd3FwZXhlVTFDRVdGbUNoMlVYREd0?=
 =?utf-8?B?M0FVaTJEQnYvNThqOGpEQ0FhUmZWSm1RYmhTZTFGeEI2MlFWZGVEY04wM3Ni?=
 =?utf-8?Q?MA0FANt54W8BoVG/aEgpGfrdsdUF0/Rxx/nKw9eLMlpt?=
Content-Type: text/plain; charset="utf-8"
X-OriginatorOrg: Zurich.ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR15MB5755.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ac5518c-f10a-4938-9c57-08dbd6e9e5a1
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Oct 2023 12:40:27.0759
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tKWnShPzeQcM/7iV54T7q+xZhcptQdQbpUB3AUkksl/ZH0DrZTejNPKhiDMSb/RdLEaywLfHhmlhf86g8k2ovA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR15MB6117
X-Proofpoint-GUID: M-mKaTK4eKvd4af2QgWNujWKMZHlq1Xv
X-Proofpoint-ORIG-GUID: M-mKaTK4eKvd4af2QgWNujWKMZHlq1Xv
Content-Transfer-Encoding: base64
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-27_10,2023-10-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=937
 impostorscore=0 suspectscore=0 lowpriorityscore=0 mlxscore=0 adultscore=0
 clxscore=1015 bulkscore=0 phishscore=0 spamscore=0 priorityscore=1501
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310240000 definitions=main-2310270109
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogR3VvcWluZyBKaWFuZyA8
Z3VvcWluZy5qaWFuZ0BsaW51eC5kZXY+DQo+IFNlbnQ6IEZyaWRheSwgT2N0b2JlciAyNywgMjAy
MyA0OjMzIEFNDQo+IFRvOiBCZXJuYXJkIE1ldHpsZXIgPEJNVEB6dXJpY2guaWJtLmNvbT47IGpn
Z0B6aWVwZS5jYTsgbGVvbkBrZXJuZWwub3JnDQo+IENjOiBsaW51eC1yZG1hQHZnZXIua2VybmVs
Lm9yZw0KPiBTdWJqZWN0OiBbRVhURVJOQUxdIFtQQVRDSCBWMyAxMi8xOF0gUkRNQS9zaXc6IElu
dHJvZHVjZSBzaXdfZnJlZV9jbV9pZA0KPiANCj4gRmFjdG9yIG91dCBhIGhlbHBlciB0byBzaW1w
bGlmeSBjb2RlLg0KPiANCj4gUmVwb3J0ZWQtYnk6IGtlcm5lbCB0ZXN0IHJvYm90IDxsa3BAaW50
ZWwuY29tPg0KPiBDbG9zZXM6IElOVkFMSUQgVVJJIFJFTU9WRUQNCj4gM0FfX2xvcmUua2VybmVs
Lm9yZ19vZS0yRGtidWlsZC0yRGFsbF8yMDIzMTAwOTE2NTYuSmxybWNOWEItMkRsa3AtDQo+IDQw
aW50ZWwuY29tXyZkPUR3SURBZyZjPWpmX2lhU0h2Sk9iVGJ4LXNpQTFaT2cmcj0yVGFZWFEwVC0N
Cj4gcjhaTzFQUDFhbE53VV9RSmNSUkxmbVlUQWdkM1FDdnFTYyZtPWpjTG9sOUtBRWZhQmsyVGx1
UnBkdU94S1lZQlhoblJtVWlSc0drDQo+IEYxZXMzbmFtMERiOURxSkdySGJHaDZEeGV2JnM9MDQ2
eUxQRUxIdUhXOE9KRmk5ZHdtUHlnQVAxMWxuWlFpNkRwZm5nSHpKOCZlPQ0KPiBTaWduZWQtb2Zm
LWJ5OiBHdW9xaW5nIEppYW5nIDxndW9xaW5nLmppYW5nQGxpbnV4LmRldj4NCj4gLS0tDQo+ICBk
cml2ZXJzL2luZmluaWJhbmQvc3cvc2l3L3Npd19jbS5jIHwgMzQgKysrKysrKysrKysrKy0tLS0t
LS0tLS0tLS0tLS0tDQo+ICAxIGZpbGUgY2hhbmdlZCwgMTUgaW5zZXJ0aW9ucygrKSwgMTkgZGVs
ZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9pbmZpbmliYW5kL3N3L3Npdy9z
aXdfY20uYw0KPiBiL2RyaXZlcnMvaW5maW5pYmFuZC9zdy9zaXcvc2l3X2NtLmMNCj4gaW5kZXgg
MmYzMzhiYjNhMjRjLi4xZDI0MzhmYmY3YzcgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvaW5maW5p
YmFuZC9zdy9zaXcvc2l3X2NtLmMNCj4gKysrIGIvZHJpdmVycy9pbmZpbmliYW5kL3N3L3Npdy9z
aXdfY20uYw0KPiBAQCAtMzY0LDYgKzM2NCwxNSBAQCBzdGF0aWMgaW50IHNpd19jbV91cGNhbGwo
c3RydWN0IHNpd19jZXAgKmNlcCwgZW51bQ0KPiBpd19jbV9ldmVudF90eXBlIHJlYXNvbiwNCj4g
IAlyZXR1cm4gaWQtPmV2ZW50X2hhbmRsZXIoaWQsICZldmVudCk7DQo+ICB9DQo+IA0KPiArc3Rh
dGljIHZvaWQgc2l3X2ZyZWVfY21faWQoc3RydWN0IHNpd19jZXAgKmNlcCkNCj4gK3sNCj4gKwlp
ZiAoIWNlcC0+Y21faWQpDQo+ICsJCXJldHVybjsNCj4gKw0KPiArCWNlcC0+Y21faWQtPnJlbV9y
ZWYoY2VwLT5jbV9pZCk7DQo+ICsJY2VwLT5jbV9pZCA9IE5VTEw7DQo+ICt9DQo+ICsNCj4gIC8q
DQo+ICAgKiBzaXdfcXBfY21fZHJvcCgpDQo+ICAgKg0KPiBAQCAtNDE1LDggKzQyNCw3IEBAIHZv
aWQgc2l3X3FwX2NtX2Ryb3Aoc3RydWN0IHNpd19xcCAqcXAsIGludCBzY2hlZHVsZSkNCj4gIAkJ
CWRlZmF1bHQ6DQo+ICAJCQkJYnJlYWs7DQo+ICAJCQl9DQo+IC0JCQljZXAtPmNtX2lkLT5yZW1f
cmVmKGNlcC0+Y21faWQpOw0KPiAtCQkJY2VwLT5jbV9pZCA9IE5VTEw7DQo+ICsJCQlzaXdfZnJl
ZV9jbV9pZChjZXApOw0KPiAgCQkJc2l3X2NlcF9wdXQoY2VwKTsNCj4gIAkJfQ0KPiAgCQljZXAt
PnN0YXRlID0gU0lXX0VQU1RBVEVfQ0xPU0VEOw0KPiBAQCAtMTE3NSwxMSArMTE4Myw4IEBAIHN0
YXRpYyB2b2lkIHNpd19jbV93b3JrX2hhbmRsZXIoc3RydWN0IHdvcmtfc3RydWN0DQo+ICp3KQ0K
PiAgCQkJc29ja19yZWxlYXNlKGNlcC0+c29jayk7DQo+ICAJCQljZXAtPnNvY2sgPSBOVUxMOw0K
PiAgCQl9DQo+IC0JCWlmIChjZXAtPmNtX2lkKSB7DQo+IC0JCQljZXAtPmNtX2lkLT5yZW1fcmVm
KGNlcC0+Y21faWQpOw0KPiAtCQkJY2VwLT5jbV9pZCA9IE5VTEw7DQo+IC0JCQlzaXdfY2VwX3B1
dChjZXApOw0KPiAtCQl9DQo+ICsJCXNpd19mcmVlX2NtX2lkKGNlcCk7DQo+ICsJCXNpd19jZXBf
cHV0KGNlcCk7DQoNCldlIG11c3QgZGVjcmVtZW50IHRoZSBjZXAgcmVmZXJlbmNlIG9ubHkgaWYg
aXQgaGFkIHJlZmVyZW5jZWQNCmEgY21faWQuIFNvIGhlcmUgd2UgbmVlZCB0byBwdXQgYm90aCBp
bnRvICcgaWYgKGNlcC0+Y21faWQpIHsnDQpjbGF1c2UgYWdhaW4uIA0KDQoNCj4gIAl9DQo+ICAJ
c2l3X2NlcF9zZXRfZnJlZShjZXApOw0KPiAgCXNpd19wdXRfd29yayh3b3JrKTsNCj4gQEAgLTE3
MDIsMTAgKzE3MDcsNyBAQCBpbnQgc2l3X2FjY2VwdChzdHJ1Y3QgaXdfY21faWQgKmlkLCBzdHJ1
Y3QNCj4gaXdfY21fY29ubl9wYXJhbSAqcGFyYW1zKQ0KPiANCj4gIAljZXAtPnN0YXRlID0gU0lX
X0VQU1RBVEVfQ0xPU0VEOw0KPiANCj4gLQlpZiAoY2VwLT5jbV9pZCkgew0KPiAtCQljZXAtPmNt
X2lkLT5yZW1fcmVmKGlkKTsNCj4gLQkJY2VwLT5jbV9pZCA9IE5VTEw7DQo+IC0JfQ0KPiArCXNp
d19mcmVlX2NtX2lkKGNlcCk7DQo+ICAJaWYgKHFwLT5jZXApIHsNCj4gIAkJc2l3X2NlcF9wdXQo
Y2VwKTsNCj4gIAkJcXAtPmNlcCA9IE5VTEw7DQo+IEBAIC0xODgwLDEwICsxODgyLDcgQEAgaW50
IHNpd19jcmVhdGVfbGlzdGVuKHN0cnVjdCBpd19jbV9pZCAqaWQsIGludA0KPiBiYWNrbG9nKQ0K
PiAgCWlmIChjZXApIHsNCj4gIAkJc2l3X2NlcF9zZXRfaW51c2UoY2VwKTsNCj4gDQo+IC0JCWlm
IChjZXAtPmNtX2lkKSB7DQo+IC0JCQljZXAtPmNtX2lkLT5yZW1fcmVmKGNlcC0+Y21faWQpOw0K
PiAtCQkJY2VwLT5jbV9pZCA9IE5VTEw7DQo+IC0JCX0NCj4gKwkJc2l3X2ZyZWVfY21faWQoY2Vw
KTsNCj4gIAkJY2VwLT5zb2NrID0gTlVMTDsNCj4gIAkJc2l3X3NvY2tldF9kaXNhc3NvYyhzKTsN
Cj4gIAkJY2VwLT5zdGF0ZSA9IFNJV19FUFNUQVRFX0NMT1NFRDsNCj4gQEAgLTE5MTIsMTAgKzE5
MTEsNyBAQCBzdGF0aWMgdm9pZCBzaXdfZHJvcF9saXN0ZW5lcnMoc3RydWN0IGl3X2NtX2lkICpp
ZCkNCj4gDQo+ICAJCXNpd19jZXBfc2V0X2ludXNlKGNlcCk7DQo+IA0KPiAtCQlpZiAoY2VwLT5j
bV9pZCkgew0KPiAtCQkJY2VwLT5jbV9pZC0+cmVtX3JlZihjZXAtPmNtX2lkKTsNCj4gLQkJCWNl
cC0+Y21faWQgPSBOVUxMOw0KPiAtCQl9DQo+ICsJCXNpd19mcmVlX2NtX2lkKGNlcCk7DQo+ICAJ
CWlmIChjZXAtPnNvY2spIHsNCj4gIAkJCXNpd19zb2NrZXRfZGlzYXNzb2MoY2VwLT5zb2NrKTsN
Cj4gIAkJCXNvY2tfcmVsZWFzZShjZXAtPnNvY2spOw0KPiAtLQ0KPiAyLjM1LjMNCg0K
