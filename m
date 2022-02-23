Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4ACC4C1A77
	for <lists+linux-rdma@lfdr.de>; Wed, 23 Feb 2022 19:00:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243694AbiBWSBC (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 23 Feb 2022 13:01:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243713AbiBWSBA (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 23 Feb 2022 13:01:00 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8280241600
        for <linux-rdma@vger.kernel.org>; Wed, 23 Feb 2022 10:00:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645639230; x=1677175230;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=KdxULogvzA8zyYCXcnBW6VuJBqhgs7NXua6R5pijAE4=;
  b=ZBkIZaktFUmSjY6uV4goG6cPwRJhX0CGFznb9Yzv5fSNxlaEuIJx+4Or
   cQF1tTOlfqekxAe6ITZWIh9DEAIzBh6NM2aNKs4fMIqq9AOwwWvg9BhhI
   paVIBUAemsgBIQh2kr2LxR0PJh4aJZJRNJDLqf0ASiOv7tW4TwJOFr0aP
   yFAAJvHGlMAYCu1fk/lmu9V87ETHkLg3ZwdELVHc0qYzr5axstlHWbDbL
   RIv1lftHUtWbwpaoWe7ijZt3Rx39V3hsF2uaySadEAlgnoTklMUJeYgFS
   PAmskXxlT1qAt29fKnFMmeTCln0wHnPsdzDkzMj+58htj2brD/rtOJlTH
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10267"; a="252234243"
X-IronPort-AV: E=Sophos;i="5.88,391,1635231600"; 
   d="scan'208";a="252234243"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2022 10:00:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,391,1635231600"; 
   d="scan'208";a="532790009"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga007.jf.intel.com with ESMTP; 23 Feb 2022 10:00:29 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Wed, 23 Feb 2022 10:00:29 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Wed, 23 Feb 2022 10:00:28 -0800
Received: from fmsmsx612.amr.corp.intel.com ([10.18.126.92]) by
 fmsmsx612.amr.corp.intel.com ([10.18.126.92]) with mapi id 15.01.2308.020;
 Wed, 23 Feb 2022 10:00:28 -0800
From:   "Saleem, Shiraz" <shiraz.saleem@intel.com>
To:     Yanjun Zhu <yanjun.zhu@linux.dev>,
        "Ismail, Mustafa" <mustafa.ismail@intel.com>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "leon@kernel.org" <leon@kernel.org>
Subject: RE: [PATCH 1/1] RDMA/irdma: Make irdma_create_mg_ctx return a void
Thread-Topic: [PATCH 1/1] RDMA/irdma: Make irdma_create_mg_ctx return a void
Thread-Index: AQHYI6HpLh4dObz1kkailtLIXmBfLqyhYoSAgAATIGA=
Date:   Wed, 23 Feb 2022 18:00:28 +0000
Message-ID: <0e3d1406d83b472eba6f805a34234cde@intel.com>
References: <20220217181938.3798530-1-yanjun.zhu@linux.dev>
 <bbabbd38-e68f-f167-bf0e-c0f760e05c61@linux.dev>
In-Reply-To: <bbabbd38-e68f-f167-bf0e-c0f760e05c61@linux.dev>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.6.200.16
x-originating-ip: [10.1.200.100]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

PiBTdWJqZWN0OiBSZTogW1BBVENIIDEvMV0gUkRNQS9pcmRtYTogTWFrZSBpcmRtYV9jcmVhdGVf
bWdfY3R4IHJldHVybiBhIHZvaWQNCj4gDQo+IOWcqCAyMDIyLzIvMTggMjoxOSwgeWFuanVuLnpo
dUBsaW51eC5kZXYg5YaZ6YGTOg0KPiA+IEZyb206IFpodSBZYW5qdW4gPHlhbmp1bi56aHVAbGlu
dXguZGV2Pg0KPiA+DQo+ID4gVGhlIGZ1bmN0aW9uIGlyZG1hX2NyZWF0ZV9tZ19jdHggYWx3YXlz
IHJldHVybnMgMCwgc28gbWFrZSBpdCB2b2lkIGFuZA0KPiA+IGRlbGV0ZSB0aGUgcmV0dXJuIHZh
bHVlIGNoZWNrLg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogWmh1IFlhbmp1biA8eWFuanVuLnpo
dUBsaW51eC5kZXY+DQo+IA0KPiBnZW50bGUgcGluZw0KPiANCj4gWmh1IFlhbmp1bg0KPiANCj4g
PiAtLS0NCj4gPiAgIGRyaXZlcnMvaW5maW5pYmFuZC9ody9pcmRtYS91ZGEuYyB8IDkgKystLS0t
LS0tDQo+ID4gICAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCA3IGRlbGV0aW9ucygt
KQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvaW5maW5pYmFuZC9ody9pcmRtYS91ZGEu
Yw0KPiA+IGIvZHJpdmVycy9pbmZpbmliYW5kL2h3L2lyZG1hL3VkYS5jDQo+ID4gaW5kZXggN2E5
OTg4ZGRiZDAxLi41ZWViNzZiYzI5ZmQgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9pbmZpbmli
YW5kL2h3L2lyZG1hL3VkYS5jDQo+ID4gKysrIGIvZHJpdmVycy9pbmZpbmliYW5kL2h3L2lyZG1h
L3VkYS5jDQo+ID4gQEAgLTg2LDggKzg2LDcgQEAgZW51bSBpcmRtYV9zdGF0dXNfY29kZSBpcmRt
YV9zY19hY2Nlc3NfYWgoc3RydWN0DQo+IGlyZG1hX3NjX2NxcCAqY3FwLA0KPiA+ICAgICogaXJk
bWFfY3JlYXRlX21nX2N0eCgpIC0gY3JlYXRlIGEgbWNnIGNvbnRleHQNCj4gPiAgICAqIEBpbmZv
OiBtdWx0aWNhc3QgZ3JvdXAgY29udGV4dCBpbmZvDQo+ID4gICAgKi8NCj4gPiAtc3RhdGljIGVu
dW0gaXJkbWFfc3RhdHVzX2NvZGUNCj4gPiAtaXJkbWFfY3JlYXRlX21nX2N0eChzdHJ1Y3QgaXJk
bWFfbWNhc3RfZ3JwX2luZm8gKmluZm8pDQo+ID4gK3N0YXRpYyB2b2lkIGlyZG1hX2NyZWF0ZV9t
Z19jdHgoc3RydWN0IGlyZG1hX21jYXN0X2dycF9pbmZvICppbmZvKQ0KPiA+ICAgew0KPiA+ICAg
CXN0cnVjdCBpcmRtYV9tY2FzdF9ncnBfY3R4X2VudHJ5X2luZm8gKmVudHJ5X2luZm8gPSBOVUxM
Ow0KPiA+ICAgCXU4IGlkeCA9IDA7IC8qIGluZGV4IGluIHRoZSBhcnJheSAqLyBAQCAtMTA2LDgg
KzEwNSw2IEBADQo+ID4gaXJkbWFfY3JlYXRlX21nX2N0eChzdHJ1Y3QgaXJkbWFfbWNhc3RfZ3Jw
X2luZm8gKmluZm8pDQo+ID4gICAJCQljdHhfaWR4Kys7DQo+ID4gICAJCX0NCj4gPiAgIAl9DQo+
ID4gLQ0KPiA+IC0JcmV0dXJuIDA7DQo+ID4gICB9DQo+ID4NCj4gPiAgIC8qKg0KPiA+IEBAIC0x
MzUsOSArMTMyLDcgQEAgZW51bSBpcmRtYV9zdGF0dXNfY29kZQ0KPiBpcmRtYV9hY2Nlc3NfbWNh
c3RfZ3JwKHN0cnVjdCBpcmRtYV9zY19jcXAgKmNxcCwNCj4gPiAgIAkJcmV0dXJuIElSRE1BX0VS
Ul9SSU5HX0ZVTEw7DQo+ID4gICAJfQ0KPiA+DQo+ID4gLQlyZXRfY29kZSA9IGlyZG1hX2NyZWF0
ZV9tZ19jdHgoaW5mbyk7DQo+ID4gLQlpZiAocmV0X2NvZGUpDQo+ID4gLQkJcmV0dXJuIHJldF9j
b2RlOw0KPiA+ICsJaXJkbWFfY3JlYXRlX21nX2N0eChpbmZvKTsNCg0KcmV0X2NvZGUgaXMgdW51
c2VkIG5vdz8gR2V0IHJpZCBvZiBpdD8NCg0KU2hpcmF6DQo=
