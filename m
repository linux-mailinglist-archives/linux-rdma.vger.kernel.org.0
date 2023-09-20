Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B90F17A7180
	for <lists+linux-rdma@lfdr.de>; Wed, 20 Sep 2023 06:22:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231630AbjITEWv (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 20 Sep 2023 00:22:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231269AbjITEWu (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 20 Sep 2023 00:22:50 -0400
Received: from out-223.mta1.migadu.com (out-223.mta1.migadu.com [95.215.58.223])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FFA4B9
        for <linux-rdma@vger.kernel.org>; Tue, 19 Sep 2023 21:22:42 -0700 (PDT)
Content-Type: multipart/mixed; boundary="------------yguV76tzBcgNpfcjOH0jDuNz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1695183760;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CT1OE/HfCHJdigx4odr4CKGEwSgF1MTItKBwhb7WKHU=;
        b=fhqHhnGUm+nJqQnr8JSLiepO11UfFztfSH79dg5gNvNWD5sG0x1G6+Ih2wCtyuLg1/QcI2
        YCt3UjSTdNESvfnEnSiTVoU1/wjxrZXv6R+oewl/jkTbfjZSkLnqRKLtJB/Pq21EA4+kVo
        Etq7Esea71s0j6FWn776lkRHQdT90Nc=
Message-ID: <fe61fdc5-ca8f-2efc-975d-46b99d66c6f5@linux.dev>
Date:   Wed, 20 Sep 2023 12:22:32 +0800
MIME-Version: 1.0
Subject: Re: [bug report] blktests srp/002 hang
To:     Bob Pearson <rpearsonhpe@gmail.com>,
        Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc:     Bart Van Assche <bvanassche@acm.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>
References: <dsg6rd66tyiei32zaxs6ddv5ebefr5vtxjwz6d2ewqrcwisogl@ge7jzan7dg5u>
 <0c5c732c-283c-b29a-0ac2-c32211fc7e17@gmail.com>
 <yewvcfcketee5qduraajra2g37t2mpxdlmj7aqny3umf7mkavk@wsm5forumsou>
 <8be8f611-e413-9584-7c2e-2c1abf4147be@acm.org>
 <plrbpd5gg32uaferhjj6ibkt4wqybu3v3y32f4rlhvsruc7cu4@2pgrj2542da2>
 <18a3ae8c-145b-4c7f-a8f5-67840feeb98c@acm.org>
 <ab93655f-c187-fdab-6c67-3bfb2d9aa516@gmail.com>
 <9dd0aa0a-d696-a95b-095b-f54d6d31a6ab@linux.dev>
 <d3205633-0cd2-f87e-1c40-21b8172b6da3@linux.dev>
 <nqdsj764d7e56kxevcwnq6qoi6ptuu3bi6ntfakb55vm3toda7@eo3ffzzqrot7>
 <5a4efe6f-d8c6-84ce-377e-eb64bcad706c@linux.dev>
 <f50beb15-2cab-dfb9-3b58-ea66e7f114a6@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <f50beb15-2cab-dfb9-3b58-ea66e7f114a6@gmail.com>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

This is a multi-part message in MIME format.
--------------yguV76tzBcgNpfcjOH0jDuNz
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


在 2023/9/20 2:11, Bob Pearson 写道:
> On 9/19/23 03:07, Zhu Yanjun wrote:
>> 在 2023/9/19 12:14, Shinichiro Kawasaki 写道:
>>> On Sep 16, 2023 / 13:59, Zhu Yanjun wrote:
>>> [...]
>>>> On Debian, with the latest multipathd or revert the commit 9b4b7c1f9f54
>>>> ("RDMA/rxe: Add workqueue support for rxe tasks"), this problem will
>>>> disappear.
>>> Zhu, thank you for the actions.
>>>
>>>> On Fedora 38, if the commit 9b4b7c1f9f54 ("RDMA/rxe: Add workqueue support
>>>> for rxe tasks") is reverted, will this problem still appear?
>>>> I do not have such test environment. The commit is in the attachment,
>>>> can anyone have a test? Please let us know the test result. Thanks.
>>> I tried the latest kernel tag v6.6-rc2 with my Fedora 38 test systems. With the
>>> v6.6-rc2 kernel, I still see the hang. I repeated the blktests test case srp/002
>>> 30 time or so, then the hang was recreated. Then I reverted the commit
>>> 9b4b7c1f9f54 from v6.6-rc2, and the hang disappeared. I repeated the blktests
>>> test case 100 times, and did not see the hang.
>>>
>>> I confirmed these results under two multipathd conditions: 1) with Fedora latest
>>> device-mapper-multipath package v0.9.4, and 2) the latest multipath-tools v0.9.6
>>> that I built from source code.
>>>
>>> So, when the commit gets reverted, the hang disappears as I reported for
>>> v6.5-rcX kernels.
>> Thanks, Shinichiro Kawasaki. Your helps are appreciated.
>>
>> This problem is related with the followings:
>>
>> 1). Linux distributions: Ubuntu, Debian and Fedora;
>>
>> 2). multipathd;
>>
>> 3). the commits 9b4b7c1f9f54 ("RDMA/rxe: Add workqueue support for rxe tasks")
>>
>> On Ubuntu, with or without the commit, this problem does not occur.
>>
>> On Debian, without this commit, this problem does not occur. With this commit, this problem will occur.
>>
>> On Fedora, without this commit, this problem does not occur. With this commit, this problem will occur.
>>
>> The commits 9b4b7c1f9f54 ("RDMA/rxe: Add workqueue support for rxe tasks") is from Bob Pearson.
>>
>> Hi, Bob, do you have any comments about this problem? It seems that this commit is not compatible with blktests.
>>
>> Hi, Jason and Leon, please comment on this problem.
>>
>> Thanks a lot.
>>
>> Zhu Yanjun
> My belief is that the issue is related to timing not the logical operation of the code.
> Work queues are just kernel processes and can be scheduled (if not holding spinlocks)
> while soft IRQs lock up the CPU until they exit. This can cause longer delays in responding
> to ULPs. The work queue tasks for each QP are strictly single threaded which is managed by
> the work queue framework the same as tasklets.

