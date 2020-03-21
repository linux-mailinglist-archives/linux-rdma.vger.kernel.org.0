Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F006218DF31
	for <lists+linux-rdma@lfdr.de>; Sat, 21 Mar 2020 10:38:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728214AbgCUJic (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 21 Mar 2020 05:38:32 -0400
Received: from m13-115.163.com ([220.181.13.115]:34928 "EHLO m13-115.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727451AbgCUJic (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sat, 21 Mar 2020 05:38:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=Date:From:Subject:MIME-Version:Message-ID; bh=MUrWh
        A4i5wFNkVbhHjikx0YiJgcdClQJvnMzXKrXT2c=; b=huEvJWJbteoii4YDIVd07
        +CO37dAbMCqLFMQSlJoVqv1Yd+lcEgavNiGSfwc27EaSOvYDHkysRGwlYcHz655Q
        JnloI8Xw5TzQry/2/1XR+XK9fC0/ATXGiDroFVueI+vdImtLfo0AKZcawd0NtUaz
        4OVaXfvPjBgOkdGdtvd3RA=
Received: from weis0906$163.com ( [61.158.152.207] ) by
 ajax-webmail-wmsvr115 (Coremail) ; Sat, 21 Mar 2020 17:38:22 +0800 (CST)
X-Originating-IP: [61.158.152.207]
Date:   Sat, 21 Mar 2020 17:38:22 +0800 (CST)
From:   aaa <weis0906@163.com>
To:     linux-rdma@vger.kernel.org
Subject: bug report
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.10 build 20190724(ac680a23)
 Copyright (c) 2002-2020 www.mailtech.cn 163com
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <7d6dbaa3.9c0a.170fc752aec.Coremail.weis0906@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: c8GowACXpu6O4HVe4HkKAA--.51336W
X-CM-SenderInfo: pzhl2iqzqwqiywtou0bp/1tbiXxXtD115wptG7wABs9
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

CgoKCgoKCkRlYXIgc2lyOgrCoCDCoCBJIGhhdmUgZm9sbG93ZWQgdGhlIGluc3RydWN0aW9ucyJU
byBzZXQgdXAgc29mdHdhcmUgUkRNQSBvbiBhbiBleGlzdGluZyBpbnRlcmZhY2Ugd2l0aCBlaXRo
ZXIgb2YgdGhlIGF2YWlsYWJsZSBkcml2ZXJzLCB1c2UgdGhlIGZvbGxvd2luZyBjb21tYW5kcywg
c3Vic3RpdHV0aW5nwqA8RFJJVkVSPsKgd2l0aCB0aGUgbmFtZSBvZiB0aGUgZHJpdmVyIG9mIHlv
dXIgY2hvaWNlIChyZG1hX3J4ZcKgb3LCoHNpdykgYW5kwqA8VFlQRT7CoHdpdGggdGhlIHR5cGUg
Y29ycmVzcG9uZGluZyB0byB0aGUgZHJpdmVyIChyeGXCoG9ywqBzaXcpLgojIG1vZHByb2JlIDxE
UklWRVI+CiMgcmRtYSBsaW5rIGFkZCA8TkFNRT4gdHlwZSA8VFlQRT4gbmV0ZGV2IDxERVZJQ0U+
CgpQbGVhc2Ugbm90ZSB0aGF0IHlvdSBuZWVkIHZlcnNpb24gb2bCoGlwcm91dGUywqByZWNlbnQg
ZW5vdWdoIGlzIHJlcXVpcmVkIGZvciB0aGUgY29tbWFuZCBhYm92ZSB0byB3b3JrLgpZb3UgY2Fu
IHVzZSBlaXRoZXLCoGlidl9kZXZpY2VzwqBvcsKgcmRtYSBsaW5rwqB0byB2ZXJpZnkgdGhhdCB0
aGUgZGV2aWNlIHdhcyBzdWNjZXNzZnVsbHkgYWRkZWQuIgpidXQgd2hlbiBJIGV4ZWN1dGXCoHJk
bWEgbGluayBhZGQsIGl0IGNhbm4ndCBmaW5kIHRoZSBjb21tYW5kLCBzbyBob3cgY2FuIGkgc29s
dmUgaXQuIFRoYW5rIHlvdSB2ZXJ5IG11Y2ghCm15IGNvbW1hbmRzIGhpc3RvcnkgaXMgc2hvd2Vk
IGFzIGJlbG93LgoKCgoKemh1bXNAemh1bXMtdmlydHVhbC1tYWNoaW5lOn4vcmRtYS1jb3JlL3By
b3ZpZGVycy9yeGUvbWFuJCByZG1hIGxpbmsgYWRkCuacquaJvuWIsCAncmRtYScg5ZG95Luk77yM
5oKo6KaB6L6T5YWl55qE5piv5ZCm5piv77yaCiDlkb3ku6QgJ2RtYScg5p2l6Ieq5LqO5YyFICdk
bWEnICh1bml2ZXJzZSkKcmRtYe+8muacquaJvuWIsOWRveS7pAp6aHVtc0B6aHVtcy12aXJ0dWFs
LW1hY2hpbmU6fi9yZG1hLWNvcmUvcHJvdmlkZXJzL3J4ZS9tYW4kIG1vZHByb2JlIAptb2Rwcm9i
ZTogRVJST1I6IG1pc3NpbmcgcGFyYW1ldGVycy4gU2VlIC1oLgp6aHVtc0B6aHVtcy12aXJ0dWFs
LW1hY2hpbmU6fi9yZG1hLWNvcmUvcHJvdmlkZXJzL3J4ZS9tYW4kIG1vZHByb2JlIHJkbWFfcnhl
CnpodW1zQHpodW1zLXZpcnR1YWwtbWFjaGluZTp+L3JkbWEtY29yZS9wcm92aWRlcnMvcnhlL21h
biQgbW9kaW5mbyByZG1hX3J4ZQpmaWxlbmFtZTogICAgICAgL2xpYi9tb2R1bGVzLzQuMTUuMC04
OC1nZW5lcmljL2tlcm5lbC9kcml2ZXJzL2luZmluaWJhbmQvc3cvcnhlL3JkbWFfcnhlLmtvCmxp
Y2Vuc2U6ICAgICAgICBEdWFsIEJTRC9HUEwKZGVzY3JpcHRpb246ICAgIFNvZnQgUkRNQSB0cmFu
c3BvcnQKYXV0aG9yOiAgICAgICAgIEJvYiBQZWFyc29uLCBGcmFuayBaYWdvLCBKb2huIEdyb3Zl
cywgS2FtYWwgSGVpYgpzcmN2ZXJzaW9uOiAgICAgMzMwMUMzRDAxNkU4OTNDM0YzMjdCMTQKZGVw
ZW5kczogICAgICAgIGliX2NvcmUsaXA2X3VkcF90dW5uZWwsdWRwX3R1bm5lbApyZXRwb2xpbmU6
ICAgICAgWQppbnRyZWU6ICAgICAgICAgWQpuYW1lOiAgICAgICAgICAgcmRtYV9yeGUKdmVybWFn
aWM6ICAgICAgIDQuMTUuMC04OC1nZW5lcmljIFNNUCBtb2RfdW5sb2FkIApwYXJtOiAgICAgICAg
ICAgYWRkOkNyZWF0ZSBSWEUgZGV2aWNlIG92ZXIgbmV0d29yayBpbnRlcmZhY2UKcGFybTogICAg
ICAgICAgIHJlbW92ZTpSZW1vdmUgUlhFIGRldmljZSBvdmVyIG5ldHdvcmsgaW50ZXJmYWNlCnpo
dW1zQHpodW1zLXZpcnR1YWwtbWFjaGluZTp+L3JkbWEtY29yZS9wcm92aWRlcnMvcnhlL21hbiQg
c3VkbyBhcHQtZ2V0IGluc3RhbGwgaXByb3V0ZTIK5q2j5Zyo6K+75Y+W6L2v5Lu25YyF5YiX6KGo
Li4uIOWujOaIkArmraPlnKjliIbmnpDova/ku7bljIXnmoTkvp3otZblhbPns7vmoJEgICAgICAg
Cuato+WcqOivu+WPlueKtuaAgeS/oeaBry4uLiDlrozmiJAgICAgICAgCmlwcm91dGUyIOW3sue7
j+aYr+acgOaWsOeJiCAoNC4zLjAtMXVidW50dTMuMTYuMDQuNSnjgIIKCgoKCgoKICAKIAogICAK
IAoKCgrCoAoKCsKg
