Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C4E123A37E
	for <lists+linux-rdma@lfdr.de>; Mon,  3 Aug 2020 13:47:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726606AbgHCLqn (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 3 Aug 2020 07:46:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726752AbgHCLqf (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 3 Aug 2020 07:46:35 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4E66C06174A;
        Mon,  3 Aug 2020 04:46:33 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id d27so27904225qtg.4;
        Mon, 03 Aug 2020 04:46:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=v9w9fbn7yNkef9TLs+zTkzQZ7s1zWhU0/ovW77dwUdg=;
        b=azYzpy5gBWy177C2zEz3nN8T4CAY59qloyuh1SPx61pASUlcEu3g4Ah2btjKaENBAO
         ktyNtc2EgorVTn3Ys2vzLcrbORPK6HckUVmWfSL7D6YlKA5WFkWGM1Kysmn51x7RrJsB
         mRNbCggdhgHJAuzvNXtXb3jv3wsqq/Lh/Fc3Ai4hbv8v+NZ/RhWUV1BYaCKO+RCD0TsU
         7oaGZmCN4ph2etPxyWqaFPGXsEL8f2wsXAxWCGEfSRvdc1jiisy4yeWbu4G9lN9RuZqd
         0rEmHyQ9kVPuY9O5zToguFyU01CNyB7e8R8lq4iL95BMHkVn5j3MtxnaEFRXiIuKZ/24
         0Deg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=v9w9fbn7yNkef9TLs+zTkzQZ7s1zWhU0/ovW77dwUdg=;
        b=BhdvfWo0jLecLuaHWp0I7rIWtBqGxUCdFJcN1YzpYDLyWQNAd7eQ/kkhoMT0n73Bzf
         Uvg5HcJt5Ubnk20nRsggPhO/i2qy+vdLon6TkdOYV/KMFes4GKLoPYwmluvkvHc00SbS
         J4UQ/XDhr7JGEZ9BEJUNciVRN7dYVI2P9Md+IX4Y4N9Fx2Hw5E+egOQ6zhlev+rcAFyt
         ikWE73ijr6kda/z4QpRoS+R/OwTOpZtiZg4/SQfqpqxENtEdBN/go+wvlVYks/NU7+bP
         T8g4pGzy6Q5pxV04zrtfa4SGz+58Q07694wCkrUjYKPylNRB060mDdRmI8T7Y9HsAqu+
         afkA==
X-Gm-Message-State: AOAM533WQQKaPGEOBFT/o57dHbGiUdih5YtpUCe5WQMN884W20pVGKm9
        seKSbfy0E52oiKOzd9psON/h/po5mu8fUbIgg4M=
X-Google-Smtp-Source: ABdhPJy6gn2ytTr6DFZ70N7zNh22A3+ulj9QDSMWwwPeofE/1A22C8/kgSZ6X3X+Ddv4X0eRYpIXJKAkFUV3CAgvKlk=
X-Received: by 2002:aed:33a5:: with SMTP id v34mr16035859qtd.262.1596455192588;
 Mon, 03 Aug 2020 04:46:32 -0700 (PDT)
MIME-Version: 1.0
References: <20200731110240.98326-2-refactormyself@gmail.com> <20200731135523.GA3717@bjorn-Precision-5520>
In-Reply-To: <20200731135523.GA3717@bjorn-Precision-5520>
From:   Ian Kumlien <ian.kumlien@gmail.com>
Date:   Mon, 3 Aug 2020 13:46:21 +0200
Message-ID: <CAA85sZt1_dwpxXMrjHc+5wEH-1w9X4km95UvCzEXqJ_o-OS6Hw@mail.gmail.com>
Subject: Re: [PATCH v4 01/12] IB/hfi1: Check if pcie_capability_read_*() reads ~0
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     "Saheed O. Bolarinwa" <refactormyself@gmail.com>,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, bjorn@helgaas.com,
        skhan@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-pci@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-rdma@vger.kernel.org,
        "Michael J. Ruhl" <michael.j.ruhl@intel.com>,
        Ashutosh Dixit <ashutosh.dixit@intel.com>,
        Puranjay Mohan <puranjay12@gmail.com>
Content-Type: multipart/mixed; boundary="000000000000a7ee6b05abf7b098"
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

--000000000000a7ee6b05abf7b098
Content-Type: text/plain; charset="UTF-8"

On Fri, Jul 31, 2020 at 3:55 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> [+cc Michael, Ashutosh, Ian, Puranjay]
>
> On Fri, Jul 31, 2020 at 01:02:29PM +0200, Saheed O. Bolarinwa wrote:
> > On failure pcie_capability_read_dword() sets it's last parameter,
> > val to 0. In this case dn and up will be 0, so aspm_hw_l1_supported()
> > will return false.
> > However, with Patch 12/12, it is possible that val is set to ~0 on
> > failure. This would introduce a bug because (x & x) == (~0 & x). So
> > with dn and up being 0x02, a true value is return when the read has
> > actually failed.
> >
> > Since, the value ~0 is invalid here,
> >
> > Reset dn and up to 0 when a value of ~0 is read into them, this
> > ensures false is returned on failure in this case.
> >
> > Suggested-by: Bjorn Helgaas <bjorn@helgaas.com>
> > Signed-off-by: Saheed O. Bolarinwa <refactormyself@gmail.com>
> > ---
> >
> >  drivers/infiniband/hw/hfi1/aspm.c | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/infiniband/hw/hfi1/aspm.c b/drivers/infiniband/hw/hfi1/aspm.c
> > index a3c53be4072c..9605b2145d19 100644
> > --- a/drivers/infiniband/hw/hfi1/aspm.c
> > +++ b/drivers/infiniband/hw/hfi1/aspm.c
> > @@ -33,13 +33,13 @@ static bool aspm_hw_l1_supported(struct hfi1_devdata *dd)
> >               return false;
> >
> >       pcie_capability_read_dword(dd->pcidev, PCI_EXP_LNKCAP, &dn);
> > -     dn = ASPM_L1_SUPPORTED(dn);
> > +     dn = (dn == (u32)~0) ? 0 : ASPM_L1_SUPPORTED(dn);
> >
> >       pcie_capability_read_dword(parent, PCI_EXP_LNKCAP, &up);
> > -     up = ASPM_L1_SUPPORTED(up);
> > +     up = (up == (u32)~0) ? 0 : ASPM_L1_SUPPORTED(up);
>
> I don't want to change this.  The driver shouldn't be mucking with
> ASPM at all.  The PCI core should take care of this automatically.  If
> it doesn't, we need to fix the core.
>
> If the driver needs to disable ASPM to work around device errata or
> something, the core has an interface for that.  But the driver should
> not override the system-wide policy for managing ASPM.
>
> Ah, some archaeology finds affa48de8417 ("staging/rdma/hfi1: Add
> support for enabling/disabling PCIe ASPM"), which says:
>
>   hfi1 HW has a high PCIe ASPM L1 exit latency and also advertises an
>   acceptable latency less than actual ASPM latencies.
>
> That suggests that either there is a device defect, e.g., advertising
> incorrect ASPM latencies, or a PCI core defect, e.g., incorrectly
> enabling ASPM when the path exit latency exceeds that hfi1 can
> tolerate.
>
> Coincidentally, Ian recently debugged a problem in how the PCI core
> computes exit latencies over a path [1].
>
> Can anybody supply details about the hfi1 ASPM parameters, e.g., the
> output of "sudo lspci -vv"?  Any details about the configuration where
> the problem occurs?  Is there a switch in the path?
>
> [1] https://lore.kernel.org/r/20200727213045.2117855-1-ian.kumlien@gmail.com
>
> >       /* ASPM works on A-step but is reported as not supported */
> > -     return (!!dn || is_ax(dd)) && !!up;
> > +     return (dn || is_ax(dd)) && up;
> >  }
> >
> >  /* Set L1 entrance latency for slower entry to L1 */
> > --
> > 2.18.4
> >

My experience with pcie is very limited, but the more I look at things
the more I get worried...

Anyway, I have made some changes, could you try the attached patch and
see if it makes a difference?

Changes:
L0s and L1 should only apply to links that actually has it enabled,
don't store or increase values if they don't.
Work on L0s as well, currently it clobbers since I'm not certain about
upstream/downstream distinctions.

diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index b17e5ffd31b1..0d93ae065f73 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -434,7 +434,8 @@ static void pcie_get_aspm_reg(struct pci_dev *pdev,

 static void pcie_aspm_check_latency(struct pci_dev *endpoint)
 {
-       u32 latency, l1_switch_latency = 0;
+       u32 latency, l1_max_latency = 0, l1_switch_latency = 0,
+               l0s_max_latency = 0;
        struct aspm_latency *acceptable;
        struct pcie_link_state *link;

@@ -447,15 +448,24 @@ static void pcie_aspm_check_latency(struct
pci_dev *endpoint)
        acceptable = &link->acceptable[PCI_FUNC(endpoint->devfn)];

        while (link) {
-               /* Check upstream direction L0s latency */
-               if ((link->aspm_capable & ASPM_STATE_L0S_UP) &&
-                   (link->latency_up.l0s > acceptable->l0s))
-                       link->aspm_capable &= ~ASPM_STATE_L0S_UP;
-
-               /* Check downstream direction L0s latency */
-               if ((link->aspm_capable & ASPM_STATE_L0S_DW) &&
-                   (link->latency_dw.l0s > acceptable->l0s))
-                       link->aspm_capable &= ~ASPM_STATE_L0S_DW;
+               if (link->aspm_capable & ASPM_STATE_L0S) {
+                       u32 l0s_up = 0, l0s_dw = 0;
+
+                       /* Check upstream direction L0s latency */
+                       if (link->aspm_capable & ASPM_STATE_L0S_UP)
+                               l0s_up = link->latency_up.l0s;
+
+                       /* Check downstream direction L0s latency */
+                       if (link->aspm_capable & ASPM_STATE_L0S_DW)
+                               l0s_dw = link->latency_dw.l0s;
+
+                       l0s_max_latency += max_t(u32, l0s_up, l0s_dw);
+
+                       /* If the latency exceeds, disable both */
+                       if (l0s_max_latency > acceptable->l0s)
+                               link->aspm_capable &= ~ASPM_STATE_L0S;
+               }
+
                /*
                 * Check L1 latency.
                 * Every switch on the path to root complex need 1
@@ -469,11 +479,13 @@ static void pcie_aspm_check_latency(struct
pci_dev *endpoint)
                 * L1 exit latencies advertised by a device include L1
                 * substate latencies (and hence do not do any check).
                 */
-               latency = max_t(u32, link->latency_up.l1, link->latency_dw.l1);
-               if ((link->aspm_capable & ASPM_STATE_L1) &&
-                   (latency + l1_switch_latency > acceptable->l1))
-                       link->aspm_capable &= ~ASPM_STATE_L1;
-               l1_switch_latency += 1000;
+               if (link->aspm_capable & ASPM_STATE_L1) {
+                       latency = max_t(u32, link->latency_up.l1,
link->latency_dw.l1);
+                       l1_max_latency = max_t(u32, latency, l1_max_latency);
+                       if (l1_max_latency + l1_switch_latency > acceptable->l1)
+                               link->aspm_capable &= ~ASPM_STATE_L1;
+                       l1_switch_latency += 1000;
+               }

                link = link->parent;
        }

--000000000000a7ee6b05abf7b098
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="0001-Use-maximum-latency-when-determining-L1-L0s-ASPM.patch"
Content-Disposition: attachment; 
	filename="0001-Use-maximum-latency-when-determining-L1-L0s-ASPM.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_kdeg1dxx0>
X-Attachment-Id: f_kdeg1dxx0

RnJvbSA5NzE3MzViZDMyZDdhOGNiN2NkMWE4ZDQzMTZmYzJhMmUxOTJmOGUyIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBJYW4gS3VtbGllbiA8aWFuLmt1bWxpZW5AZ21haWwuY29tPgpE
YXRlOiBTdW4sIDI2IEp1bCAyMDIwIDE2OjAxOjE1ICswMjAwClN1YmplY3Q6IFtQQVRDSF0gVXNl
IG1heGltdW0gbGF0ZW5jeSB3aGVuIGRldGVybWluaW5nIEwxL0wwcyBBU1BNCgpDdXJyZW50bHkg
d2UgY2hlY2sgdGhlIG1heGltdW0gbGF0ZW5jeSBvZiB1cHN0cmVhbSBhbmQgZG93bnN0cmVhbQpw
ZXIgbGluaywgbm90IHRoZSBtYXhpbXVtIGZvciB0aGUgcGF0aAoKVGhpcyB3b3VsZCB3b3JrIGlm
IGFsbCBsaW5rcyBoYXZlIHRoZSBzYW1lIGxhdGVuY3ksIGJ1dDoKZW5kcG9pbnQgLT4gYyAtPiBi
IC0+IGEgLT4gcm9vdCAgKGluIHRoZSBvcmRlciB3ZSB3YWxrIHRoZSBwYXRoKQoKSWYgYyBvciBi
IGhhcyB0aGUgaGlnZXN0IGxhdGVuY3ksIGl0IHdpbGwgbm90IHJlZ2lzdGVyCgpGaXggdGhpcyBi
eSBtYWludGFpbmluZyB0aGUgbWF4aW11bSBsYXRlbmN5IHZhbHVlIGZvciB0aGUgcGF0aAoKQWxz
bywgTDBzIHNlZW1zIHRvIGJlIGEgY3VtdWxhdGl2ZSBtYXhpbXVtIG92ZXIgdGhlIHBhdGgsIGZp
eCB0aGlzIGFzCndlbGwKClRoaXMgY2hhbmdlIGZpeGVzIGEgcmVncmVzc2lvbiBpbnRyb2R1Y2Vk
IChidXQgbm90IGNhdXNlZCkgYnk6CjY2ZmYxNGU1OWU4YSAoUENJL0FTUE06IEFsbG93IEFTUE0g
b24gbGlua3MgdG8gUENJZS10by1QQ0kvUENJLVggQnJpZGdlcykKClNpZ25lZC1vZmYtYnk6IElh
biBLdW1saWVuIDxpYW4ua3VtbGllbkBnbWFpbC5jb20+Ci0tLQogZHJpdmVycy9wY2kvcGNpZS9h
c3BtLmMgfCA0MiArKysrKysrKysrKysrKysrKysrKysrKysrKy0tLS0tLS0tLS0tLS0tLQogMSBm
aWxlIGNoYW5nZWQsIDI3IGluc2VydGlvbnMoKyksIDE1IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdp
dCBhL2RyaXZlcnMvcGNpL3BjaWUvYXNwbS5jIGIvZHJpdmVycy9wY2kvcGNpZS9hc3BtLmMKaW5k
ZXggYjE3ZTVmZmQzMWIxLi4wZDkzYWUwNjVmNzMgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvcGNpL3Bj
aWUvYXNwbS5jCisrKyBiL2RyaXZlcnMvcGNpL3BjaWUvYXNwbS5jCkBAIC00MzQsNyArNDM0LDgg
QEAgc3RhdGljIHZvaWQgcGNpZV9nZXRfYXNwbV9yZWcoc3RydWN0IHBjaV9kZXYgKnBkZXYsCiAK
IHN0YXRpYyB2b2lkIHBjaWVfYXNwbV9jaGVja19sYXRlbmN5KHN0cnVjdCBwY2lfZGV2ICplbmRw
b2ludCkKIHsKLQl1MzIgbGF0ZW5jeSwgbDFfc3dpdGNoX2xhdGVuY3kgPSAwOworCXUzMiBsYXRl
bmN5LCBsMV9tYXhfbGF0ZW5jeSA9IDAsIGwxX3N3aXRjaF9sYXRlbmN5ID0gMCwKKwkJbDBzX21h
eF9sYXRlbmN5ID0gMDsKIAlzdHJ1Y3QgYXNwbV9sYXRlbmN5ICphY2NlcHRhYmxlOwogCXN0cnVj
dCBwY2llX2xpbmtfc3RhdGUgKmxpbms7CiAKQEAgLTQ0NywxNSArNDQ4LDI0IEBAIHN0YXRpYyB2
b2lkIHBjaWVfYXNwbV9jaGVja19sYXRlbmN5KHN0cnVjdCBwY2lfZGV2ICplbmRwb2ludCkKIAlh
Y2NlcHRhYmxlID0gJmxpbmstPmFjY2VwdGFibGVbUENJX0ZVTkMoZW5kcG9pbnQtPmRldmZuKV07
CiAKIAl3aGlsZSAobGluaykgewotCQkvKiBDaGVjayB1cHN0cmVhbSBkaXJlY3Rpb24gTDBzIGxh
dGVuY3kgKi8KLQkJaWYgKChsaW5rLT5hc3BtX2NhcGFibGUgJiBBU1BNX1NUQVRFX0wwU19VUCkg
JiYKLQkJICAgIChsaW5rLT5sYXRlbmN5X3VwLmwwcyA+IGFjY2VwdGFibGUtPmwwcykpCi0JCQls
aW5rLT5hc3BtX2NhcGFibGUgJj0gfkFTUE1fU1RBVEVfTDBTX1VQOwotCi0JCS8qIENoZWNrIGRv
d25zdHJlYW0gZGlyZWN0aW9uIEwwcyBsYXRlbmN5ICovCi0JCWlmICgobGluay0+YXNwbV9jYXBh
YmxlICYgQVNQTV9TVEFURV9MMFNfRFcpICYmCi0JCSAgICAobGluay0+bGF0ZW5jeV9kdy5sMHMg
PiBhY2NlcHRhYmxlLT5sMHMpKQotCQkJbGluay0+YXNwbV9jYXBhYmxlICY9IH5BU1BNX1NUQVRF
X0wwU19EVzsKKwkJaWYgKGxpbmstPmFzcG1fY2FwYWJsZSAmIEFTUE1fU1RBVEVfTDBTKSB7CisJ
CQl1MzIgbDBzX3VwID0gMCwgbDBzX2R3ID0gMDsKKworCQkJLyogQ2hlY2sgdXBzdHJlYW0gZGly
ZWN0aW9uIEwwcyBsYXRlbmN5ICovCisJCQlpZiAobGluay0+YXNwbV9jYXBhYmxlICYgQVNQTV9T
VEFURV9MMFNfVVApCisJCQkJbDBzX3VwID0gbGluay0+bGF0ZW5jeV91cC5sMHM7CisKKwkJCS8q
IENoZWNrIGRvd25zdHJlYW0gZGlyZWN0aW9uIEwwcyBsYXRlbmN5ICovCisJCQlpZiAobGluay0+
YXNwbV9jYXBhYmxlICYgQVNQTV9TVEFURV9MMFNfRFcpCisJCQkJbDBzX2R3ID0gbGluay0+bGF0
ZW5jeV9kdy5sMHM7CisKKwkJCWwwc19tYXhfbGF0ZW5jeSArPSBtYXhfdCh1MzIsIGwwc191cCwg
bDBzX2R3KTsKKworCQkJLyogSWYgdGhlIGxhdGVuY3kgZXhjZWVkcywgZGlzYWJsZSBib3RoICov
CisJCQlpZiAobDBzX21heF9sYXRlbmN5ID4gYWNjZXB0YWJsZS0+bDBzKQorCQkJCWxpbmstPmFz
cG1fY2FwYWJsZSAmPSB+QVNQTV9TVEFURV9MMFM7CisJCX0KKwogCQkvKgogCQkgKiBDaGVjayBM
MSBsYXRlbmN5LgogCQkgKiBFdmVyeSBzd2l0Y2ggb24gdGhlIHBhdGggdG8gcm9vdCBjb21wbGV4
IG5lZWQgMQpAQCAtNDY5LDExICs0NzksMTMgQEAgc3RhdGljIHZvaWQgcGNpZV9hc3BtX2NoZWNr
X2xhdGVuY3koc3RydWN0IHBjaV9kZXYgKmVuZHBvaW50KQogCQkgKiBMMSBleGl0IGxhdGVuY2ll
cyBhZHZlcnRpc2VkIGJ5IGEgZGV2aWNlIGluY2x1ZGUgTDEKIAkJICogc3Vic3RhdGUgbGF0ZW5j
aWVzIChhbmQgaGVuY2UgZG8gbm90IGRvIGFueSBjaGVjaykuCiAJCSAqLwotCQlsYXRlbmN5ID0g
bWF4X3QodTMyLCBsaW5rLT5sYXRlbmN5X3VwLmwxLCBsaW5rLT5sYXRlbmN5X2R3LmwxKTsKLQkJ
aWYgKChsaW5rLT5hc3BtX2NhcGFibGUgJiBBU1BNX1NUQVRFX0wxKSAmJgotCQkgICAgKGxhdGVu
Y3kgKyBsMV9zd2l0Y2hfbGF0ZW5jeSA+IGFjY2VwdGFibGUtPmwxKSkKLQkJCWxpbmstPmFzcG1f
Y2FwYWJsZSAmPSB+QVNQTV9TVEFURV9MMTsKLQkJbDFfc3dpdGNoX2xhdGVuY3kgKz0gMTAwMDsK
KwkJaWYgKGxpbmstPmFzcG1fY2FwYWJsZSAmIEFTUE1fU1RBVEVfTDEpIHsKKwkJCWxhdGVuY3kg
PSBtYXhfdCh1MzIsIGxpbmstPmxhdGVuY3lfdXAubDEsIGxpbmstPmxhdGVuY3lfZHcubDEpOwor
CQkJbDFfbWF4X2xhdGVuY3kgPSBtYXhfdCh1MzIsIGxhdGVuY3ksIGwxX21heF9sYXRlbmN5KTsK
KwkJCWlmIChsMV9tYXhfbGF0ZW5jeSArIGwxX3N3aXRjaF9sYXRlbmN5ID4gYWNjZXB0YWJsZS0+
bDEpCisJCQkJbGluay0+YXNwbV9jYXBhYmxlICY9IH5BU1BNX1NUQVRFX0wxOworCQkJbDFfc3dp
dGNoX2xhdGVuY3kgKz0gMTAwMDsKKwkJfQogCiAJCWxpbmsgPSBsaW5rLT5wYXJlbnQ7CiAJfQot
LSAKMi4yOC4wCgo=
--000000000000a7ee6b05abf7b098--
