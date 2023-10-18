Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 837487CE896
	for <lists+linux-rdma@lfdr.de>; Wed, 18 Oct 2023 22:14:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229697AbjJRUOu (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 18 Oct 2023 16:14:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbjJRUOt (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 18 Oct 2023 16:14:49 -0400
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com [IPv6:2001:4860:4864:20::2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29FA7B8;
        Wed, 18 Oct 2023 13:14:47 -0700 (PDT)
Received: by mail-oa1-x2e.google.com with SMTP id 586e51a60fabf-1e993765c1bso4608861fac.3;
        Wed, 18 Oct 2023 13:14:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697660086; x=1698264886; darn=vger.kernel.org;
        h=in-reply-to:from:references:cc:to:content-language:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SWb3H/fHLV9lEKSB68WKNLflnXdFW1n7ByVtXxxeXvg=;
        b=cMFimPFKKG3SC8xhMaOmys0x5CfVDIaoCxCr01/cRHgEzDfQjpo3CDSlpCdfofmJMn
         S8QOTFUB5BCpAC8Ve4506Aw904VFe9i5mOkSRAYS4G7sYky0qIkXE9H0nBprLT7GY60N
         gYZOmOqvt6a1Gecw0x88Yy1HiOvrBg8Y/GA5dJYPdf8iDWTC5IAP/DSvMcJR+C+9E5FF
         vM0b4jLjx/yW319DiauLEgP3e2GMNhYgDusk9luCkytncL+VPI9pp5FGpsO+wOsdTC/4
         K3MDVI1rofH+Av/US6ji/RZHONMiG26M6wiZPVjerOGXw+NprJV9D/mWgCIV0kbZcwCF
         zC/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697660086; x=1698264886;
        h=in-reply-to:from:references:cc:to:content-language:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=SWb3H/fHLV9lEKSB68WKNLflnXdFW1n7ByVtXxxeXvg=;
        b=vO7t5Of9a2qlUQi5OwoIiFE++cdv8zgyX+OAbvW1/u3VQi/54h3ITQkxnloP1tvlrO
         Re5SoMkjp6wxVXEzKE9ZQY0G93rGjqtCS8h70cRmUhu2DLqpmt5kY8HNX8WVUdUyRRve
         XNQ835ErtZurOwFJw9GSLVjX/kSWzjjBVwRPdsnbn9jNr4DJhc4NNJDQ6uRlenvK5Air
         mo255FzjeXwzHU2UxT23YKS0QWbSpg8abBz0VH/Kt2L3ubGX8CzJrsLFK2EczJXGnY6u
         zMBDEPKDHznNA/SSvby8msVIfSOW90IQqd2yqDNuNswDPkDy5m2EECSXgWfuZ282N/tA
         XRSg==
X-Gm-Message-State: AOJu0YzFF5MHqZvYQ2QIHCr+xdCjO1jqWY9dfKUzeLdx16cMcAbcqqIH
        kA33UjdBSZ626jC8YK8FZLI=
X-Google-Smtp-Source: AGHT+IFqsa6lrmNpuupddLkJEwiiWrFGF4BqQitPkxF4sTE1tbhylil5/xPB/k6gJ8f1mF0yzJ3nTQ==
X-Received: by 2002:a05:6870:5b94:b0:1e9:9aa6:eeca with SMTP id em20-20020a0568705b9400b001e99aa6eecamr486227oab.1.1697660086389;
        Wed, 18 Oct 2023 13:14:46 -0700 (PDT)
Received: from ?IPV6:2603:8081:1405:679b:65c5:47f5:fc42:655d? (2603-8081-1405-679b-65c5-47f5-fc42-655d.res6.spectrum.com. [2603:8081:1405:679b:65c5:47f5:fc42:655d])
        by smtp.gmail.com with ESMTPSA id ec44-20020a0568708c2c00b001e9dc5c73e4sm833098oab.31.2023.10.18.13.14.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Oct 2023 13:14:45 -0700 (PDT)
Content-Type: multipart/mixed; boundary="------------l0Abatd6cA7WFKsrrPCKzhcR"
Message-ID: <9b43b25e-f0ea-4536-8387-afd4948b4ff6@gmail.com>
Date:   Wed, 18 Oct 2023 15:14:44 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [bug report] blktests srp/002 hang
Content-Language: en-US
To:     Bart Van Assche <bvanassche@acm.org>,
        Jason Gunthorpe <jgg@ziepe.ca>
Cc:     "Daisuke Matsuda (Fujitsu)" <matsuda-daisuke@fujitsu.com>,
        'Rain River' <rain.1986.08.12@gmail.com>,
        Zhu Yanjun <yanjun.zhu@linux.dev>,
        "leon@kernel.org" <leon@kernel.org>,
        Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>
References: <20231017185139.GA691768@ziepe.ca>
 <c65f92b2-9821-4349-b1f5-7dc2a287946a@gmail.com>
 <08a8d947-25b5-434c-9ba3-282d298b5bfd@acm.org>
 <e3d91c4f-b124-4031-9f92-fcb61973a645@gmail.com>
 <02cd10fd-fd4a-4ad7-9b1d-6d37b070aacf@acm.org>
 <5c6e69b3-f83b-461d-a08a-37bfbd82f995@gmail.com>
 <cad2fee4-9359-4614-b36b-c2599dc12358@acm.org>
 <bf2705ff-716a-45b5-bcc4-8710ea0fb98e@gmail.com>
 <65b871ef-dd93-4bfb-bae9-c147a87c64d0@acm.org>
 <dbd9f019-693f-476c-aa4c-739746753d2b@gmail.com>
 <20231018191735.GC691768@ziepe.ca>
 <8e7dbd64-856d-47cc-9d2f-73aa101afa11@acm.org>
From:   Bob Pearson <rpearsonhpe@gmail.com>
In-Reply-To: <8e7dbd64-856d-47cc-9d2f-73aa101afa11@acm.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

This is a multi-part message in MIME format.
--------------l0Abatd6cA7WFKsrrPCKzhcR
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/18/23 14:48, Bart Van Assche wrote:
> 
> On 10/18/23 12:17, Jason Gunthorpe wrote:
>> If siw hangs as well, I definitely comfortable continuing to debug and
>> leaving the work queues in-tree for now.
> 
> Regarding the KASAN complaint that I shared about one month ago, can that complaint have any other root cause than the patch "RDMA/rxe: Add
> workqueue support for rxe tasks"? That report shows a use-after-free by
> rxe code with a pointer to memory that was owned by the rxe driver and
> that was freed by the rxe driver. That memory is an skbuff. The rxe
> driver manages skbuffs. The SRP driver doesn't even know about these
> skbuff objects. See also https://lore.kernel.org/linux-rdma/8ee2869b-3f51-4195-9883-015cd30b4241@acm.org/
> 
> Thanks,
> 
> Bart.
> 

And here are the patches to ib_srp I have. I will retry with a clean version to see what happens.

Bob
--------------l0Abatd6cA7WFKsrrPCKzhcR
Content-Type: text/x-patch; charset=UTF-8; name="ib_srp.diff"
Content-Disposition: attachment; filename="ib_srp.diff"
Content-Transfer-Encoding: base64

ZGlmZiAtLWdpdCBhL2RyaXZlcnMvaW5maW5pYmFuZC91bHAvc3JwL2liX3NycC5jIGIvZHJp
dmVycy9pbmZpbmliYW5kL3VscC9zcnAvaWJfc3JwLmMKaW5kZXggMTU3NDIxODc2NGUwLi4x
Yjk5MTllMDgxNzYgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvaW5maW5pYmFuZC91bHAvc3JwL2li
X3NycC5jCisrKyBiL2RyaXZlcnMvaW5maW5pYmFuZC91bHAvc3JwL2liX3NycC5jCkBAIC01
MTIsOSArNTEyLDExIEBAIHN0YXRpYyBzdHJ1Y3Qgc3JwX2ZyX3Bvb2wgKnNycF9hbGxvY19m
cl9wb29sKHN0cnVjdCBzcnBfdGFyZ2V0X3BvcnQgKnRhcmdldCkKICAqLwogc3RhdGljIHZv
aWQgc3JwX2Rlc3Ryb3lfcXAoc3RydWN0IHNycF9yZG1hX2NoICpjaCkKIHsKLQlzcGluX2xv
Y2tfaXJxKCZjaC0+bG9jayk7Ci0JaWJfcHJvY2Vzc19jcV9kaXJlY3QoY2gtPnNlbmRfY3Es
IC0xKTsKLQlzcGluX3VubG9ja19pcnEoJmNoLT5sb2NrKTsKKwkvL3NwaW5fbG9ja19pcnEo
JmNoLT5sb2NrKTsKKwkvL3ByX2luZm8oInFwIyUwM2Q6ICVzIHRvIGliX3Byb2Nlc3NfY3Ff
ZGlyZWN0XG4iLAorCQkJLy9jaC0+cXAtPnFwX251bSwgX19mdW5jX18pOworCS8vaWJfcHJv
Y2Vzc19jcV9kaXJlY3QoY2gtPnNlbmRfY3EsIC0xKTsKKwkvL3NwaW5fdW5sb2NrX2lycSgm
Y2gtPmxvY2spOwogCiAJaWJfZHJhaW5fcXAoY2gtPnFwKTsKIAlpYl9kZXN0cm95X3FwKGNo
LT5xcCk7CkBAIC01NDQsOCArNTQ2LDEwIEBAIHN0YXRpYyBpbnQgc3JwX2NyZWF0ZV9jaF9p
YihzdHJ1Y3Qgc3JwX3JkbWFfY2ggKmNoKQogCQlnb3RvIGVycjsKIAl9CiAKKwkvL3NlbmRf
Y3EgPSBpYl9hbGxvY19jcShkZXYtPmRldiwgY2gsIG0gKiB0YXJnZXQtPnF1ZXVlX3NpemUs
CisJCQkJLy9jaC0+Y29tcF92ZWN0b3IsIElCX1BPTExfRElSRUNUKTsKIAlzZW5kX2NxID0g
aWJfYWxsb2NfY3EoZGV2LT5kZXYsIGNoLCBtICogdGFyZ2V0LT5xdWV1ZV9zaXplLAotCQkJ
CWNoLT5jb21wX3ZlY3RvciwgSUJfUE9MTF9ESVJFQ1QpOworCQkJCWNoLT5jb21wX3ZlY3Rv
ciwgSUJfUE9MTF9TT0ZUSVJRKTsKIAlpZiAoSVNfRVJSKHNlbmRfY3EpKSB7CiAJCXJldCA9
IFBUUl9FUlIoc2VuZF9jcSk7CiAJCWdvdG8gZXJyX3JlY3ZfY3E7CkBAIC0xMTU0LDEyICsx
MTU4LDE5IEBAIHN0YXRpYyBpbnQgc3JwX2Nvbm5lY3RfY2goc3RydWN0IHNycF9yZG1hX2No
ICpjaCwgdWludDMyX3QgbWF4X2l1X2xlbiwKIAogc3RhdGljIHZvaWQgc3JwX2ludl9ya2V5
X2Vycl9kb25lKHN0cnVjdCBpYl9jcSAqY3EsIHN0cnVjdCBpYl93YyAqd2MpCiB7CisJc3Ry
dWN0IHNycF9yZG1hX2NoICpjaCA9IGNxLT5jcV9jb250ZXh0OworCisJcHJfZXJyKCJxcCMl
MDNkOiBpbnZfcmtleS1kb25lOiBvcGNvZGU6ICVkIHN0YXR1czogJWQ6IGxlbjogJWRcbiIs
CisJCQljaC0+cXAtPnFwX251bSwgd2MtPm9wY29kZSwgd2MtPnN0YXR1cywgd2MtPmJ5dGVf
bGVuKTsKKwogCXNycF9oYW5kbGVfcXBfZXJyKGNxLCB3YywgIklOViBSS0VZIik7CiB9CiAK
IHN0YXRpYyBpbnQgc3JwX2ludl9ya2V5KHN0cnVjdCBzcnBfcmVxdWVzdCAqcmVxLCBzdHJ1
Y3Qgc3JwX3JkbWFfY2ggKmNoLAogCQl1MzIgcmtleSkKIHsKKwlpbnQgcmV0OworCiAJc3Ry
dWN0IGliX3NlbmRfd3Igd3IgPSB7CiAJCS5vcGNvZGUJCSAgICA9IElCX1dSX0xPQ0FMX0lO
ViwKIAkJLm5leHQJCSAgICA9IE5VTEwsCkBAIC0xMTcwLDcgKzExODEsMTIgQEAgc3RhdGlj
IGludCBzcnBfaW52X3JrZXkoc3RydWN0IHNycF9yZXF1ZXN0ICpyZXEsIHN0cnVjdCBzcnBf
cmRtYV9jaCAqY2gsCiAKIAl3ci53cl9jcWUgPSAmcmVxLT5yZWdfY3FlOwogCXJlcS0+cmVn
X2NxZS5kb25lID0gc3JwX2ludl9ya2V5X2Vycl9kb25lOwotCXJldHVybiBpYl9wb3N0X3Nl
bmQoY2gtPnFwLCAmd3IsIE5VTEwpOworCXJldCA9IGliX3Bvc3Rfc2VuZChjaC0+cXAsICZ3
ciwgTlVMTCk7CisJaWYgKHJldCkKKwkJcHJfZXJyKCJxcCMlMDNkOiAlczogcmV0ID0gJWRc
biIsIGNoLT5xcC0+cXBfbnVtLCBfX2Z1bmNfXywgcmV0KTsKKwllbHNlCisJCXByX2luZm8o
InFwIyUwM2Q6IHBvc3QtaW52X3JrZXk6ICUjeCIsIGNoLT5xcC0+cXBfbnVtLCBya2V5KTsK
KwlyZXR1cm4gcmV0OwogfQogCiBzdGF0aWMgdm9pZCBzcnBfdW5tYXBfZGF0YShzdHJ1Y3Qg
c2NzaV9jbW5kICpzY21uZCwKQEAgLTE0MDgsNiArMTQyNCwxMSBAQCBzdGF0aWMgdm9pZCBz
cnBfbWFwX2Rlc2Moc3RydWN0IHNycF9tYXBfc3RhdGUgKnN0YXRlLCBkbWFfYWRkcl90IGRt
YV9hZGRyLAogCiBzdGF0aWMgdm9pZCBzcnBfcmVnX21yX2Vycl9kb25lKHN0cnVjdCBpYl9j
cSAqY3EsIHN0cnVjdCBpYl93YyAqd2MpCiB7CisJc3RydWN0IHNycF9yZG1hX2NoICpjaCA9
IGNxLT5jcV9jb250ZXh0OworCisJcHJfZXJyKCJxcCMlMDNkOiByZWdfbXItZG9uZTogb3Bj
b2RlOiAlZCBzdGF0dXM6ICVkOiBsZW46ICVkXG4iLAorCQkJY2gtPnFwLT5xcF9udW0sIHdj
LT5vcGNvZGUsIHdjLT5zdGF0dXMsIHdjLT5ieXRlX2xlbik7CisKIAlzcnBfaGFuZGxlX3Fw
X2VycihjcSwgd2MsICJGQVNUIFJFRyIpOwogfQogCkBAIC0xNDg4LDYgKzE1MDksMTEgQEAg
c3RhdGljIGludCBzcnBfbWFwX2ZpbmlzaF9mcihzdHJ1Y3Qgc3JwX21hcF9zdGF0ZSAqc3Rh
dGUsCiAJCSAgICAgZGVzYy0+bXItPmxlbmd0aCwgZGVzYy0+bXItPnJrZXkpOwogCiAJZXJy
ID0gaWJfcG9zdF9zZW5kKGNoLT5xcCwgJndyLndyLCBOVUxMKTsKKwlpZiAoZXJyKQorCQlw
cl9lcnIoInFwIyUwM2Q6ICVzOiBlcnIgPSAlZFxuIiwgY2gtPnFwLT5xcF9udW0sIF9fZnVu
Y19fLCBlcnIpOworCWVsc2UKKwkJcHJfaW5mbygicXAjJTAzZDogcG9zdC1yZWdfbXI6ICUj
eFxuIiwgY2gtPnFwLT5xcF9udW0sCisJCQkJZGVzYy0+bXItPnJrZXkpOwogCWlmICh1bmxp
a2VseShlcnIpKSB7CiAJCVdBUk5fT05fT05DRShlcnIgPT0gLUVOT01FTSk7CiAJCXJldHVy
biBlcnI7CkBAIC0xODQwLDEwICsxODY2LDE0IEBAIHN0YXRpYyBzdHJ1Y3Qgc3JwX2l1ICpf
X3NycF9nZXRfdHhfaXUoc3RydWN0IHNycF9yZG1hX2NoICpjaCwKIAogCWxvY2tkZXBfYXNz
ZXJ0X2hlbGQoJmNoLT5sb2NrKTsKIAotCWliX3Byb2Nlc3NfY3FfZGlyZWN0KGNoLT5zZW5k
X2NxLCAtMSk7CisJLy9wcl9pbmZvKCJxcCMlMDNkOiAlcyB0byBpYl9wcm9jZXNzX2NxX2Rp
cmVjdFxuIiwKKwkJCS8vY2gtPnFwLT5xcF9udW0sIF9fZnVuY19fKTsKKwkvL2liX3Byb2Nl
c3NfY3FfZGlyZWN0KGNoLT5zZW5kX2NxLCAtMSk7CiAKLQlpZiAobGlzdF9lbXB0eSgmY2gt
PmZyZWVfdHgpKQorCWlmIChsaXN0X2VtcHR5KCZjaC0+ZnJlZV90eCkpIHsKKwkJcHJfZXJy
KCIlczogcmFuIG91dCBvZiBpdVxuIiwgX19mdW5jX18pOwogCQlyZXR1cm4gTlVMTDsKKwl9
CiAKIAkvKiBJbml0aWF0b3IgcmVzcG9uc2VzIHRvIHRhcmdldCByZXF1ZXN0cyBkbyBub3Qg
Y29uc3VtZSBjcmVkaXRzICovCiAJaWYgKGl1X3R5cGUgIT0gU1JQX0lVX1JTUCkgewpAQCAt
MTg2OSwxNSArMTg5OSwyMiBAQCBzdGF0aWMgdm9pZCBzcnBfc2VuZF9kb25lKHN0cnVjdCBp
Yl9jcSAqY3EsIHN0cnVjdCBpYl93YyAqd2MpCiB7CiAJc3RydWN0IHNycF9pdSAqaXUgPSBj
b250YWluZXJfb2Yod2MtPndyX2NxZSwgc3RydWN0IHNycF9pdSwgY3FlKTsKIAlzdHJ1Y3Qg
c3JwX3JkbWFfY2ggKmNoID0gY3EtPmNxX2NvbnRleHQ7CisJLyoqL3Vuc2lnbmVkIGxvbmcg
ZmxhZ3M7CisKKwlwcl9pbmZvKCJxcCMlMDNkOiBzZW5kLWRvbmU6IG9wY29kZTogJWQgc3Rh
dHVzOiAlZDogbGVuOiAlZFxuIiwKKwkJCWNoLT5xcC0+cXBfbnVtLCB3Yy0+b3Bjb2RlLCB3
Yy0+c3RhdHVzLCB3Yy0+Ynl0ZV9sZW4pOwogCiAJaWYgKHVubGlrZWx5KHdjLT5zdGF0dXMg
IT0gSUJfV0NfU1VDQ0VTUykpIHsKIAkJc3JwX2hhbmRsZV9xcF9lcnIoY3EsIHdjLCAiU0VO
RCIpOwogCQlyZXR1cm47CiAJfQogCisKKwkvKiovc3Bpbl9sb2NrX2lycXNhdmUoJmNoLT5s
b2NrLCBmbGFncyk7CiAJbG9ja2RlcF9hc3NlcnRfaGVsZCgmY2gtPmxvY2spOwogCiAJbGlz
dF9hZGQoJml1LT5saXN0LCAmY2gtPmZyZWVfdHgpOworCS8qKi9zcGluX3VubG9ja19pcnFy
ZXN0b3JlKCZjaC0+bG9jaywgZmxhZ3MpOwogfQogCiAvKioKQEAgLTE4OTAsNiArMTkyNyw3
IEBAIHN0YXRpYyBpbnQgc3JwX3Bvc3Rfc2VuZChzdHJ1Y3Qgc3JwX3JkbWFfY2ggKmNoLCBz
dHJ1Y3Qgc3JwX2l1ICppdSwgaW50IGxlbikKIHsKIAlzdHJ1Y3Qgc3JwX3RhcmdldF9wb3J0
ICp0YXJnZXQgPSBjaC0+dGFyZ2V0OwogCXN0cnVjdCBpYl9zZW5kX3dyIHdyOworCWludCBy
ZXQ7CiAKIAlpZiAoV0FSTl9PTl9PTkNFKGl1LT5udW1fc2dlID4gU1JQX01BWF9TR0UpKQog
CQlyZXR1cm4gLUVJTlZBTDsKQEAgLTE5MDcsNyArMTk0NSwxMiBAQCBzdGF0aWMgaW50IHNy
cF9wb3N0X3NlbmQoc3RydWN0IHNycF9yZG1hX2NoICpjaCwgc3RydWN0IHNycF9pdSAqaXUs
IGludCBsZW4pCiAJd3Iub3Bjb2RlICAgICA9IElCX1dSX1NFTkQ7CiAJd3Iuc2VuZF9mbGFn
cyA9IElCX1NFTkRfU0lHTkFMRUQ7CiAKLQlyZXR1cm4gaWJfcG9zdF9zZW5kKGNoLT5xcCwg
JndyLCBOVUxMKTsKKwlyZXQgPSBpYl9wb3N0X3NlbmQoY2gtPnFwLCAmd3IsIE5VTEwpOwor
CWlmIChyZXQpCisJCXByX2VycigicXAjJTAzZDogJXM6IHJldCA9ICVkXG4iLCBjaC0+cXAt
PnFwX251bSwgX19mdW5jX18sIHJldCk7CisJZWxzZQorCQlwcl9pbmZvKCJxcCMlMDNkOiBw
b3N0LXNlbmQ6XG4iLCBjaC0+cXAtPnFwX251bSk7CisJcmV0dXJuIHJldDsKIH0KIAogc3Rh
dGljIGludCBzcnBfcG9zdF9yZWN2KHN0cnVjdCBzcnBfcmRtYV9jaCAqY2gsIHN0cnVjdCBz
cnBfaXUgKml1KQpAQCAtMTkxNSw2ICsxOTU4LDcgQEAgc3RhdGljIGludCBzcnBfcG9zdF9y
ZWN2KHN0cnVjdCBzcnBfcmRtYV9jaCAqY2gsIHN0cnVjdCBzcnBfaXUgKml1KQogCXN0cnVj
dCBzcnBfdGFyZ2V0X3BvcnQgKnRhcmdldCA9IGNoLT50YXJnZXQ7CiAJc3RydWN0IGliX3Jl
Y3Zfd3Igd3I7CiAJc3RydWN0IGliX3NnZSBsaXN0OworCWludCByZXQ7CiAKIAlsaXN0LmFk
ZHIgICA9IGl1LT5kbWE7CiAJbGlzdC5sZW5ndGggPSBpdS0+c2l6ZTsKQEAgLTE5MjcsNyAr
MTk3MSwxMiBAQCBzdGF0aWMgaW50IHNycF9wb3N0X3JlY3Yoc3RydWN0IHNycF9yZG1hX2No
ICpjaCwgc3RydWN0IHNycF9pdSAqaXUpCiAJd3Iuc2dfbGlzdCAgPSAmbGlzdDsKIAl3ci5u
dW1fc2dlICA9IDE7CiAKLQlyZXR1cm4gaWJfcG9zdF9yZWN2KGNoLT5xcCwgJndyLCBOVUxM
KTsKKwlyZXQgPSBpYl9wb3N0X3JlY3YoY2gtPnFwLCAmd3IsIE5VTEwpOworCWlmIChyZXQp
CisJCXByX2VycigicXAjJTAzZDogJXM6IHJldCA9ICVkXG4iLCBjaC0+cXAtPnFwX251bSwg
X19mdW5jX18sIHJldCk7CisJZWxzZQorCQlwcl9pbmZvKCJxcCMlMDNkOiBwb3N0LXJlY3Y6
XG4iLCBjaC0+cXAtPnFwX251bSk7CisJcmV0dXJuIHJldDsKIH0KIAogc3RhdGljIHZvaWQg
c3JwX3Byb2Nlc3NfcnNwKHN0cnVjdCBzcnBfcmRtYV9jaCAqY2gsIHN0cnVjdCBzcnBfcnNw
ICpyc3ApCkBAIC0yMDA0LDggKzIwNTMsOSBAQCBzdGF0aWMgaW50IHNycF9yZXNwb25zZV9j
b21tb24oc3RydWN0IHNycF9yZG1hX2NoICpjaCwgczMyIHJlcV9kZWx0YSwKIAlzcGluX3Vu
bG9ja19pcnFyZXN0b3JlKCZjaC0+bG9jaywgZmxhZ3MpOwogCiAJaWYgKCFpdSkgewotCQlz
aG9zdF9wcmludGsoS0VSTl9FUlIsIHRhcmdldC0+c2NzaV9ob3N0LCBQRlgKLQkJCSAgICAg
Im5vIElVIGF2YWlsYWJsZSB0byBzZW5kIHJlc3BvbnNlXG4iKTsKKwkJcHJfZXJyKCIlczog
bm8gaXUgdG8gc2VuZCByZXNwb25zZVxuIiwgX19mdW5jX18pOworCQkvL3Nob3N0X3ByaW50
ayhLRVJOX0VSUiwgdGFyZ2V0LT5zY3NpX2hvc3QsIFBGWAorCQkJICAgICAvLyJubyBJVSBh
dmFpbGFibGUgdG8gc2VuZCByZXNwb25zZVxuIik7CiAJCXJldHVybiAxOwogCX0KIApAQCAt
MjAzNCw4ICsyMDg0LDkgQEAgc3RhdGljIHZvaWQgc3JwX3Byb2Nlc3NfY3JlZF9yZXEoc3Ry
dWN0IHNycF9yZG1hX2NoICpjaCwKIAlzMzIgZGVsdGEgPSBiZTMyX3RvX2NwdShyZXEtPnJl
cV9saW1fZGVsdGEpOwogCiAJaWYgKHNycF9yZXNwb25zZV9jb21tb24oY2gsIGRlbHRhLCAm
cnNwLCBzaXplb2YocnNwKSkpCi0JCXNob3N0X3ByaW50ayhLRVJOX0VSUiwgY2gtPnRhcmdl
dC0+c2NzaV9ob3N0LCBQRlgKLQkJCSAgICAgInByb2JsZW1zIHByb2Nlc3NpbmcgU1JQX0NS
RURfUkVRXG4iKTsKKwkJcHJfZXJyKCIlczogcHJvYmxlbXMgd2l0aCBjcmVkIHJlcVxuIiwg
X19mdW5jX18pOworCQkvL3Nob3N0X3ByaW50ayhLRVJOX0VSUiwgY2gtPnRhcmdldC0+c2Nz
aV9ob3N0LCBQRlgKKwkJCSAgICAgLy8icHJvYmxlbXMgcHJvY2Vzc2luZyBTUlBfQ1JFRF9S
RVFcbiIpOwogfQogCiBzdGF0aWMgdm9pZCBzcnBfcHJvY2Vzc19hZXJfcmVxKHN0cnVjdCBz
cnBfcmRtYV9jaCAqY2gsCkBAIC0yMDY1LDYgKzIxMTYsOSBAQCBzdGF0aWMgdm9pZCBzcnBf
cmVjdl9kb25lKHN0cnVjdCBpYl9jcSAqY3EsIHN0cnVjdCBpYl93YyAqd2MpCiAJaW50IHJl
czsKIAl1OCBvcGNvZGU7CiAKKwlwcl9pbmZvKCJxcCMlMDNkOiByZWN2LWRvbmU6IG9wY29k
ZTogJWQgc3RhdHVzOiAlZDogbGVuOiAlZFxuIiwKKwkJCWNoLT5xcC0+cXBfbnVtLCB3Yy0+
b3Bjb2RlLCB3Yy0+c3RhdHVzLCB3Yy0+Ynl0ZV9sZW4pOworCiAJaWYgKHVubGlrZWx5KHdj
LT5zdGF0dXMgIT0gSUJfV0NfU1VDQ0VTUykpIHsKIAkJc3JwX2hhbmRsZV9xcF9lcnIoY3Es
IHdjLCAiUkVDViIpOwogCQlyZXR1cm47CkBAIC0yMTczLDggKzIyMjcsMTAgQEAgc3RhdGlj
IGludCBzcnBfcXVldWVjb21tYW5kKHN0cnVjdCBTY3NpX0hvc3QgKnNob3N0LCBzdHJ1Y3Qg
c2NzaV9jbW5kICpzY21uZCkKIAlpdSA9IF9fc3JwX2dldF90eF9pdShjaCwgU1JQX0lVX0NN
RCk7CiAJc3Bpbl91bmxvY2tfaXJxcmVzdG9yZSgmY2gtPmxvY2ssIGZsYWdzKTsKIAotCWlm
ICghaXUpCisJaWYgKCFpdSkgeworCQlwcl9lcnIoIiVzOiBubyBpdSB0byBxdWV1ZSBjb21t
YW5kXG4iLCBfX2Z1bmNfXyk7CiAJCWdvdG8gZXJyOworCX0KIAogCWRldiA9IHRhcmdldC0+
c3JwX2hvc3QtPnNycF9kZXYtPmRldjsKIAlpYl9kbWFfc3luY19zaW5nbGVfZm9yX2NwdShk
ZXYsIGl1LT5kbWEsIGNoLT5tYXhfaXRfaXVfbGVuLApAQCAtMjI0MCw2ICsyMjk2LDcgQEAg
c3RhdGljIGludCBzcnBfcXVldWVjb21tYW5kKHN0cnVjdCBTY3NpX0hvc3QgKnNob3N0LCBz
dHJ1Y3Qgc2NzaV9jbW5kICpzY21uZCkKIAkJc2NzaV9kb25lKHNjbW5kKTsKIAkJcmV0ID0g
MDsKIAl9IGVsc2UgeworCQlwcl9lcnIoIiVzOiByZXR1cm5lZCBTQ1NJX01MUVVFVUVfSE9T
VF9CVVNZXG4iLCBfX2Z1bmNfXyk7CiAJCXJldCA9IFNDU0lfTUxRVUVVRV9IT1NUX0JVU1k7
CiAJfQogCkBAIC0yNzM0LDYgKzI3OTEsNyBAQCBzdGF0aWMgaW50IHNycF9zZW5kX3Rza19t
Z210KHN0cnVjdCBzcnBfcmRtYV9jaCAqY2gsIHU2NCByZXFfdGFnLCB1NjQgbHVuLAogCXNw
aW5fdW5sb2NrX2lycSgmY2gtPmxvY2spOwogCiAJaWYgKCFpdSkgeworCQlwcl9lcnIoIiVz
OiBubyBpdSBmb3IgdGFzayBtYW5hZ2VtZW50XG4iLCBfX2Z1bmNfXyk7CiAJCW11dGV4X3Vu
bG9jaygmcnBvcnQtPm11dGV4KTsKIAogCQlyZXR1cm4gLTE7Cg==

--------------l0Abatd6cA7WFKsrrPCKzhcR--