Thanks, Bob. From you, the workqueue can be scheduled, this can cause 
longer delays in reponding to ULPs.

This will cause ULPs to hang. But the tasklet will lock up the CPU until 
it exits. So the tasklet will repond to

ULPs in time.

To this, there are 3 solutins:

1). Try to make workqueue respond ULPs in time, this hang problem should 
be avoided. so this will not cause

this problem. But from the kernel, workqueue should be scheduled,So it 
is difficult to avoid this longer delay.


2). Make tasklet and workqueue both work in RXE.  We can make one of 
tasklet or workqueue as the default. The user

can choose to use tasklet or workqueue via kernel module parameter or 
sysctl variables. This will cost a lot of time

and efforts to implement it.


3). Revert the commit 9b4b7c1f9f54 ("RDMA/rxe: Add workqueue support for 
rxe tasks"). Shinichiro Kawasaki

confirmed that this can fix this regression. And the patch is in the 
attachment.


Hi, Bob, Please comment.

Hi, Jason && Leon, please also comment on this.

Thanks a lot.

>
> Earlier in time I have also seen the exact same hang behavior with the siw driver but not
> recently. Also I have seen sensitivity to logging changes in the hang behavior. These are

This is a regression to RXE which is caused by the the commit 
9b4b7c1f9f54 ("RDMA/rxe: Add workqueue support for rxe tasks").

We should fix it.

Zhu Yanjun

> indications that timing may be the cause of the issue.
>
> Bob
--------------yguV76tzBcgNpfcjOH0jDuNz
Content-Type: text/plain; charset=UTF-8;
 name="0001-Revert-RDMA-rxe-Add-workqueue-support-for-rxe-tasks.patch"
Content-Disposition: attachment;
 filename*0="0001-Revert-RDMA-rxe-Add-workqueue-support-for-rxe-tasks.pat";
 filename*1="ch"
Content-Transfer-Encoding: base64

RnJvbSBmZDIzNjBlZGJjOTE3MTI5OGQyZTkxZmQ5Yjc0YjRjMzAyMmRiOWQ0IE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBaaHUgWWFuanVuIDx5YW5qdW4uemh1QGxpbnV4LmRl
dj4KRGF0ZTogRnJpLCAxNSBTZXAgMjAyMyAyMzowNzoxNyAtMDQwMApTdWJqZWN0OiBbUEFU
Q0ggMS8xXSBSZXZlcnQgIlJETUEvcnhlOiBBZGQgd29ya3F1ZXVlIHN1cHBvcnQgZm9yIHJ4
ZSB0YXNrcyIKClRoaXMgcmV2ZXJ0cyBjb21taXQgOWI0YjdjMWY5ZjU0MTIwOTQwZTI0MzI1
MWUyYjE0MDc3NjdiMzM4MS4KClNpZ25lZC1vZmYtYnk6IFpodSBZYW5qdW4gPHlhbmp1bi56
aHVAbGludXguZGV2PgotLS0KIGRyaXZlcnMvaW5maW5pYmFuZC9zdy9yeGUvcnhlLmMgICAg
ICB8ICAgOSArLS0KIGRyaXZlcnMvaW5maW5pYmFuZC9zdy9yeGUvcnhlX3Rhc2suYyB8IDEx
MCArKysrKysrKysrKystLS0tLS0tLS0tLS0tLS0KIGRyaXZlcnMvaW5maW5pYmFuZC9zdy9y
eGUvcnhlX3Rhc2suaCB8ICAgNiArLQogMyBmaWxlcyBjaGFuZ2VkLCA0OSBpbnNlcnRpb25z
KCspLCA3NiBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2luZmluaWJhbmQv
c3cvcnhlL3J4ZS5jIGIvZHJpdmVycy9pbmZpbmliYW5kL3N3L3J4ZS9yeGUuYwppbmRleCA1
NGM3MjNhNmVkZGEuLjdhN2U3MTNkZTUyZCAxMDA2NDQKLS0tIGEvZHJpdmVycy9pbmZpbmli
YW5kL3N3L3J4ZS9yeGUuYworKysgYi9kcml2ZXJzL2luZmluaWJhbmQvc3cvcnhlL3J4ZS5j
CkBAIC0yMTIsMTUgKzIxMiw5IEBAIHN0YXRpYyBpbnQgX19pbml0IHJ4ZV9tb2R1bGVfaW5p
dCh2b2lkKQogewogCWludCBlcnI7CiAKLQllcnIgPSByeGVfYWxsb2Nfd3EoKTsKLQlpZiAo
ZXJyKQotCQlyZXR1cm4gZXJyOwotCiAJZXJyID0gcnhlX25ldF9pbml0KCk7Ci0JaWYgKGVy
cikgewotCQlyeGVfZGVzdHJveV93cSgpOworCWlmIChlcnIpCiAJCXJldHVybiBlcnI7Ci0J
fQogCiAJcmRtYV9saW5rX3JlZ2lzdGVyKCZyeGVfbGlua19vcHMpOwogCXByX2luZm8oImxv
YWRlZFxuIik7CkBAIC0yMzIsNyArMjI2LDYgQEAgc3RhdGljIHZvaWQgX19leGl0IHJ4ZV9t
b2R1bGVfZXhpdCh2b2lkKQogCXJkbWFfbGlua191bnJlZ2lzdGVyKCZyeGVfbGlua19vcHMp
OwogCWliX3VucmVnaXN0ZXJfZHJpdmVyKFJETUFfRFJJVkVSX1JYRSk7CiAJcnhlX25ldF9l
eGl0KCk7Ci0JcnhlX2Rlc3Ryb3lfd3EoKTsKIAogCXByX2luZm8oInVubG9hZGVkXG4iKTsK
IH0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvaW5maW5pYmFuZC9zdy9yeGUvcnhlX3Rhc2suYyBi
L2RyaXZlcnMvaW5maW5pYmFuZC9zdy9yeGUvcnhlX3Rhc2suYwppbmRleCAxNTAxMTIwZDRm
NTIuLmZiOWE2YmM4ZTYyMCAxMDA2NDQKLS0tIGEvZHJpdmVycy9pbmZpbmliYW5kL3N3L3J4
ZS9yeGVfdGFzay5jCisrKyBiL2RyaXZlcnMvaW5maW5pYmFuZC9zdy9yeGUvcnhlX3Rhc2su
YwpAQCAtNiwyNCArNiw4IEBACiAKICNpbmNsdWRlICJyeGUuaCIKIAotc3RhdGljIHN0cnVj
dCB3b3JrcXVldWVfc3RydWN0ICpyeGVfd3E7Ci0KLWludCByeGVfYWxsb2Nfd3Eodm9pZCkK
LXsKLQlyeGVfd3EgPSBhbGxvY193b3JrcXVldWUoInJ4ZV93cSIsIFdRX1VOQk9VTkQsIFdR
X01BWF9BQ1RJVkUpOwotCWlmICghcnhlX3dxKQotCQlyZXR1cm4gLUVOT01FTTsKLQotCXJl
dHVybiAwOwotfQotCi12b2lkIHJ4ZV9kZXN0cm95X3dxKHZvaWQpCi17Ci0JZGVzdHJveV93
b3JrcXVldWUocnhlX3dxKTsKLX0KLQogLyogQ2hlY2sgaWYgdGFzayBpcyBpZGxlIGkuZS4g
bm90IHJ1bm5pbmcsIG5vdCBzY2hlZHVsZWQgaW4KLSAqIHdvcmsgcXVldWUgYW5kIG5vdCBk
cmFpbmluZy4gSWYgc28gbW92ZSB0byBidXN5IHRvCisgKiB0YXNrbGV0IHF1ZXVlIGFuZCBu
b3QgZHJhaW5pbmcuIElmIHNvIG1vdmUgdG8gYnVzeSB0bwogICogcmVzZXJ2ZSBhIHNsb3Qg
aW4gZG9fdGFzaygpIGJ5IHNldHRpbmcgdG8gYnVzeSBhbmQgdGFraW5nCiAgKiBhIHFwIHJl
ZmVyZW5jZSB0byBjb3ZlciB0aGUgZ2FwIGZyb20gbm93IHVudGlsIHRoZSB0YXNrIGZpbmlz
aGVzLgogICogc3RhdGUgd2lsbCBtb3ZlIG91dCBvZiBidXN5IGlmIHRhc2sgcmV0dXJucyBh
IG5vbiB6ZXJvIHZhbHVlCkBAIC0zNyw2ICsyMSw5IEBAIHN0YXRpYyBib29sIF9fcmVzZXJ2
ZV9pZl9pZGxlKHN0cnVjdCByeGVfdGFzayAqdGFzaykKIHsKIAlXQVJOX09OKHJ4ZV9yZWFk
KHRhc2stPnFwKSA8PSAwKTsKIAorCWlmICh0YXNrLT50YXNrbGV0LnN0YXRlICYgQklUKFRB
U0tMRVRfU1RBVEVfU0NIRUQpKQorCQlyZXR1cm4gZmFsc2U7CisKIAlpZiAodGFzay0+c3Rh
dGUgPT0gVEFTS19TVEFURV9JRExFKSB7CiAJCXJ4ZV9nZXQodGFzay0+cXApOwogCQl0YXNr
LT5zdGF0ZSA9IFRBU0tfU1RBVEVfQlVTWTsKQEAgLTUxLDcgKzM4LDcgQEAgc3RhdGljIGJv
b2wgX19yZXNlcnZlX2lmX2lkbGUoc3RydWN0IHJ4ZV90YXNrICp0YXNrKQogfQogCiAvKiBj
aGVjayBpZiB0YXNrIGlzIGlkbGUgb3IgZHJhaW5lZCBhbmQgbm90IGN1cnJlbnRseQotICog
c2NoZWR1bGVkIGluIHRoZSB3b3JrIHF1ZXVlLiBUaGlzIHJvdXRpbmUgaXMKKyAqIHNjaGVk
dWxlZCBpbiB0aGUgdGFza2xldCBxdWV1ZS4gVGhpcyByb3V0aW5lIGlzCiAgKiBjYWxsZWQg
YnkgcnhlX2NsZWFudXBfdGFzayBvciByeGVfZGlzYWJsZV90YXNrIHRvCiAgKiBzZWUgaWYg
dGhlIHF1ZXVlIGlzIGVtcHR5LgogICogQ29udGV4dDogY2FsbGVyIHNob3VsZCBob2xkIHRh
c2stPmxvY2suCkBAIC01OSw3ICs0Niw3IEBAIHN0YXRpYyBib29sIF9fcmVzZXJ2ZV9pZl9p
ZGxlKHN0cnVjdCByeGVfdGFzayAqdGFzaykKICAqLwogc3RhdGljIGJvb2wgX19pc19kb25l
KHN0cnVjdCByeGVfdGFzayAqdGFzaykKIHsKLQlpZiAod29ya19wZW5kaW5nKCZ0YXNrLT53
b3JrKSkKKwlpZiAodGFzay0+dGFza2xldC5zdGF0ZSAmIEJJVChUQVNLTEVUX1NUQVRFX1ND
SEVEKSkKIAkJcmV0dXJuIGZhbHNlOwogCiAJaWYgKHRhc2stPnN0YXRlID09IFRBU0tfU1RB
VEVfSURMRSB8fApAQCAtOTAsMjMgKzc3LDIzIEBAIHN0YXRpYyBib29sIGlzX2RvbmUoc3Ry
dWN0IHJ4ZV90YXNrICp0YXNrKQogICogc2NoZWR1bGVzIHRoZSB0YXNrLiBUaGV5IG11c3Qg
Y2FsbCBfX3Jlc2VydmVfaWZfaWRsZSB0bwogICogbW92ZSB0aGUgdGFzayB0byBidXN5IGJl
Zm9yZSBjYWxsaW5nIG9yIHNjaGVkdWxpbmcuCiAgKiBUaGUgdGFzayBjYW4gYWxzbyBiZSBt
b3ZlZCB0byBkcmFpbmVkIG9yIGludmFsaWQKLSAqIGJ5IGNhbGxzIHRvIHJ4ZV9jbGVhbnVw
X3Rhc2sgb3IgcnhlX2Rpc2FibGVfdGFzay4KKyAqIGJ5IGNhbGxzIHRvIHJ4ZS1jbGVhbnVw
X3Rhc2sgb3IgcnhlX2Rpc2FibGVfdGFzay4KICAqIEluIHRoYXQgY2FzZSB0YXNrcyB3aGlj
aCBnZXQgaGVyZSBhcmUgbm90IGV4ZWN1dGVkIGJ1dAogICoganVzdCBmbHVzaGVkLiBUaGUg
dGFza3MgYXJlIGRlc2lnbmVkIHRvIGxvb2sgdG8gc2VlIGlmCi0gKiB0aGVyZSBpcyB3b3Jr
IHRvIGRvIGFuZCB0aGVuIGRvIHBhcnQgb2YgaXQgYmVmb3JlIHJldHVybmluZworICogdGhl
cmUgaXMgd29yayB0byBkbyBhbmQgZG8gcGFydCBvZiBpdCBiZWZvcmUgcmV0dXJuaW5nCiAg
KiBoZXJlIHdpdGggYSByZXR1cm4gdmFsdWUgb2YgemVybyB1bnRpbCBhbGwgdGhlIHdvcmsK
LSAqIGhhcyBiZWVuIGNvbnN1bWVkIHRoZW4gaXQgcmV0dXJucyBhIG5vbi16ZXJvIHZhbHVl
LgorICogaGFzIGJlZW4gY29uc3VtZWQgdGhlbiBpdCByZXR1ZW5zIGEgbm9uLXplcm8gdmFs
dWUuCiAgKiBUaGUgbnVtYmVyIG9mIHRpbWVzIHRoZSB0YXNrIGNhbiBiZSBydW4gaXMgbGlt
aXRlZCBieQogICogbWF4IGl0ZXJhdGlvbnMgc28gb25lIHRhc2sgY2Fubm90IGhvbGQgdGhl
IGNwdSBmb3JldmVyLgotICogSWYgdGhlIGxpbWl0IGlzIGhpdCBhbmQgd29yayByZW1haW5z
IHRoZSB0YXNrIGlzIHJlc2NoZWR1bGVkLgogICovCi1zdGF0aWMgdm9pZCBkb190YXNrKHN0
cnVjdCByeGVfdGFzayAqdGFzaykKK3N0YXRpYyB2b2lkIGRvX3Rhc2soc3RydWN0IHRhc2ts
ZXRfc3RydWN0ICp0KQogeworCWludCBjb250OworCWludCByZXQ7CisJc3RydWN0IHJ4ZV90
YXNrICp0YXNrID0gZnJvbV90YXNrbGV0KHRhc2ssIHQsIHRhc2tsZXQpOwogCXVuc2lnbmVk
IGludCBpdGVyYXRpb25zOwogCXVuc2lnbmVkIGxvbmcgZmxhZ3M7CiAJaW50IHJlc2NoZWQg
PSAwOwotCWludCBjb250OwotCWludCByZXQ7CiAKIAlXQVJOX09OKHJ4ZV9yZWFkKHRhc2st
PnFwKSA8PSAwKTsKIApAQCAtMTI4LDIyICsxMTUsMjUgQEAgc3RhdGljIHZvaWQgZG9fdGFz
ayhzdHJ1Y3QgcnhlX3Rhc2sgKnRhc2spCiAJCX0gd2hpbGUgKHJldCA9PSAwICYmIGl0ZXJh
dGlvbnMtLSA+IDApOwogCiAJCXNwaW5fbG9ja19pcnFzYXZlKCZ0YXNrLT5sb2NrLCBmbGFn
cyk7Ci0JCS8qIHdlJ3JlIG5vdCBkb25lIHlldCBidXQgd2UgcmFuIG91dCBvZiBpdGVyYXRp
b25zLgotCQkgKiB5aWVsZCB0aGUgY3B1IGFuZCByZXNjaGVkdWxlIHRoZSB0YXNrCi0JCSAq
LwotCQlpZiAoIXJldCkgewotCQkJdGFzay0+c3RhdGUgPSBUQVNLX1NUQVRFX0lETEU7Ci0J
CQlyZXNjaGVkID0gMTsKLQkJCWdvdG8gZXhpdDsKLQkJfQotCiAJCXN3aXRjaCAodGFzay0+
c3RhdGUpIHsKIAkJY2FzZSBUQVNLX1NUQVRFX0JVU1k6Ci0JCQl0YXNrLT5zdGF0ZSA9IFRB
U0tfU1RBVEVfSURMRTsKKwkJCWlmIChyZXQpIHsKKwkJCQl0YXNrLT5zdGF0ZSA9IFRBU0tf
U1RBVEVfSURMRTsKKwkJCX0gZWxzZSB7CisJCQkJLyogVGhpcyBjYW4gaGFwcGVuIGlmIHRo
ZSBjbGllbnQKKwkJCQkgKiBjYW4gYWRkIHdvcmsgZmFzdGVyIHRoYW4gdGhlCisJCQkJICog
dGFza2xldCBjYW4gZmluaXNoIGl0LgorCQkJCSAqIFJlc2NoZWR1bGUgdGhlIHRhc2tsZXQg
YW5kIGV4aXQKKwkJCQkgKiB0aGUgbG9vcCB0byBnaXZlIHVwIHRoZSBjcHUKKwkJCQkgKi8K
KwkJCQl0YXNrLT5zdGF0ZSA9IFRBU0tfU1RBVEVfSURMRTsKKwkJCQlyZXNjaGVkID0gMTsK
KwkJCX0KIAkJCWJyZWFrOwogCi0JCS8qIHNvbWVvbmUgdHJpZWQgdG8gc2NoZWR1bGUgdGhl
IHRhc2sgd2hpbGUgd2UKLQkJICogd2VyZSBydW5uaW5nLCBrZWVwIGdvaW5nCisJCS8qIHNv
bWVvbmUgdHJpZWQgdG8gcnVuIHRoZSB0YXNrIHNpbmNlIHRoZSBsYXN0IHRpbWUgd2UgY2Fs
bGVkCisJCSAqIGZ1bmMsIHNvIHdlIHdpbGwgY2FsbCBvbmUgbW9yZSB0aW1lIHJlZ2FyZGxl
c3Mgb2YgdGhlCisJCSAqIHJldHVybiB2YWx1ZQogCQkgKi8KIAkJY2FzZSBUQVNLX1NUQVRF
X0FSTUVEOgogCQkJdGFzay0+c3RhdGUgPSBUQVNLX1NUQVRFX0JVU1k7CkBAIC0xNTEsMjQg
KzE0MSwyMiBAQCBzdGF0aWMgdm9pZCBkb190YXNrKHN0cnVjdCByeGVfdGFzayAqdGFzaykK
IAkJCWJyZWFrOwogCiAJCWNhc2UgVEFTS19TVEFURV9EUkFJTklORzoKLQkJCXRhc2stPnN0
YXRlID0gVEFTS19TVEFURV9EUkFJTkVEOworCQkJaWYgKHJldCkKKwkJCQl0YXNrLT5zdGF0
ZSA9IFRBU0tfU1RBVEVfRFJBSU5FRDsKKwkJCWVsc2UKKwkJCQljb250ID0gMTsKIAkJCWJy
ZWFrOwogCiAJCWRlZmF1bHQ6CiAJCQlXQVJOX09OKDEpOwotCQkJcnhlX2RiZ19xcCh0YXNr
LT5xcCwgInVuZXhwZWN0ZWQgdGFzayBzdGF0ZSA9ICVkIiwKLQkJCQkgICB0YXNrLT5zdGF0
ZSk7Ci0JCQl0YXNrLT5zdGF0ZSA9IFRBU0tfU1RBVEVfSURMRTsKKwkJCXJ4ZV9pbmZvX3Fw
KHRhc2stPnFwLCAidW5leHBlY3RlZCB0YXNrIHN0YXRlID0gJWQiLCB0YXNrLT5zdGF0ZSk7
CiAJCX0KIAotZXhpdDoKIAkJaWYgKCFjb250KSB7CiAJCQl0YXNrLT5udW1fZG9uZSsrOwog
CQkJaWYgKFdBUk5fT04odGFzay0+bnVtX2RvbmUgIT0gdGFzay0+bnVtX3NjaGVkKSkKLQkJ
CQlyeGVfZGJnX3FwKAotCQkJCQl0YXNrLT5xcCwKLQkJCQkJIiVsZCB0YXNrcyBzY2hlZHVs
ZWQsICVsZCB0YXNrcyBkb25lIiwKLQkJCQkJdGFzay0+bnVtX3NjaGVkLCB0YXNrLT5udW1f
ZG9uZSk7CisJCQkJcnhlX2Vycl9xcCh0YXNrLT5xcCwgIiVsZCB0YXNrcyBzY2hlZHVsZWQs
ICVsZCB0YXNrcyBkb25lIiwKKwkJCQkJICAgdGFzay0+bnVtX3NjaGVkLCB0YXNrLT5udW1f
ZG9uZSk7CiAJCX0KIAkJc3Bpbl91bmxvY2tfaXJxcmVzdG9yZSgmdGFzay0+bG9jaywgZmxh
Z3MpOwogCX0gd2hpbGUgKGNvbnQpOwpAQCAtMTgxLDEyICsxNjksNiBAQCBzdGF0aWMgdm9p
ZCBkb190YXNrKHN0cnVjdCByeGVfdGFzayAqdGFzaykKIAlyeGVfcHV0KHRhc2stPnFwKTsK
IH0KIAotLyogd3JhcHBlciBhcm91bmQgZG9fdGFzayB0byBmaXggYXJndW1lbnQgZm9yIHdv
cmsgcXVldWUgKi8KLXN0YXRpYyB2b2lkIGRvX3dvcmsoc3RydWN0IHdvcmtfc3RydWN0ICp3
b3JrKQotewotCWRvX3Rhc2soY29udGFpbmVyX29mKHdvcmssIHN0cnVjdCByeGVfdGFzaywg
d29yaykpOwotfQotCiBpbnQgcnhlX2luaXRfdGFzayhzdHJ1Y3QgcnhlX3Rhc2sgKnRhc2ss
IHN0cnVjdCByeGVfcXAgKnFwLAogCQkgIGludCAoKmZ1bmMpKHN0cnVjdCByeGVfcXAgKikp
CiB7CkBAIC0xOTQsOSArMTc2LDExIEBAIGludCByeGVfaW5pdF90YXNrKHN0cnVjdCByeGVf
dGFzayAqdGFzaywgc3RydWN0IHJ4ZV9xcCAqcXAsCiAKIAl0YXNrLT5xcCA9IHFwOwogCXRh
c2stPmZ1bmMgPSBmdW5jOworCisJdGFza2xldF9zZXR1cCgmdGFzay0+dGFza2xldCwgZG9f
dGFzayk7CisKIAl0YXNrLT5zdGF0ZSA9IFRBU0tfU1RBVEVfSURMRTsKIAlzcGluX2xvY2tf
aW5pdCgmdGFzay0+bG9jayk7Ci0JSU5JVF9XT1JLKCZ0YXNrLT53b3JrLCBkb193b3JrKTsK
IAogCXJldHVybiAwOwogfQpAQCAtMjI5LDYgKzIxMyw4IEBAIHZvaWQgcnhlX2NsZWFudXBf
dGFzayhzdHJ1Y3QgcnhlX3Rhc2sgKnRhc2spCiAJd2hpbGUgKCFpc19kb25lKHRhc2spKQog
CQljb25kX3Jlc2NoZWQoKTsKIAorCXRhc2tsZXRfa2lsbCgmdGFzay0+dGFza2xldCk7CisK
IAlzcGluX2xvY2tfaXJxc2F2ZSgmdGFzay0+bG9jaywgZmxhZ3MpOwogCXRhc2stPnN0YXRl
ID0gVEFTS19TVEFURV9JTlZBTElEOwogCXNwaW5fdW5sb2NrX2lycXJlc3RvcmUoJnRhc2st
PmxvY2ssIGZsYWdzKTsKQEAgLTI0MCw3ICsyMjYsNyBAQCB2b2lkIHJ4ZV9jbGVhbnVwX3Rh
c2soc3RydWN0IHJ4ZV90YXNrICp0YXNrKQogdm9pZCByeGVfcnVuX3Rhc2soc3RydWN0IHJ4
ZV90YXNrICp0YXNrKQogewogCXVuc2lnbmVkIGxvbmcgZmxhZ3M7Ci0JYm9vbCBydW47CisJ
aW50IHJ1bjsKIAogCVdBUk5fT04ocnhlX3JlYWQodGFzay0+cXApIDw9IDApOwogCkBAIC0y
NDksMTEgKzIzNSwxMSBAQCB2b2lkIHJ4ZV9ydW5fdGFzayhzdHJ1Y3QgcnhlX3Rhc2sgKnRh
c2spCiAJc3Bpbl91bmxvY2tfaXJxcmVzdG9yZSgmdGFzay0+bG9jaywgZmxhZ3MpOwogCiAJ
aWYgKHJ1bikKLQkJZG9fdGFzayh0YXNrKTsKKwkJZG9fdGFzaygmdGFzay0+dGFza2xldCk7
CiB9CiAKLS8qIHNjaGVkdWxlIHRoZSB0YXNrIHRvIHJ1biBsYXRlciBhcyBhIHdvcmsgcXVl
dWUgZW50cnkuCi0gKiB0aGUgcXVldWVfd29yayBjYWxsIGNhbiBiZSBjYWxsZWQgaG9sZGlu
ZworLyogc2NoZWR1bGUgdGhlIHRhc2sgdG8gcnVuIGxhdGVyIGFzIGEgdGFza2xldC4KKyAq
IHRoZSB0YXNrbGV0KXNjaGVkdWxlIGNhbGwgY2FuIGJlIGNhbGxlZCBob2xkaW5nCiAgKiB0
aGUgbG9jay4KICAqLwogdm9pZCByeGVfc2NoZWRfdGFzayhzdHJ1Y3QgcnhlX3Rhc2sgKnRh
c2spCkBAIC0yNjQsNyArMjUwLDcgQEAgdm9pZCByeGVfc2NoZWRfdGFzayhzdHJ1Y3Qgcnhl
X3Rhc2sgKnRhc2spCiAKIAlzcGluX2xvY2tfaXJxc2F2ZSgmdGFzay0+bG9jaywgZmxhZ3Mp
OwogCWlmIChfX3Jlc2VydmVfaWZfaWRsZSh0YXNrKSkKLQkJcXVldWVfd29yayhyeGVfd3Es
ICZ0YXNrLT53b3JrKTsKKwkJdGFza2xldF9zY2hlZHVsZSgmdGFzay0+dGFza2xldCk7CiAJ
c3Bpbl91bmxvY2tfaXJxcmVzdG9yZSgmdGFzay0+bG9jaywgZmxhZ3MpOwogfQogCkBAIC0y
OTEsOSArMjc3LDcgQEAgdm9pZCByeGVfZGlzYWJsZV90YXNrKHN0cnVjdCByeGVfdGFzayAq
dGFzaykKIAl3aGlsZSAoIWlzX2RvbmUodGFzaykpCiAJCWNvbmRfcmVzY2hlZCgpOwogCi0J
c3Bpbl9sb2NrX2lycXNhdmUoJnRhc2stPmxvY2ssIGZsYWdzKTsKLQl0YXNrLT5zdGF0ZSA9
IFRBU0tfU1RBVEVfRFJBSU5FRDsKLQlzcGluX3VubG9ja19pcnFyZXN0b3JlKCZ0YXNrLT5s
b2NrLCBmbGFncyk7CisJdGFza2xldF9kaXNhYmxlKCZ0YXNrLT50YXNrbGV0KTsKIH0KIAog
dm9pZCByeGVfZW5hYmxlX3Rhc2soc3RydWN0IHJ4ZV90YXNrICp0YXNrKQpAQCAtMzA3LDcg
KzI5MSw3IEBAIHZvaWQgcnhlX2VuYWJsZV90YXNrKHN0cnVjdCByeGVfdGFzayAqdGFzaykK
IAkJc3Bpbl91bmxvY2tfaXJxcmVzdG9yZSgmdGFzay0+bG9jaywgZmxhZ3MpOwogCQlyZXR1
cm47CiAJfQotCiAJdGFzay0+c3RhdGUgPSBUQVNLX1NUQVRFX0lETEU7CisJdGFza2xldF9l
bmFibGUoJnRhc2stPnRhc2tsZXQpOwogCXNwaW5fdW5sb2NrX2lycXJlc3RvcmUoJnRhc2st
PmxvY2ssIGZsYWdzKTsKIH0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvaW5maW5pYmFuZC9zdy9y
eGUvcnhlX3Rhc2suaCBiL2RyaXZlcnMvaW5maW5pYmFuZC9zdy9yeGUvcnhlX3Rhc2suaApp
bmRleCBhNjNlMjU4YjNkNjYuLmZhY2I3YzhlMzcyOSAxMDA2NDQKLS0tIGEvZHJpdmVycy9p
bmZpbmliYW5kL3N3L3J4ZS9yeGVfdGFzay5oCisrKyBiL2RyaXZlcnMvaW5maW5pYmFuZC9z
dy9yeGUvcnhlX3Rhc2suaApAQCAtMjIsNyArMjIsNyBAQCBlbnVtIHsKICAqIGNhbGxlZCBh
Z2Fpbi4KICAqLwogc3RydWN0IHJ4ZV90YXNrIHsKLQlzdHJ1Y3Qgd29ya19zdHJ1Y3QJd29y
azsKKwlzdHJ1Y3QgdGFza2xldF9zdHJ1Y3QJdGFza2xldDsKIAlpbnQJCQlzdGF0ZTsKIAlz
cGlubG9ja190CQlsb2NrOwogCXN0cnVjdCByeGVfcXAJCSpxcDsKQEAgLTMyLDEwICszMiw2
IEBAIHN0cnVjdCByeGVfdGFzayB7CiAJbG9uZwkJCW51bV9kb25lOwogfTsKIAotaW50IHJ4
ZV9hbGxvY193cSh2b2lkKTsKLQotdm9pZCByeGVfZGVzdHJveV93cSh2b2lkKTsKLQogLyoK
ICAqIGluaXQgcnhlX3Rhc2sgc3RydWN0dXJlCiAgKglxcCAgPT4gcGFyYW1ldGVyIHRvIHBh
c3MgdG8gZnVuYwotLSAKMi40MC4xCgo=

--------------yguV76tzBcgNpfcjOH0jDuNz--
