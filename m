Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 619E9286695
	for <lists+linux-rdma@lfdr.de>; Wed,  7 Oct 2020 20:11:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728656AbgJGSKw (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 7 Oct 2020 14:10:52 -0400
Received: from smtprelay0185.hostedemail.com ([216.40.44.185]:44102 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728788AbgJGSKw (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 7 Oct 2020 14:10:52 -0400
X-Greylist: delayed 365 seconds by postgrey-1.27 at vger.kernel.org; Wed, 07 Oct 2020 14:10:50 EDT
Received: from smtprelay.hostedemail.com (10.5.19.251.rfc1918.com [10.5.19.251])
        by smtpgrave02.hostedemail.com (Postfix) with ESMTP id 7DAE9180054C1
        for <linux-rdma@vger.kernel.org>; Wed,  7 Oct 2020 18:04:47 +0000 (UTC)
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id 9CEBD837F24A;
        Wed,  7 Oct 2020 18:04:44 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:1:41:355:379:599:800:871:960:973:982:988:989:1000:1260:1313:1314:1345:1359:1431:1437:1516:1518:1543:1575:1594:1711:1730:1747:1764:1777:1792:2194:2199:2376:2393:2553:2559:2562:2693:2911:3138:3139:3140:3141:3142:3355:3622:3865:3866:3867:3868:3870:3871:3872:3873:3874:4321:4425:5007:6117:6119:6506:6747:6748:7281:7809:7903:8531:8603:9010:10004:10394:10400:10848:11026:11232:11604:11658:11914:12043:12296:12297:12555:12663:12740:12895:12986:13161:13229:13439:13891:14096:14181:14659:14721:21060:21080:21324:21433:21451:21627:21789:30029:30054:30055:30064:30070:30090:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:3,LUA_SUMMARY:none
X-HE-Tag: bread98_2507b7a271d1
X-Filterd-Recvd-Size: 13413
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf05.hostedemail.com (Postfix) with ESMTPA;
        Wed,  7 Oct 2020 18:04:43 +0000 (UTC)
Message-ID: <a334b30e7b617eb6b0ea22f2bf00e0f188c4ae42.camel@perches.com>
Subject: Re: [PATCH -next] mm: Use sysfs_emit functions not sprintf
From:   Joe Perches <joe@perches.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     linux-rdma <linux-rdma@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Date:   Wed, 07 Oct 2020 11:04:42 -0700
In-Reply-To: <20201007125330.GO5177@ziepe.ca>
References: <8a0d4fc9a4e372b125249b186689f247312d4387.camel@perches.com>
         <202010070014.76AA763CE@keescook> <20201007125330.GO5177@ziepe.ca>
Content-Type: multipart/mixed; boundary="=-mi8zbEP98B9wkzS2GwtS"
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


--=-mi8zbEP98B9wkzS2GwtS
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit

On Wed, 2020-10-07 at 09:53 -0300, Jason Gunthorpe wrote:
> On Wed, Oct 07, 2020 at 12:16:01AM -0700, Kees Cook wrote:
> > On Tue, Oct 06, 2020 at 09:28:17AM -0700, Joe Perches wrote:
> > > Convert the various uses of sprintf/snprintf/scnprintf to
> > > format sysfs output to sysfs_emit and sysfs_emit_at to make
> > > clear the output is sysfs related and to avoid any possible
> > > buffer overrun of the PAGE_SIZE buffer.
> > > 
> > > Done with cocci scripts and some typing.
> > 
> > Can you include the cocci script in the commit log? It might be nicer to
> > split the "manual" changes from the cocci changes, as that makes review
> > much easier too.
> > 
> > Regardless, yes, I'm a fan of switching these all around to
> > sysfs_emit*(). :)
> 
> Yah, +1, I'd welcome patches for drivers/infiniband as well next cycle

The script to change <foo>_show(struct device *, ...)
function uses of
sprintf to sysfs_emit is attached.

The cocci script is coarse and doesn't find nor change all
the possible variants of the sprintf uses in these functions.

It could be run using:

$ spatch --in-place -sp-file sysfs_emit.cocci drivers/infiniband/

Against next-20201007 it produces:

$ git diff --shortstat drivers/infiniband
 25 files changed, 322 insertions(+), 303 deletions(-)

Because it touches a lot of drivers, the 'cc' list is
pretty large for the diff.

Given the size of the cc list, unless there's a single
acceptable patch, I will not submit individual patches as
I really dislike the back and forth of this sub-maintainer
will but this sub-maintainer will not apply a patch.

Doug Ledford <dledford@redhat.com> (supporter:INFINIBAND SUBSYSTEM)
Jason Gunthorpe <jgg@ziepe.ca> (supporter:INFINIBAND SUBSYSTEM)
Selvin Xavier <selvin.xavier@broadcom.com> (supporter:BROADCOM NETXTREME-E ROCE DRIVER)
Devesh Sharma <devesh.sharma@broadcom.com> (supporter:BROADCOM NETXTREME-E ROCE DRIVER)
Somnath Kotur <somnath.kotur@broadcom.com> (supporter:BROADCOM NETXTREME-E ROCE DRIVER)
Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com> (supporter:BROADCOM NETXTREME-E ROCE DRIVER)
Naresh Kumar PBS <nareshkumar.pbs@broadcom.com> (supporter:BROADCOM NETXTREME-E ROCE DRIVER)
Potnuri Bharat Teja <bharat@chelsio.com> (supporter:CXGB4 IWARP RNIC DRIVER (IW_CXGB4))
Mike Marciniszyn <mike.marciniszyn@intel.com> (supporter:HFI1 DRIVER)
Dennis Dalessandro <dennis.dalessandro@intel.com> (supporter:HFI1 DRIVER)
Faisal Latif <faisal.latif@intel.com> (supporter:INTEL RDMA RNIC DRIVER)
Shiraz Saleem <shiraz.saleem@intel.com> (supporter:INTEL RDMA RNIC DRIVER)
Yishai Hadas <yishaih@nvidia.com> (supporter:MELLANOX MLX4 IB driver)
Leon Romanovsky <leon@kernel.org> (supporter:MELLANOX MLX5 IB driver)
Michal Kalderon <mkalderon@marvell.com> (supporter:QLOGIC QL4xxx RDMA DRIVER)
Ariel Elior <aelior@marvell.com> (supporter:QLOGIC QL4xxx RDMA DRIVER)
Christian Benvenuti <benve@cisco.com> (supporter:CISCO VIC LOW LATENCY NIC DRIVER)
Nelson Escobar <neescoba@cisco.com> (supporter:CISCO VIC LOW LATENCY NIC DRIVER)
Parvi Kaustubhi <pkaustub@cisco.com> (supporter:CISCO VIC LOW LATENCY NIC DRIVER)
Adit Ranadive <aditr@vmware.com> (maintainer:VMWARE PVRDMA DRIVER)
VMware PV-Drivers <pv-drivers@vmware.com> (maintainer:VMWARE PVRDMA DRIVER)
Zhu Yanjun <yanjunz@nvidia.com> (supporter:SOFT-ROCE DRIVER (rxe))
Danil Kipnis <danil.kipnis@cloud.ionos.com> (maintainer:RTRS TRANSPORT DRIVERS)
Jack Wang <jinpu.wang@cloud.ionos.com> (maintainer:RTRS TRANSPORT DRIVERS)
Bart Van Assche <bvanassche@acm.org> (supporter:SCSI RDMA PROTOCOL (SRP) INITIATOR)
linux-rdma@vger.kernel.org (open list:INFINIBAND SUBSYSTEM)
linux-kernel@vger.kernel.org (open list)


--=-mi8zbEP98B9wkzS2GwtS
Content-Disposition: attachment; filename="sysfs_emit.cocci"
Content-Type: text/plain; name="sysfs_emit.cocci"; charset="ISO-8859-1"
Content-Transfer-Encoding: base64

QEAKLy9pZGVudGlmaWVyIGRfc2hvdyA9fiAiXi4qc2hvdy4qJCI7CmlkZW50aWZpZXIgZF9zaG93
OwppZGVudGlmaWVyIGFyZzEsIGFyZzIsIGFyZzM7CkBACnNzaXplX3QgZF9zaG93KHN0cnVjdCBk
ZXZpY2UgKgotCWFyZzEKKwlkZXYKCSwgc3RydWN0IGRldmljZV9hdHRyaWJ1dGUgKgotCWFyZzIK
KwlhdHRyCgksIGNoYXIgKgotCWFyZzMKKwlidWYKCSkKewoJPC4uLgooCi0JYXJnMQorCWRldgp8
Ci0JYXJnMgorCWF0dHIKfAotCWFyZzMKKwlidWYKKQoJLi4uPgp9CgpAQAovL2lkZW50aWZpZXIg
ZF9zaG93ID1+ICJeLipzaG93LiokIjsKaWRlbnRpZmllciBkX3Nob3c7CmlkZW50aWZpZXIgZGV2
LCBhdHRyLCBidWY7CkBACgpzc2l6ZV90IGRfc2hvdyhzdHJ1Y3QgZGV2aWNlICpkZXYsIHN0cnVj
dCBkZXZpY2VfYXR0cmlidXRlICphdHRyLCBjaGFyICpidWYpCnsKCTwuLi4KCXJldHVybgotCXNw
cmludGYoYnVmLAorCXN5c2ZzX2VtaXQoYnVmLAoJLi4uKTsKCS4uLj4KfQoKQEAKLy9pZGVudGlm
aWVyIGRfc2hvdyA9fiAiXi4qc2hvdy4qJCI7CmlkZW50aWZpZXIgZF9zaG93OwppZGVudGlmaWVy
IGRldiwgYXR0ciwgYnVmOwpAQAoKc3NpemVfdCBkX3Nob3coc3RydWN0IGRldmljZSAqZGV2LCBz
dHJ1Y3QgZGV2aWNlX2F0dHJpYnV0ZSAqYXR0ciwgY2hhciAqYnVmKQp7Cgk8Li4uCglyZXR1cm4K
LQlzbnByaW50ZihidWYsIFBBR0VfU0laRSwKKwlzeXNmc19lbWl0KGJ1ZiwKCS4uLik7CgkuLi4+
Cn0KCkBACi8vaWRlbnRpZmllciBkX3Nob3cgPX4gIl4uKnNob3cuKiQiOwppZGVudGlmaWVyIGRf
c2hvdzsKaWRlbnRpZmllciBkZXYsIGF0dHIsIGJ1ZjsKQEAKCnNzaXplX3QgZF9zaG93KHN0cnVj
dCBkZXZpY2UgKmRldiwgc3RydWN0IGRldmljZV9hdHRyaWJ1dGUgKmF0dHIsIGNoYXIgKmJ1ZikK
ewoJPC4uLgoJcmV0dXJuCi0Jc2NucHJpbnRmKGJ1ZiwgUEFHRV9TSVpFLAorCXN5c2ZzX2VtaXQo
YnVmLAoJLi4uKTsKCS4uLj4KfQoKQEAKLy9pZGVudGlmaWVyIGRfc2hvdyA9fiAiXi4qc2hvdy4q
JCI7CmlkZW50aWZpZXIgZF9zaG93OwppZGVudGlmaWVyIGRldiwgYXR0ciwgYnVmOwpleHByZXNz
aW9uIGNocjsKQEAKCnNzaXplX3QgZF9zaG93KHN0cnVjdCBkZXZpY2UgKmRldiwgc3RydWN0IGRl
dmljZV9hdHRyaWJ1dGUgKmF0dHIsIGNoYXIgKmJ1ZikKewoJPC4uLgoJcmV0dXJuCi0Jc3RyY3B5
KGJ1ZiwgY2hyKTsKKwlzeXNmc19lbWl0KGJ1ZiwgY2hyKTsKCS4uLj4KfQoKQEAKLy9pZGVudGlm
aWVyIGRfc2hvdyA9fiAiXi4qc2hvdy4qJCI7CmlkZW50aWZpZXIgZF9zaG93OwppZGVudGlmaWVy
IGRldiwgYXR0ciwgYnVmOwppZGVudGlmaWVyIGxlbjsKQEAKCnNzaXplX3QgZF9zaG93KHN0cnVj
dCBkZXZpY2UgKmRldiwgc3RydWN0IGRldmljZV9hdHRyaWJ1dGUgKmF0dHIsIGNoYXIgKmJ1ZikK
ewoJPC4uLgoJbGVuID0KLQlzcHJpbnRmKGJ1ZiwKKwlzeXNmc19lbWl0KGJ1ZiwKCS4uLik7Cgku
Li4+CglyZXR1cm4gbGVuOwp9CgpAQAovL2lkZW50aWZpZXIgZF9zaG93ID1+ICJeLipzaG93Liok
IjsKaWRlbnRpZmllciBkX3Nob3c7CmlkZW50aWZpZXIgZGV2LCBhdHRyLCBidWY7CmlkZW50aWZp
ZXIgbGVuOwpAQAoKc3NpemVfdCBkX3Nob3coc3RydWN0IGRldmljZSAqZGV2LCBzdHJ1Y3QgZGV2
aWNlX2F0dHJpYnV0ZSAqYXR0ciwgY2hhciAqYnVmKQp7Cgk8Li4uCglsZW4gPQotCXNucHJpbnRm
KGJ1ZiwgUEFHRV9TSVpFLAorCXN5c2ZzX2VtaXQoYnVmLAoJLi4uKTsKCS4uLj4KCXJldHVybiBs
ZW47Cn0KCkBACi8vaWRlbnRpZmllciBkX3Nob3cgPX4gIl4uKnNob3cuKiQiOwppZGVudGlmaWVy
IGRfc2hvdzsKaWRlbnRpZmllciBkZXYsIGF0dHIsIGJ1ZjsKaWRlbnRpZmllciBsZW47CkBACgpz
c2l6ZV90IGRfc2hvdyhzdHJ1Y3QgZGV2aWNlICpkZXYsIHN0cnVjdCBkZXZpY2VfYXR0cmlidXRl
ICphdHRyLCBjaGFyICpidWYpCnsKCTwuLi4KCWxlbiA9Ci0Jc2NucHJpbnRmKGJ1ZiwgUEFHRV9T
SVpFLAorCXN5c2ZzX2VtaXQoYnVmLAoJLi4uKTsKCS4uLj4KCXJldHVybiBsZW47Cn0KCkBACi8v
aWRlbnRpZmllciBkX3Nob3cgPX4gIl4uKnNob3cuKiQiOwppZGVudGlmaWVyIGRfc2hvdzsKaWRl
bnRpZmllciBkZXYsIGF0dHIsIGJ1ZjsKaWRlbnRpZmllciBsZW47CkBACgpzc2l6ZV90IGRfc2hv
dyhzdHJ1Y3QgZGV2aWNlICpkZXYsIHN0cnVjdCBkZXZpY2VfYXR0cmlidXRlICphdHRyLCBjaGFy
ICpidWYpCnsKCTwuLi4KLQlsZW4gKz0gc2NucHJpbnRmKGJ1ZiArIGxlbiwgUEFHRV9TSVpFIC0g
bGVuLAorCWxlbiArPSBzeXNmc19lbWl0X2F0KGJ1ZiwgbGVuLAoJLi4uKTsKCS4uLj4KCXJldHVy
biBsZW47Cn0KCkBACi8vaWRlbnRpZmllciBkX3Nob3cgPX4gIl4uKnNob3cuKiQiOwppZGVudGlm
aWVyIGRfc2hvdzsKaWRlbnRpZmllciBkZXYsIGF0dHIsIGJ1ZjsKZXhwcmVzc2lvbiBjaHI7CkBA
Cgpzc2l6ZV90IGRfc2hvdyhzdHJ1Y3QgZGV2aWNlICpkZXYsIHN0cnVjdCBkZXZpY2VfYXR0cmli
dXRlICphdHRyLCBjaGFyICpidWYpCnsKLQlzdHJjcHkoYnVmLCBjaHIpOwotCXJldHVybiBzdHJs
ZW4oYnVmKTsKKwlyZXR1cm4gc3lzZnNfZW1pdChidWYsIGNocik7Cn0KCkBACmlkZW50aWZpZXIg
a19zaG93ID1+ICJeLipzaG93LiokIjsKaWRlbnRpZmllciBhcmcxLCBhcmcyLCBhcmczOwpAQApz
c2l6ZV90IGtfc2hvdyhzdHJ1Y3Qga29iamVjdCAqCi0JYXJnMQorCWtvYmoKCSwgc3RydWN0IGtv
YmpfYXR0cmlidXRlICoKLQlhcmcyCisJYXR0cgoJLCBjaGFyICoKLQlhcmczCisJYnVmCgkpCnsK
CS4uLgooCi0JYXJnMQorCWtvYmoKfAotCWFyZzIKKwlhdHRyCnwKLQlhcmczCisJYnVmCikKCS4u
Lgp9CgpAQAppZGVudGlmaWVyIGtfc2hvdyA9fiAiXi4qc2hvdy4qJCI7CmlkZW50aWZpZXIga29i
aiwgYXR0ciwgYnVmOwpAQAoKc3NpemVfdCBrX3Nob3coc3RydWN0IGtvYmplY3QgKmtvYmosIHN0
cnVjdCBrb2JqX2F0dHJpYnV0ZSAqYXR0ciwgY2hhciAqYnVmKQp7Cgk8Li4uCglyZXR1cm4KLQlz
cHJpbnRmKGJ1ZiwKKwlzeXNmc19lbWl0KGJ1ZiwKCS4uLik7CgkuLi4+Cn0KCkBACmlkZW50aWZp
ZXIga19zaG93ID1+ICJeLipzaG93LiokIjsKaWRlbnRpZmllciBrb2JqLCBhdHRyLCBidWY7CkBA
Cgpzc2l6ZV90IGtfc2hvdyhzdHJ1Y3Qga29iamVjdCAqa29iaiwgc3RydWN0IGtvYmpfYXR0cmli
dXRlICphdHRyLCBjaGFyICpidWYpCnsKCTwuLi4KCXJldHVybgotCXNucHJpbnRmKGJ1ZiwgUEFH
RV9TSVpFLAorCXN5c2ZzX2VtaXQoYnVmLAoJLi4uKTsKCS4uLj4KfQoKQEAKaWRlbnRpZmllciBr
X3Nob3cgPX4gIl4uKnNob3cuKiQiOwppZGVudGlmaWVyIGtvYmosIGF0dHIsIGJ1ZjsKQEAKCnNz
aXplX3Qga19zaG93KHN0cnVjdCBrb2JqZWN0ICprb2JqLCBzdHJ1Y3Qga29ial9hdHRyaWJ1dGUg
KmF0dHIsIGNoYXIgKmJ1ZikKewoJPC4uLgoJcmV0dXJuCi0Jc2NucHJpbnRmKGJ1ZiwgUEFHRV9T
SVpFLAorCXN5c2ZzX2VtaXQoYnVmLAoJLi4uKTsKCS4uLj4KfQoKQEAKaWRlbnRpZmllciBrX3No
b3cgPX4gIl4uKnNob3cuKiQiOwppZGVudGlmaWVyIGtvYmosIGF0dHIsIGJ1ZjsKZXhwcmVzc2lv
biBjaHI7CkBACgpzc2l6ZV90IGtfc2hvdyhzdHJ1Y3Qga29iamVjdCAqa29iaiwgc3RydWN0IGtv
YmpfYXR0cmlidXRlICphdHRyLCBjaGFyICpidWYpCnsKCTwuLi4KCXJldHVybgotCXN0cmNweShi
dWYsIGNocik7CisJc3lzZnNfZW1pdChidWYsIGNocik7CgkuLi4+Cn0KCkBACmlkZW50aWZpZXIg
a19zaG93ID1+ICJeLipzaG93LiokIjsKaWRlbnRpZmllciBrb2JqLCBhdHRyLCBidWY7CmlkZW50
aWZpZXIgbGVuOwpAQAoKc3NpemVfdCBrX3Nob3coc3RydWN0IGtvYmplY3QgKmtvYmosIHN0cnVj
dCBrb2JqX2F0dHJpYnV0ZSAqYXR0ciwgY2hhciAqYnVmKQp7Cgk8Li4uCglsZW4gPQotCXNwcmlu
dGYoYnVmLAorCXN5c2ZzX2VtaXQoYnVmLAoJLi4uKTsKCS4uLj4KCXJldHVybiBsZW47Cn0KCkBA
CmlkZW50aWZpZXIga19zaG93ID1+ICJeLipzaG93LiokIjsKaWRlbnRpZmllciBrb2JqLCBhdHRy
LCBidWY7CmlkZW50aWZpZXIgbGVuOwpAQAoKc3NpemVfdCBrX3Nob3coc3RydWN0IGtvYmplY3Qg
KmtvYmosIHN0cnVjdCBrb2JqX2F0dHJpYnV0ZSAqYXR0ciwgY2hhciAqYnVmKQp7Cgk8Li4uCgls
ZW4gPQotCXNucHJpbnRmKGJ1ZiwgUEFHRV9TSVpFLAorCXN5c2ZzX2VtaXQoYnVmLAoJLi4uKTsK
CS4uLj4KCXJldHVybiBsZW47Cn0KCkBACmlkZW50aWZpZXIga19zaG93ID1+ICJeLipzaG93Liok
IjsKaWRlbnRpZmllciBrb2JqLCBhdHRyLCBidWY7CmlkZW50aWZpZXIgbGVuOwpAQAoKc3NpemVf
dCBrX3Nob3coc3RydWN0IGtvYmplY3QgKmtvYmosIHN0cnVjdCBrb2JqX2F0dHJpYnV0ZSAqYXR0
ciwgY2hhciAqYnVmKQp7Cgk8Li4uCglsZW4gPQotCXNjbnByaW50ZihidWYsIFBBR0VfU0laRSwK
KwlzeXNmc19lbWl0KGJ1ZiwKCS4uLik7CgkuLi4+CglyZXR1cm4gbGVuOwp9CgpAQAppZGVudGlm
aWVyIGtfc2hvdyA9fiAiXi4qc2hvdy4qJCI7CmlkZW50aWZpZXIga29iaiwgYXR0ciwgYnVmOwpp
ZGVudGlmaWVyIGxlbjsKQEAKCnNzaXplX3Qga19zaG93KHN0cnVjdCBrb2JqZWN0ICprb2JqLCBz
dHJ1Y3Qga29ial9hdHRyaWJ1dGUgKmF0dHIsIGNoYXIgKmJ1ZikKewoJPC4uLgotCWxlbiArPSBz
Y25wcmludGYoYnVmICsgbGVuLCBQQUdFX1NJWkUgLSBsZW4sCisJbGVuICs9IHN5c2ZzX2VtaXRf
YXQoYnVmLCBsZW4sCgkuLi4pOwoJLi4uPgoJcmV0dXJuIGxlbjsKfQoKQEAKaWRlbnRpZmllciBr
X3Nob3cgPX4gIl4uKnNob3cuKiQiOwppZGVudGlmaWVyIGtvYmosIGF0dHIsIGJ1ZjsKZXhwcmVz
c2lvbiBjaHI7CkBACgpzc2l6ZV90IGtfc2hvdyhzdHJ1Y3Qga29iamVjdCAqa29iaiwgc3RydWN0
IGtvYmpfYXR0cmlidXRlICphdHRyLCBjaGFyICpidWYpCnsKLQlzdHJjcHkoYnVmLCBjaHIpOwot
CXJldHVybiBzdHJsZW4oYnVmKTsKKwlyZXR1cm4gc3lzZnNfZW1pdChidWYsIGNocik7Cn0KCi8v
IFJlbmFtZSB0aGUgc3lzZnNfZW1pdCBhc3NpZ25lZCB2YXJpYWJsZXMgbm90IG5hbWVkIGxlbiBh
bmQgbm90IGFscmVhZHkgaW50Ci8vIGFuZCBzZXQgdGhlIG5hbWUgdG8gbGVuIGFuZCB0eXBlIHRv
IGludAoKQG5vdF9pbnRfbm90X2xlbiBleGlzdHNACnR5cGUgVCAhPSBpbnQ7CmlkZW50aWZpZXIg
eCAhPSBsZW47CnBvc2l0aW9uIHA7CmlkZW50aWZpZXIgc3lzZnMgPX4gIl5zeXNmc19lbWl0Liok
IjsKYXNzaWdubWVudCBvcGVyYXRvciBhb3A7CkBACgpUIHhAcDsKLi4uCnggYW9wIHN5c2ZzKC4u
LikKLi4uCgpAQAp0eXBlIG5vdF9pbnRfbm90X2xlbi5UOwppZGVudGlmaWVyIG5vdF9pbnRfbm90
X2xlbi54Owpwb3NpdGlvbiBub3RfaW50X25vdF9sZW4ucDsKQEAKCi0gVCB4QHA7CisgaW50IGxl
bjsKICA8Li4uCi0geAorIGxlbgogIC4uLj4KCi8vIFJlbmFtZSB0aGUgYWxyZWFkeSBpbnQgc3lz
ZnNfZW1pdCBhc3NpZ25lZCB2YXJpYWJsZXMgbm90IG5hbWVkIGxlbgovLyBhbmQgc2V0IHRoZSBu
YW1lIHRvIGxlbgoKQGludF9ub3RfbGVuIGV4aXN0c0AKdHlwZSBUID0gaW50OwppZGVudGlmaWVy
IHggIT0gbGVuOwpwb3NpdGlvbiBwOwppZGVudGlmaWVyIHN5c2ZzID1+ICJec3lzZnNfZW1pdC4q
JCI7CmFzc2lnbm1lbnQgb3BlcmF0b3IgYW9wOwpAQAoKVCB4QHA7Ci4uLgp4IGFvcCBzeXNmcygu
Li4pCi4uLgoKQEAKdHlwZSBpbnRfbm90X2xlbi5UOwppZGVudGlmaWVyIGludF9ub3RfbGVuLng7
CnBvc2l0aW9uIGludF9ub3RfbGVuLnA7CkBACgotIFQgeEBwOworIGludCBsZW47CiAgPC4uLgot
IHgKKyBsZW4KICAuLi4+CgovLyBSZW5hbWUgdGhlIG5vbi1pbnQgaW50IHN5c2ZzX2VtaXQgYXNz
aWduZWQgdmFyaWFibGVzIG5hbWVkIGxlbgovLyBhbmQgc2V0IHRoZSB0eXBlIHRvIGludAoKQG5v
dF9pbnRfaGFzX2xlbiBleGlzdHNACnR5cGUgVCAhPSBpbnQ7CmlkZW50aWZpZXIgeCA9IGxlbjsK
cG9zaXRpb24gcDsKaWRlbnRpZmllciBzeXNmcyA9fiAiXnN5c2ZzX2VtaXQuKiQiOwphc3NpZ25t
ZW50IG9wZXJhdG9yIGFvcDsKQEAKClQgeEBwOwouLi4KeCBhb3Agc3lzZnMoLi4uKQouLi4KCkBA
CnR5cGUgbm90X2ludF9oYXNfbGVuLlQ7CmlkZW50aWZpZXIgbm90X2ludF9oYXNfbGVuLng7CnBv
c2l0aW9uIG5vdF9pbnRfaGFzX2xlbi5wOwpAQAoKLSBUIHhAcDsKKyBpbnQgbGVuOwo=


--=-mi8zbEP98B9wkzS2GwtS--

