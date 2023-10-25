Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDB5B7D6D71
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Oct 2023 15:39:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233249AbjJYNjt (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 25 Oct 2023 09:39:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232864AbjJYNjs (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 25 Oct 2023 09:39:48 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86D46131
        for <linux-rdma@vger.kernel.org>; Wed, 25 Oct 2023 06:39:46 -0700 (PDT)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39PDbIEC028027;
        Wed, 25 Oct 2023 13:39:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=Fm40hVt+qxZG+LtBlyLUothtQAAiHYU0Hyix+Ru8+qU=;
 b=Vmet3eQo82+JjYUOoOCMvavhXDAgivZ3/Rm4aXNNv+0bjpfUurL/FX65zfpKDY1yvqBk
 6GjXxv0llMB5k3VAvSMaRFzEdR6vZu4I7GIjQ6/FRd8Z4iq+AHDEF4k9JkNWC1NykpDW
 Ik43hPa2qMurRpi4l5PO5dhTa8TVolKDkTzV/BG0srLe020g2MQW1gpPMbk9xj6o2BwP
 OCVNj0TM6OkNza0l0jX1Fza/QMKIevsTexf7iL7cLQHaVaiLUl2iOZoSxlLYXumSoXg4
 efvco3CDcaVKtzvo5MglkIGiqGBmDlwUYOfo7JUI3adARNNglmwaKKCqybnwYD+1V5tS og== 
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ty42h85rr-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 25 Oct 2023 13:39:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UU4/XQ1oP73hMXkdHg+crWab9oY2aRYv04NTpUHISn/S5D/4TC4plIjMHtQC68TdaLfI40MNe46j4+TpokBaYBcbHkWbf57ySwgbZeehLzfCn+0QV3rdieDti1Y/B+ImIYU3uC6whf9SaKJW3TT/28VGv0tNzs2CG9Oeb1GulEsb6g5oWzFwqAFcapCipDkd0q9CgfUtPDv3XTjKFFWxXRwu0ytSmvSWGY04tO6j1wCGaDdW4ymwVEOhaLXfFqAbQnqZwkbCXs7dwJ9AR1u+M7Hv5OSQtzV2urkFIwpdLdmPlNWSTX9jw56gig9F2oGtzlBUevOUkRnM7oyfGfE7Cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fm40hVt+qxZG+LtBlyLUothtQAAiHYU0Hyix+Ru8+qU=;
 b=HMh+TE9dylMebvgqJMvBXTuVdZQUkk9kv4yQBCO0EPqjofeOzR9PIH7SRLLN17dIduYgIgoVnfgNkyraNTTrcqezNO1GzwidaZV8seWvbwVjhbiAsKjy83PF1nVYJiU45cqsIzs4CjpnPghNEfIQOlQqBcSTHCfcGvoRfIcCrQrkIBg2Rel9YPxAwjB6sv5mFBdToXJsKfx5u9YyLIf7wbw8O38F0hseLQJ3kgK7lSbcYZbmOwsJaz3/Vo++sOCxMv+OqxeoAXnkrSxuenOtdNz8vhMY8V6v65gvTNH8xc+QytvUc54rCViZX5HATpvargSvaj9x+b31cuWQOcWmlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=zurich.ibm.com; dmarc=pass action=none
 header.from=zurich.ibm.com; dkim=pass header.d=zurich.ibm.com; arc=none
Received: from SN7PR15MB5755.namprd15.prod.outlook.com (2603:10b6:806:349::10)
 by CO1PR15MB4857.namprd15.prod.outlook.com (2603:10b6:303:fc::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.14; Wed, 25 Oct
 2023 13:37:06 +0000
Received: from SN7PR15MB5755.namprd15.prod.outlook.com
 ([fe80::878d:d9bd:7ce3:8445]) by SN7PR15MB5755.namprd15.prod.outlook.com
 ([fe80::878d:d9bd:7ce3:8445%5]) with mapi id 15.20.6933.019; Wed, 25 Oct 2023
 13:37:06 +0000
From:   Bernard Metzler <BMT@zurich.ibm.com>
To:     Guoqing Jiang <guoqing.jiang@linux.dev>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>, "leon@kernel.org" <leon@kernel.org>
CC:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: RE: [PATCH V2 00/20] Cleanup for siw
Thread-Topic: [PATCH V2 00/20] Cleanup for siw
Thread-Index: AQHaB0hYyCfs7nSooUeI4zYpgk7k3A==
Date:   Wed, 25 Oct 2023 13:37:06 +0000
Message-ID: <SN7PR15MB575586FBFD184670B5893C3A99DEA@SN7PR15MB5755.namprd15.prod.outlook.com>
References: <20231013020053.2120-1-guoqing.jiang@linux.dev>
In-Reply-To: <20231013020053.2120-1-guoqing.jiang@linux.dev>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR15MB5755:EE_|CO1PR15MB4857:EE_
x-ms-office365-filtering-correlation-id: 4e66808d-7e6f-408a-dc7f-08dbd55f7b2a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5JfrsqRLwUCvH5nXsVZvcBQQdPrUXd4m7YdnDnxlFZZ5iRtFaGgP+9cadsp82nKeneOkEXCJ9HJkth5ErT8sOCa0K4axN74JnIQMuVGpzlEhfuhyFY99xs86HLHf36ZYK64qySiM18t141Zg4Wh95rPmUyoF0wxtoGrrsrMSvzZ3eCXiIWSDKYgq5tkiUpBmcitpcVP6Fr84borUdMjbJiKTY+xcitNU6LKw6lIcjSyZDhQ/xacmXV32cgMqlxsr02wIPX05f3xYsoEzb2NbpZ2qh/NJGx3pdnFXVyls47WdIngLH70b4iLjpvKwkp+mnTF1PmzpVUuvU6eh7/khozTmLJ+V+nGE8EHaB6JBIdexLe18ambINGUYenKIjn2BDDBwMW/fJ1+N5ethHgL6QfCao7P4DWtRoIRQNitkbymx7Z5siWjtoN0e71lixrpxqrnIF50bQS9D6r7hM8BE/LJjxKo8P2SZRXRKaSai99gDUSGo+rimr9Mpxlo8atwyoAASq6rMOvRaAzy6ys3Jfn1fnR9xyKdVNz3enZiAvTPjT+XMIwAc8skTBYiNSq1i5GcSAcc3FNQWRLLCSP/HhWHlMkbRSUwSwfqHjn8o99SB7+NsTb6oaNTFM2wti3Q6
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR15MB5755.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(136003)(366004)(396003)(39860400002)(230922051799003)(64100799003)(186009)(1800799009)(451199024)(9686003)(83380400001)(53546011)(6506007)(33656002)(7696005)(64756008)(478600001)(316002)(66446008)(110136005)(76116006)(66946007)(55016003)(66476007)(66556008)(71200400001)(38100700002)(86362001)(122000001)(4326008)(8936002)(41300700001)(8676002)(52536014)(2906002)(38070700009)(5660300002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?azJSTUhyKzhueHdsNWdYaWYyL203eWZZaEJsMG9Ca051L3AvTUxRc3BSNHlu?=
 =?utf-8?B?bURBTGR5RE9XbUNQMkl0TE1sbEo2cWwvODV4YnBqK09DbTZCenhkT0lTNEFv?=
 =?utf-8?B?MGVRQWNhdzRrWFBETWNCcG40L2hYa0k5Q0dROUJzQ05qV0x2R3diNjBMUm0z?=
 =?utf-8?B?ZG1PVHdCYUV1bmpiZXN2R05PdG5aUlhXTkV3ektqK3dINVZXQ1Q3dG5rVzBZ?=
 =?utf-8?B?RjFxY0NBTTY2cEVEait1NEt1WWhiT3NSS21LNnNMbGdPYjFNOTVqcnV1NEdw?=
 =?utf-8?B?OExoSkZENTNWN3dxQmZPdUJyN0Fqei9URk5jYXB6S0t0a3dDdTdaZHBsOHlh?=
 =?utf-8?B?aFk4SWVJeFJxTGQzQmg3WTg5WDdCTDltWHNuZVcveDBFT292ZEdYQlF5QmVv?=
 =?utf-8?B?a0o5YUJReEJqdGFHdzY1UFkyaG9kOVl0aUpOdngrcThkRGJkN29rMk9pNXdR?=
 =?utf-8?B?NWNseUpOeFhhQXVORTl4cXNHTWl2ckNlcTJxbGtSZm9OT3FFb09pQUVESlFP?=
 =?utf-8?B?OEhCMjIvaHhGa2FqQXRDQXAzTCtIZFRlWHlQYTRLUWs2c2JYUUNNUHFBSU9S?=
 =?utf-8?B?SVpLbHdrMGwwaW9XeUo3Ui9IalQwYVNuTlZ6dXAyYTdpZEJKdnZYaTBxOVc4?=
 =?utf-8?B?L3NvNkI3MmtPTmpTUnRSRzlwMFQzQmNDZHJURzNPNWw0cGRDR012dmZBc20v?=
 =?utf-8?B?Tkg1NkVPV3QvZXhrelVOY1VnQ3ZSbkRUckxqdElUa0FsbEd0TS9PZ3BIZ3B1?=
 =?utf-8?B?R1NQQVlDNkFFRTdEc01mb3dIUmtFMDk0c2hSSTZ1bVhYVHNrU2RDVHQ2VkVU?=
 =?utf-8?B?VWdCM3laT3RFRmRvRFFhUXNlcnljRkwvTkFLdjJyeTU3RUVTQXFRcFhobEM3?=
 =?utf-8?B?WGtOQzBPZXFNdUd4eDRROWtZQWs3d3NrZlIvRDJZeHQrQUVmN2E1bVpab1dE?=
 =?utf-8?B?YUo5S0QwY1hvVTNUZEZqZkgySVpGbzREdXdSeXNLSXNPOG8rSjB4eE56YWdR?=
 =?utf-8?B?R1c3bFVpVWc4Sm1RUGN6NTE1bVYrOU1NK1I4VmFiRnNWd3FnR2FKYUs0aTNF?=
 =?utf-8?B?Y3BnSWRQUWtnbUxmaWdtR0c2VjFYbTNaWTlxSy9zK0pXOGZXODlTa01IWkdX?=
 =?utf-8?B?M2N2bmhmS0tnblM4VDJSWjAwR3ZiRXZZOGMwVnpjL0VnQ0RDV3VOUGZVa0JW?=
 =?utf-8?B?dG9QVzFCbkdKelJLcTliUWxGRG9iQjdWVGNzdlF4OEJhVVQ5Tkg3amZoRjNY?=
 =?utf-8?B?cEdIeHh5Vno3NnBsZGdZVEd3MDVaNTI1WlY0Z08vczdDQzdxdFVmWm8vcVNB?=
 =?utf-8?B?L3hCV0dhUnZHSDlWK0JZeXhocmRJakNCOURGb2ZXN2hSMjNBYjJXa2g1c2t5?=
 =?utf-8?B?K1JxOFJ2QVlUSE5JWHNob1FSaVNBU0RiTGtIWUtpQW5KbmFsVzVDZlFEZXlV?=
 =?utf-8?B?c3JmTzJSeThoWUpJUFZZbVcwS3BaeFh3RGlkZXFObjdoZkZyRDV2eW95bHBM?=
 =?utf-8?B?RGJHdHhud1hBUlpacWRZbUxZZ09XamVjMjF4STYwcnc2Y2JxVHc2dUxOblBo?=
 =?utf-8?B?Ym5OTklMUDBSV3V3WmtlOE4vckR2YzJWTHJ0ZWZmR0NCTkVpeDM0aml5bHVl?=
 =?utf-8?B?bDhjd3NFcTRPZ3JhcDUxb3k1OGU0S0ZRS1hETkFtRnd3UEFhMDd4RVhpTzhz?=
 =?utf-8?B?Sm92RzVIcGx2b2N3VlVhRUFjVjg3d3pRTGZzRFFuM1pTWnlrRlhnNWpsdCtx?=
 =?utf-8?B?Uy96b1cwZ2lHdTFGVTlqZk4xdy9LLzNqUVZDRUlHSStOYmFWT2Zjak50SnBl?=
 =?utf-8?B?bXNRa25jSkkyU0U5cyt3OWxzZ21vQWZBNmo2UFBnQmdDN2ZNWFdFLzI0RlM5?=
 =?utf-8?B?Sk1VaDFOUHN6cmt1MmpMMnhiUEUvVjI5b3hrWmRtT1d2bjNhK3UrMURKOEtk?=
 =?utf-8?B?dDBKMXlVSkZnb2EzUVQ5ZXdaY1FML056b2thbWVYVjNPU2xzYWw5RGJIakM0?=
 =?utf-8?B?UDV0MlZBa0JsSGxMQTVCdzFDZkF0MTdPYlBteERVaE9tN2RlbENCRFc1amVX?=
 =?utf-8?B?aDFieUNocEV2Z1dlM0F5VVV3UVVoTUUzMHI5b01LNlhmQ016Lzgwb24vMUNH?=
 =?utf-8?B?RVg3L2gxZnBYUXEwOFBCQXN1anAyVS85RVBlTitjM3hiY3pGWVpUZ1c3N1li?=
 =?utf-8?Q?VN0Vj1SA+x1tS12CVMVuGtY=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Zurich.ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR15MB5755.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e66808d-7e6f-408a-dc7f-08dbd55f7b2a
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Oct 2023 13:37:06.7708
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /d5GOeLCqYIEOh7XxzluV+m3903Z8PvzMM1X/xEAf2FXg1md8A1RbBZg861H0fY6cX+9lmx17iX4vB5HxuYmwg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR15MB4857
X-Proofpoint-ORIG-GUID: U-U1JQcZk0p2q7YZ7CnuNyIBua9LuTsi
X-Proofpoint-GUID: U-U1JQcZk0p2q7YZ7CnuNyIBua9LuTsi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-25_02,2023-10-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 clxscore=1015 mlxscore=0 phishscore=0 bulkscore=0 adultscore=0
 suspectscore=0 impostorscore=0 priorityscore=1501 spamscore=0
 malwarescore=0 mlxlogscore=949 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2310170001 definitions=main-2310250118
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
Z3VvcWluZy5qaWFuZ0BsaW51eC5kZXY+DQo+IFNlbnQ6IEZyaWRheSwgT2N0b2JlciAxMywgMjAy
MyA0OjAxIEFNDQo+IFRvOiBCZXJuYXJkIE1ldHpsZXIgPEJNVEB6dXJpY2guaWJtLmNvbT47IGpn
Z0B6aWVwZS5jYTsgbGVvbkBrZXJuZWwub3JnDQo+IENjOiBsaW51eC1yZG1hQHZnZXIua2VybmVs
Lm9yZw0KPiBTdWJqZWN0OiBbRVhURVJOQUxdIFtQQVRDSCBWMiAwMC8yMF0gQ2xlYW51cCBmb3Ig
c2l3DQo+IA0KPiBWMiBjaGFuZ2VzOg0KPiAxLiBhZGRyZXNzIFc9MSB3YXJuaW5nIGluIHBhdGNo
IDEyIGFuZCAxOSBwZXIgdGhlIHJlcG9ydCBmcm9tIGxrcC4NCj4gMi4gYWRkIG9uZSBtb3JlIHBh
dGNoICgyMHRoKS4NCj4gDQo+IEhpLA0KPiANCj4gVGhpcyBzZXJpZXMgYWltIHRvIGNsZWFudXAg
c2l3IGNvZGUsIHBsZWFzZSByZXZpZXcgYW5kIGNvbW1lbnQhDQo+IA0KPiBUaGFua3MsDQo+IEd1
b3FpbmcNCj4gDQo+IEd1b3FpbmcgSmlhbmcgKDIwKToNCj4gICBSRE1BL3NpdzogSW50cm9kdWNl
IHNpd19nZXRfcGFnZQ0KPiAgIFJETUEvc2l3OiBJbnRyb2R1Y2Ugc2l3X3NyeF91cGRhdGVfc2ti
DQo+ICAgUkRNQS9zaXc6IFVzZSBpb3YuaW92X2xlbiBpbiBrZXJuZWxfc2VuZG1zZw0KPiAgIFJE
TUEvc2l3OiBSZW1vdmUgZ290byBsYWJsZSBpbiBzaXdfbW1hcA0KPiAgIFJETUEvc2l3OiBSZW1v
dmUgcmN1IGZyb20gc2l3X3FwDQo+ICAgUkRNQS9zaXc6IE5vIG5lZWQgdG8gY2hlY2sgdGVybV9p
bmZvLnZhbGlkIGJlZm9yZSBjYWxsDQo+ICAgICBzaXdfc2VuZF90ZXJtaW5hdGUNCj4gICBSRE1B
L3NpdzogQWxzbyBnb3RvIG91dF9zZW1fdXAgaWYgcGluX3VzZXJfcGFnZXMgcmV0dXJucyAwDQo+
ICAgUkRNQS9zaXc6IEZhY3RvciBvdXQgc2l3X2dlbmVyaWNfcnggaGVscGVyDQo+ICAgUkRNQS9z
aXc6IEludHJvZHVjZSBTSVdfU1RBR19NQVhfSU5ERVgNCj4gICBSRE1BL3NpdzogQWRkIG9uZSBw
YXJhbWV0ZXIgdG8gc2l3X2Rlc3Ryb3lfY3B1bGlzdA0KPiAgIFJETUEvc2l3OiBJbnRyb2R1Y2Ug
c2l3X2NlcF9zZXRfZnJlZV9hbmRfcHV0DQo+ICAgUkRNQS9zaXc6IEludHJvZHVjZSBzaXdfZnJl
ZV9jbV9pZA0KPiAgIFJETUEvc2l3OiBTaW1wbGlmeSBzaXdfcXBfaWQyb2JqDQo+ICAgUkRNQS9z
aXc6IFNpbXBsaWZ5IHNpd19tZW1faWQyb2JqDQo+ICAgUkRNQS9zaXc6IENsZWFudXAgc2l3X2Fj
Y2VwdA0KPiAgIFJETUEvc2l3OiBSZW1vdmUgc2l3X3NrX2Fzc2lnbl9jbV91cGNhbGxzDQo+ICAg
UkRNQS9zaXc6IEZpeCB0eXBvDQo+ICAgUkRNQS9zaXc6IE9ubHkgY2hlY2sgYXR0cnMtPmNhcC5t
YXhfc2VuZF93ciBpbiBzaXdfY3JlYXRlX3FwDQo+ICAgUkRNQS9zaXc6IEludHJvZHVjZSBzaXdf
ZGVzdHJveV9jZXBfc29jaw0KPiAgIFJETUEvc2l3OiBVcGRhdGUgY29tbWVudHMgZm9yIHNpd19x
cF9zcV9wcm9jZXNzDQo+IA0KPiAgZHJpdmVycy9pbmZpbmliYW5kL3N3L3Npdy9zaXcuaCAgICAg
ICB8ICAgOSArLQ0KPiAgZHJpdmVycy9pbmZpbmliYW5kL3N3L3Npdy9zaXdfY20uYyAgICB8IDE1
NCArKysrKysrKysrKy0tLS0tLS0tLS0tLS0tLQ0KPiAgZHJpdmVycy9pbmZpbmliYW5kL3N3L3Np
dy9zaXdfbWFpbi5jICB8ICAzMCArKystLQ0KPiAgZHJpdmVycy9pbmZpbmliYW5kL3N3L3Npdy9z
aXdfbWVtLmMgICB8ICAyMiArKy0tDQo+ICBkcml2ZXJzL2luZmluaWJhbmQvc3cvc2l3L3Npd19x
cC5jICAgIHwgICAyICstDQo+ICBkcml2ZXJzL2luZmluaWJhbmQvc3cvc2l3L3Npd19xcF9yeC5j
IHwgIDg0ICsrKysrKy0tLS0tLS0tDQo+ICBkcml2ZXJzL2luZmluaWJhbmQvc3cvc2l3L3Npd19x
cF90eC5jIHwgIDM5ICsrKy0tLS0NCj4gIGRyaXZlcnMvaW5maW5pYmFuZC9zdy9zaXcvc2l3X3Zl
cmJzLmMgfCAgMjMgKy0tLQ0KPiAgOCBmaWxlcyBjaGFuZ2VkLCAxNDQgaW5zZXJ0aW9ucygrKSwg
MjE5IGRlbGV0aW9ucygtKQ0KPiANCj4gDQo+IGJhc2UtY29tbWl0OiA5NjQxNjg5NzBjZWY1ZjVi
NzM4ZmFlMDQ3ZTZkZTIxMDc4NDJmZWI3DQo+IC0tDQo+IDIuMzUuMw0KDQpIaSBHdW9xaW5nLA0K
VGhhbmtzIGZvciB0aGUgZWZmb3J0ISBJIGxpa2UgbW9zdCBvZiBpdC4NCg0KQW5kLCBzb3JyeSwg
SSBzYXcgSSBzdGFydGVkIG15IHJldmlldyB3aXRoIHZlcnNpb24gMSBvZiB5b3VyDQpwYXRjaGVz
LiBMdWNraWx5IGl0IGRvZXMgbm90IGhhdmUgZnVuY3Rpb25hbCBkaWZmZXJlbmNlcyB0bw0KdjIu
DQoNCkJ1dCBJIGV4cGVjdCBhIHZlcnNpb24gMyBhbnl3YXkuDQoNCkkgY3VycmVudGx5IGRvIG5v
dCBoYXZlIGFjY2VzcyB0byBwaHlzaWNhbCBtYWNoaW5lcyB0byBjaGVjayBhbmQNCnJ1biB0aGUg
bW9yZSBjb21wbGV4IHBhdGNoZXMuIEkgaG9wZSB0byBkbyB0aGF0IChwYXRjaCAwOCwxMCwxMiwx
NSkNCnRvbW9ycm93IHdoZW4gYmFjayBpbiBvZmZpY2UuDQoNClRoYW5rcywNCkJlcm5hcmQuDQoN
Cg0K
