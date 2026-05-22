Return-Path: <linux-rdma+bounces-21159-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yKLNNZWNEGrEZQYAu9opvQ
	(envelope-from <linux-rdma+bounces-21159-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 22 May 2026 19:08:37 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D87CC5B7F25
	for <lists+linux-rdma@lfdr.de>; Fri, 22 May 2026 19:08:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 13119304EA2B
	for <lists+linux-rdma@lfdr.de>; Fri, 22 May 2026 17:01:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C21E45BD6F;
	Fri, 22 May 2026 17:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ao/i8rtQ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22A873BFE5C
	for <linux-rdma@vger.kernel.org>; Fri, 22 May 2026 17:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779469307; cv=none; b=kjr7fYnbpE3BMSSgK0Lb/doR73aii2zLo5pSLmfYCf074D3nXg1pzBun7HwJU3Susx1xDdkuSat2KlSL+xxAvG4YK+MirlntGkbaNN3Bra/iFTn0uVyhqB3pZokb3iQP/tBhonv+KerF4fxLahoaO6EtL9SBeaAKCZECzCbYfIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779469307; c=relaxed/simple;
	bh=GsDxheD31HjR0QHAUhE39yewmHHmbWgTxfY47fCtknw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bpZxjpGBZzinvGy8+4J4UWt++Va8YSOW4vv6BAwUsoiuseyxpCByzLQ3lEmzSTrUBAWqAWrXqw0Ue+crlOPPAq19cjBH1GmcxmEV8TqQEB2V0C3pBbN9Cva4GDWD06lj4Dp0HIZEMYndaB4lxAxiVpqWPLuVvZnQbLiv98VwBeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ao/i8rtQ; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AA391F00A3E
	for <linux-rdma@vger.kernel.org>; Fri, 22 May 2026 17:01:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779469296;
	bh=CBb82G9iciv1b3maCMB4onItloW4z0ib3p030amdb30=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=ao/i8rtQfNg/7KBnep3lQU1s4a5N7mGxc+3xJJn1Ll0QQijChORFswDv9rcMNyQv8
	 bx52byyhpFapEDJg4P/4SgkH00l2WTrwR0c5uvXp5rTCVbezAI6iF78P3ajAgeZ8uw
	 sIxf2A2RvlXoV8QPfW8pR9GAOqNFE6JFo2hABMGGyYJho6pUeouUEdlBpvhrlr3mqT
	 JYMyVjux4o9vn7pGKXVN7FN4PSX0SFXUXuwIyOt6auc1AobwTE4vudHOJ2u4m5oQIU
	 H2mKplKeI3FDfrd1rGtSpKYYj+7Gdohi7LrXags1TQRY3gDUPr84Fpm09Q0JjZzGM8
	 xZvrEV3pjQCyg==
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5a8d1f43432so12625388e87.3
        for <linux-rdma@vger.kernel.org>; Fri, 22 May 2026 10:01:35 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ/GswVhkmLNrTddJ21wcGpXaz+vV5IQL4bf74KUQCGvNG27rJjjoiqoVv4MKvi9x+uQOn0yjkb44zlA@vger.kernel.org
X-Gm-Message-State: AOJu0YxIHnqJ0JuU9eIiXYqaoEDA/kuj0oZzkGtqYY1D02t+4XqIbbq8
	8hXohn4vJZ4fSSk+Gje4QZu1i3NVxqLhsiJFZgD9nqlYQeINnWrSPtTlMOpNT8g3Qzb7GkoknHP
	/MnPJlck8hCDa33KeQ2zM5hS9eeIwSaQ=
X-Received: by 2002:a05:6512:692:b0:5a8:8df8:1dca with SMTP id
 2adb3069b0e04-5aa323cb5e4mr1444069e87.29.1779469292338; Fri, 22 May 2026
 10:01:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260521133315.work.845-kees@kernel.org> <20260521133326.2465264-4-kees@kernel.org>
In-Reply-To: <20260521133326.2465264-4-kees@kernel.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 22 May 2026 19:01:20 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0iaQsP+-yxwTf1sLanR1tfuJyDeBNR5xh3SYoFsmULt+g@mail.gmail.com>
X-Gm-Features: AVHnY4KvNai3mtv-152WeuDLOFDbp4__J10ytFjfDJDU_8PqjcP6QLkFZRWqY5U
Message-ID: <CAJZ5v0iaQsP+-yxwTf1sLanR1tfuJyDeBNR5xh3SYoFsmULt+g@mail.gmail.com>
Subject: Re: [PATCH 04/11] treewide: Convert struct kernel_param_ops
 initializers to DEFINE_KERNEL_PARAM_OPS
To: Kees Cook <kees@kernel.org>
Cc: Luis Chamberlain <mcgrof@kernel.org>, Pengpeng Hou <pengpeng@iscas.ac.cn>, 
	Petr Pavlu <petr.pavlu@suse.com>, Richard Weinberger <richard@nod.at>, 
	Anton Ivanov <anton.ivanov@cambridgegreys.com>, Johannes Berg <johannes@sipsolutions.net>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, Corey Minyard <corey@minyard.net>, 
	Gabriel Somlo <somlo@cmu.edu>, "Michael S. Tsirkin" <mst@redhat.com>, 
	Jani Nikula <jani.nikula@linux.intel.com>, 
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>, 
	Tvrtko Ursulin <tursulin@ursulin.net>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Bart Van Assche <bvanassche@acm.org>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Leon Romanovsky <leon@kernel.org>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
	Hans de Goede <hansg@kernel.org>, Mauro Carvalho Chehab <mchehab@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Hannes Reinecke <hare@suse.de>, 
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, 
	"Martin K. Petersen" <martin.petersen@oracle.com>, Daniel Lezcano <daniel.lezcano@kernel.org>, 
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	Alan Stern <stern@rowland.harvard.edu>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Jason Baron <jbaron@akamai.com>, Jim Cromie <jim.cromie@gmail.com>, 
	Tiwei Bie <tiwei.btw@antgroup.com>, Benjamin Berg <benjamin.berg@intel.com>, 
	=?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	"David E. Box" <david.e.box@linux.intel.com>, "Maciej W. Rozycki" <macro@orcam.me.uk>, 
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, 
	Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
	Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>, 
	Daniel Gomez <da.gomez@kernel.org>, Sami Tolvanen <samitolvanen@google.com>, 
	Aaron Tomlin <atomlin@atomlin.com>, Alexander Potapenko <glider@google.com>, Marco Elver <elver@google.com>, 
	Dmitry Vyukov <dvyukov@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
	John Johansen <john.johansen@canonical.com>, Paul Moore <paul@paul-moore.com>, 
	James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Georgia Garcia <georgia.garcia@canonical.com>, kvm@vger.kernel.org, 
	dmaengine@vger.kernel.org, linux-modules@vger.kernel.org, 
	kasan-dev@googlegroups.com, linux-mm@kvack.org, apparmor@lists.ubuntu.com, 
	linux-security-module@vger.kernel.org, linux-um@lists.infradead.org, 
	linux-acpi@vger.kernel.org, openipmi-developer@lists.sourceforge.net, 
	qemu-devel@nongnu.org, intel-gfx@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, linux-rdma@vger.kernel.org, 
	linux-media@vger.kernel.org, linux-pci@vger.kernel.org, 
	linux-scsi@vger.kernel.org, linux-pm@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, linux-serial@vger.kernel.org, 
	linux-usb@vger.kernel.org, usb-storage@lists.one-eyed-alien.net, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
	linux-arch@vger.kernel.org, netdev@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-21159-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,iscas.ac.cn,suse.com,nod.at,cambridgegreys.com,sipsolutions.net,minyard.net,cmu.edu,redhat.com,linux.intel.com,intel.com,ursulin.net,gmail.com,ffwll.ch,acm.org,ziepe.ca,ideasonboard.com,google.com,suse.de,hansenpartnership.com,oracle.com,arm.com,linuxfoundation.org,rowland.harvard.edu,linux.alibaba.com,akamai.com,antgroup.com,orcam.me.uk,infradead.org,linux.ibm.com,alien8.de,zytor.com,atomlin.com,linux-foundation.org,canonical.com,paul-moore.com,namei.org,hallyn.com,vger.kernel.org,googlegroups.com,kvack.org,lists.ubuntu.com,lists.infradead.org,lists.sourceforge.net,nongnu.org,lists.freedesktop.org,lists.ozlabs.org,lists.one-eyed-alien.net,lists.linux.dev];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rafael@kernel.org,linux-rdma@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_GT_50(0.00)[99];
	TAGGED_RCPT(0.00)[linux-rdma];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: D87CC5B7F25
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, May 21, 2026 at 3:33=E2=80=AFPM Kees Cook <kees@kernel.org> wrote:
>
> Using Coccinelle, rewrite every struct kernel_param_ops initializer that
> sets .get into a DEFINE_KERNEL_PARAM_OPS-family macro invocation,
> for example:
>
> @@
> declarer name DEFINE_KERNEL_PARAM_OPS;
> identifier OPS;
> expression SET, GET;
> @@
> - const struct kernel_param_ops OPS =3D {
> -       .set =3D SET,
> -       .get =3D GET,
> - };
> + DEFINE_KERNEL_PARAM_OPS(OPS, SET, GET);
>
> Using the macro for initialization means future changes can manipulate
> the struct layout and callback prototypes without having to change every
> initializer.
>
> Signed-off-by: Kees Cook <kees@kernel.org>

For ACPI and hibernation:

Acked-by: Rafael J. Wysocki (Intel) <rafael@kernel.org>

> ---
>  mm/kfence/core.c                              |  7 +-
>  arch/powerpc/kvm/book3s_hv.c                  |  5 +-
>  arch/s390/kernel/perf_cpum_sf.c               |  6 +-
>  arch/um/drivers/vfio_kern.c                   |  6 +-
>  arch/um/drivers/virtio_uml.c                  |  6 +-
>  arch/x86/kernel/msr.c                         |  6 +-
>  arch/x86/kvm/mmu/mmu.c                        | 12 +--
>  arch/x86/kvm/svm/avic.c                       |  6 +-
>  arch/x86/kvm/vmx/vmx.c                        |  6 +-
>  arch/x86/platform/uv/uv_nmi.c                 | 12 +--
>  block/disk-events.c                           |  6 +-
>  drivers/acpi/sysfs.c                          | 25 +++----
>  drivers/block/loop.c                          | 12 +--
>  drivers/block/null_blk/main.c                 | 12 +--
>  drivers/block/rnbd/rnbd-srv.c                 |  6 +-
>  drivers/block/ublk_drv.c                      |  7 +-
>  drivers/char/ipmi/ipmi_msghandler.c           |  6 +-
>  drivers/char/ipmi/ipmi_watchdog.c             | 17 ++---
>  drivers/crypto/hisilicon/hpre/hpre_main.c     | 16 +---
>  drivers/crypto/hisilicon/sec2/sec_main.c      | 23 ++----
>  drivers/crypto/hisilicon/zip/zip_crypto.c     |  5 +-
>  drivers/crypto/hisilicon/zip/zip_main.c       | 21 ++----
>  drivers/dma/dmatest.c                         | 20 ++---
>  drivers/edac/i10nm_base.c                     |  6 +-
>  drivers/firmware/efi/efi-pstore.c             |  6 +-
>  drivers/firmware/qcom/qcom_scm.c              |  6 +-
>  drivers/firmware/qemu_fw_cfg.c                |  6 +-
>  drivers/gpu/drm/drm_panic.c                   |  6 +-
>  drivers/gpu/drm/i915/i915_mitigations.c       |  5 +-
>  drivers/gpu/drm/imagination/pvr_fw_trace.c    |  6 +-
>  drivers/hid/hid-cougar.c                      |  6 +-
>  drivers/hid/hid-steam.c                       |  6 +-
>  drivers/infiniband/hw/hfi1/driver.c           |  5 +-
>  drivers/infiniband/ulp/iser/iscsi_iser.c      |  6 +-
>  drivers/infiniband/ulp/isert/ib_isert.c       |  6 +-
>  drivers/infiniband/ulp/srp/ib_srp.c           |  5 +-
>  drivers/input/misc/ati_remote2.c              | 13 ++--
>  drivers/input/mouse/psmouse-base.c            |  6 +-
>  drivers/media/usb/uvc/uvc_driver.c            |  6 +-
>  drivers/misc/lis3lv02d/lis3lv02d.c            |  5 +-
>  drivers/net/wireless/ath/wil6210/main.c       | 10 +--
>  drivers/nvme/host/multipath.c                 | 12 +--
>  drivers/nvme/host/pci.c                       | 18 ++---
>  drivers/nvme/target/rdma.c                    |  5 +-
>  drivers/nvme/target/tcp.c                     |  5 +-
>  drivers/platform/x86/acerhdf.c                |  5 +-
>  drivers/power/supply/bq27xxx_battery.c        |  6 +-
>  drivers/power/supply/test_power.c             | 75 ++++++++-----------
>  drivers/scsi/sg.c                             |  6 +-
>  drivers/target/target_core_user.c             | 13 ++--
>  .../processor_thermal_soc_slider.c            | 12 +--
>  drivers/thermal/intel/intel_powerclamp.c      | 20 +----
>  drivers/tty/hvc/hvc_iucv.c                    |  6 +-
>  drivers/tty/sysrq.c                           |  6 +-
>  drivers/ufs/core/ufs-fault-injection.c        |  5 +-
>  drivers/ufs/core/ufs-mcq.c                    | 18 ++---
>  drivers/ufs/core/ufs-txeq.c                   |  5 +-
>  drivers/ufs/core/ufshcd.c                     | 12 +--
>  drivers/usb/core/quirks.c                     |  6 +-
>  drivers/usb/gadget/legacy/serial.c            |  5 +-
>  drivers/usb/storage/usb.c                     |  5 +-
>  drivers/vhost/scsi.c                          |  7 +-
>  drivers/virt/nitro_enclaves/ne_misc_dev.c     |  6 +-
>  drivers/virtio/virtio_mmio.c                  |  6 +-
>  fs/ceph/super.c                               | 10 +--
>  fs/fuse/dir.c                                 |  5 +-
>  fs/nfs/namespace.c                            |  6 +-
>  fs/nfs/super.c                                |  6 +-
>  fs/ubifs/super.c                              |  6 +-
>  kernel/locking/locktorture.c                  |  6 +-
>  kernel/panic.c                                |  6 +-
>  kernel/params.c                               | 44 +++--------
>  kernel/power/hibernate.c                      |  6 +-
>  kernel/rcu/tree.c                             | 18 ++---
>  kernel/sched/ext.c                            | 11 +--
>  kernel/workqueue.c                            | 12 +--
>  lib/dynamic_debug.c                           |  6 +-
>  lib/test_dynamic_debug.c                      |  6 +-
>  mm/damon/lru_sort.c                           | 19 ++---
>  mm/damon/reclaim.c                            | 19 ++---
>  mm/damon/stat.c                               |  6 +-
>  mm/memory_hotplug.c                           | 12 +--
>  mm/page_reporting.c                           | 11 +--
>  mm/shuffle.c                                  |  6 +-
>  mm/zswap.c                                    | 14 ++--
>  net/batman-adv/bat_algo.c                     |  6 +-
>  net/ceph/ceph_common.c                        |  5 +-
>  net/ipv4/tcp_dctcp.c                          |  6 +-
>  net/sunrpc/auth.c                             |  6 +-
>  net/sunrpc/xprtsock.c                         | 18 ++---
>  samples/damon/mtier.c                         |  6 +-
>  samples/damon/prcl.c                          |  6 +-
>  samples/damon/wsse.c                          |  6 +-
>  security/apparmor/lsm.c                       | 34 +++------
>  sound/hda/controllers/intel.c                 |  5 +-
>  sound/usb/card.c                              |  7 +-
>  96 files changed, 307 insertions(+), 660 deletions(-)
>
> diff --git a/mm/kfence/core.c b/mm/kfence/core.c
> index 655dc5ce3240..e14102c01520 100644
> --- a/mm/kfence/core.c
> +++ b/mm/kfence/core.c
> @@ -92,10 +92,9 @@ static int param_get_sample_interval(char *buffer, con=
st struct kernel_param *kp
>         return param_get_ulong(buffer, kp);
>  }
>
> -static const struct kernel_param_ops sample_interval_param_ops =3D {
> -       .set =3D param_set_sample_interval,
> -       .get =3D param_get_sample_interval,
> -};
> +static DEFINE_KERNEL_PARAM_OPS(sample_interval_param_ops,
> +                              param_set_sample_interval,
> +                              param_get_sample_interval);
>  module_param_cb(sample_interval, &sample_interval_param_ops, &kfence_sam=
ple_interval, 0600);
>
>  /* Pool usage% threshold when currently covered allocations are skipped.=
 */
> diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
> index 61dbeea317f3..0c15f0426671 100644
> --- a/arch/powerpc/kvm/book3s_hv.c
> +++ b/arch/powerpc/kvm/book3s_hv.c
> @@ -114,10 +114,7 @@ module_param(one_vm_per_core, bool, S_IRUGO | S_IWUS=
R);
>  MODULE_PARM_DESC(one_vm_per_core, "Only run vCPUs from the same VM on a =
core (requires POWER8 or older)");
>
>  #ifdef CONFIG_KVM_XICS
> -static const struct kernel_param_ops module_param_ops =3D {
> -       .set =3D param_set_int,
> -       .get =3D param_get_int,
> -};
> +static DEFINE_KERNEL_PARAM_OPS(module_param_ops, param_set_int, param_ge=
t_int);
>
>  module_param_cb(kvm_irq_bypass, &module_param_ops, &kvm_irq_bypass, 0644=
);
>  MODULE_PARM_DESC(kvm_irq_bypass, "Bypass passthrough interrupt optimizat=
ion");
> diff --git a/arch/s390/kernel/perf_cpum_sf.c b/arch/s390/kernel/perf_cpum=
_sf.c
> index 7bfeb5208177..76119542562b 100644
> --- a/arch/s390/kernel/perf_cpum_sf.c
> +++ b/arch/s390/kernel/perf_cpum_sf.c
> @@ -2029,10 +2029,8 @@ static int param_set_sfb_size(const char *val, con=
st struct kernel_param *kp)
>  }
>
>  #define param_check_sfb_size(name, p) __param_check(name, p, void)
> -static const struct kernel_param_ops param_ops_sfb_size =3D {
> -       .set =3D param_set_sfb_size,
> -       .get =3D param_get_sfb_size,
> -};
> +static DEFINE_KERNEL_PARAM_OPS(param_ops_sfb_size, param_set_sfb_size,
> +                              param_get_sfb_size);
>
>  enum {
>         RS_INIT_FAILURE_BSDES   =3D 2,    /* Bad basic sampling size */
> diff --git a/arch/um/drivers/vfio_kern.c b/arch/um/drivers/vfio_kern.c
> index e6dab473cde4..fb7988dc5482 100644
> --- a/arch/um/drivers/vfio_kern.c
> +++ b/arch/um/drivers/vfio_kern.c
> @@ -628,10 +628,8 @@ static int uml_vfio_cmdline_get(char *buffer, const =
struct kernel_param *kp)
>         return 0;
>  }
>
> -static const struct kernel_param_ops uml_vfio_cmdline_param_ops =3D {
> -       .set =3D uml_vfio_cmdline_set,
> -       .get =3D uml_vfio_cmdline_get,
> -};
> +static DEFINE_KERNEL_PARAM_OPS(uml_vfio_cmdline_param_ops, uml_vfio_cmdl=
ine_set,
> +                              uml_vfio_cmdline_get);
>
>  device_param_cb(device, &uml_vfio_cmdline_param_ops, NULL, 0400);
>  __uml_help(uml_vfio_cmdline_param_ops,
> diff --git a/arch/um/drivers/virtio_uml.c b/arch/um/drivers/virtio_uml.c
> index 7425a8548141..f9ae745f4586 100644
> --- a/arch/um/drivers/virtio_uml.c
> +++ b/arch/um/drivers/virtio_uml.c
> @@ -1398,10 +1398,8 @@ static int vu_cmdline_get(char *buffer, const stru=
ct kernel_param *kp)
>         return strlen(buffer) + 1;
>  }
>
> -static const struct kernel_param_ops vu_cmdline_param_ops =3D {
> -       .set =3D vu_cmdline_set,
> -       .get =3D vu_cmdline_get,
> -};
> +static DEFINE_KERNEL_PARAM_OPS(vu_cmdline_param_ops, vu_cmdline_set,
> +                              vu_cmdline_get);
>
>  device_param_cb(device, &vu_cmdline_param_ops, NULL, S_IRUSR);
>  __uml_help(vu_cmdline_param_ops,
> diff --git a/arch/x86/kernel/msr.c b/arch/x86/kernel/msr.c
> index 4469c784eaa0..5f4e1814dc4d 100644
> --- a/arch/x86/kernel/msr.c
> +++ b/arch/x86/kernel/msr.c
> @@ -322,10 +322,8 @@ static int get_allow_writes(char *buf, const struct =
kernel_param *kp)
>         return sprintf(buf, "%s\n", res);
>  }
>
> -static const struct kernel_param_ops allow_writes_ops =3D {
> -       .set =3D set_allow_writes,
> -       .get =3D get_allow_writes
> -};
> +static DEFINE_KERNEL_PARAM_OPS(allow_writes_ops, set_allow_writes,
> +                              get_allow_writes);
>
>  module_param_cb(allow_writes, &allow_writes_ops, NULL, 0600);
>
> diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
> index 24fbc9ea502a..996818ee9b09 100644
> --- a/arch/x86/kvm/mmu/mmu.c
> +++ b/arch/x86/kvm/mmu/mmu.c
> @@ -74,15 +74,11 @@ static int get_nx_huge_pages(char *buffer, const stru=
ct kernel_param *kp);
>  static int set_nx_huge_pages(const char *val, const struct kernel_param =
*kp);
>  static int set_nx_huge_pages_recovery_param(const char *val, const struc=
t kernel_param *kp);
>
> -static const struct kernel_param_ops nx_huge_pages_ops =3D {
> -       .set =3D set_nx_huge_pages,
> -       .get =3D get_nx_huge_pages,
> -};
> +static DEFINE_KERNEL_PARAM_OPS(nx_huge_pages_ops, set_nx_huge_pages,
> +                              get_nx_huge_pages);
>
> -static const struct kernel_param_ops nx_huge_pages_recovery_param_ops =
=3D {
> -       .set =3D set_nx_huge_pages_recovery_param,
> -       .get =3D param_get_uint,
> -};
> +static DEFINE_KERNEL_PARAM_OPS(nx_huge_pages_recovery_param_ops,
> +                              set_nx_huge_pages_recovery_param, param_ge=
t_uint);
>
>  module_param_cb(nx_huge_pages, &nx_huge_pages_ops, &nx_huge_pages, 0644)=
;
>  __MODULE_PARM_TYPE(nx_huge_pages, "bool");
> diff --git a/arch/x86/kvm/svm/avic.c b/arch/x86/kvm/svm/avic.c
> index adf211860949..7907f9addff9 100644
> --- a/arch/x86/kvm/svm/avic.c
> +++ b/arch/x86/kvm/svm/avic.c
> @@ -87,11 +87,7 @@ static int avic_param_get(char *buffer, const struct k=
ernel_param *kp)
>         return param_get_bool(buffer, kp);
>  }
>
> -static const struct kernel_param_ops avic_ops =3D {
> -       .flags =3D KERNEL_PARAM_OPS_FL_NOARG,
> -       .set =3D avic_param_set,
> -       .get =3D avic_param_get,
> -};
> +static DEFINE_KERNEL_PARAM_OPS_NOARG(avic_ops, avic_param_set, avic_para=
m_get);
>
>  /*
>   * Enable / disable AVIC.  In "auto" mode (default behavior), AVIC is en=
abled
> diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
> index a29896a9ef14..07f4c7209ac0 100644
> --- a/arch/x86/kvm/vmx/vmx.c
> +++ b/arch/x86/kvm/vmx/vmx.c
> @@ -465,10 +465,8 @@ static int vmentry_l1d_flush_get(char *s, const stru=
ct kernel_param *kp)
>  }
>  #endif
>
> -static const struct kernel_param_ops vmentry_l1d_flush_ops =3D {
> -       .set =3D vmentry_l1d_flush_set,
> -       .get =3D vmentry_l1d_flush_get,
> -};
> +static DEFINE_KERNEL_PARAM_OPS(vmentry_l1d_flush_ops, vmentry_l1d_flush_=
set,
> +                              vmentry_l1d_flush_get);
>  module_param_cb(vmentry_l1d_flush, &vmentry_l1d_flush_ops, NULL, 0644);
>
>  static __always_inline void vmx_disable_fb_clear(struct vcpu_vmx *vmx)
> diff --git a/arch/x86/platform/uv/uv_nmi.c b/arch/x86/platform/uv/uv_nmi.=
c
> index 5c50e550ab63..a7ac80b5f8d9 100644
> --- a/arch/x86/platform/uv/uv_nmi.c
> +++ b/arch/x86/platform/uv/uv_nmi.c
> @@ -123,10 +123,8 @@ static int param_set_local64(const char *val, const =
struct kernel_param *kp)
>         return 0;
>  }
>
> -static const struct kernel_param_ops param_ops_local64 =3D {
> -       .get =3D param_get_local64,
> -       .set =3D param_set_local64,
> -};
> +static DEFINE_KERNEL_PARAM_OPS(param_ops_local64, param_set_local64,
> +                              param_get_local64);
>  #define param_check_local64(name, p) __param_check(name, p, local64_t)
>
>  static local64_t uv_nmi_count;
> @@ -232,10 +230,8 @@ static int param_set_action(const char *val, const s=
truct kernel_param *kp)
>         return -EINVAL;
>  }
>
> -static const struct kernel_param_ops param_ops_action =3D {
> -       .get =3D param_get_action,
> -       .set =3D param_set_action,
> -};
> +static DEFINE_KERNEL_PARAM_OPS(param_ops_action, param_set_action,
> +                              param_get_action);
>  #define param_check_action(name, p) __param_check(name, p, enum action_t=
)
>
>  module_param_named(action, uv_nmi_action, action, 0644);
> diff --git a/block/disk-events.c b/block/disk-events.c
> index 074731ecc3d2..f2d4b48294c6 100644
> --- a/block/disk-events.c
> +++ b/block/disk-events.c
> @@ -416,10 +416,8 @@ static int disk_events_set_dfl_poll_msecs(const char=
 *val,
>         return 0;
>  }
>
> -static const struct kernel_param_ops disk_events_dfl_poll_msecs_param_op=
s =3D {
> -       .set    =3D disk_events_set_dfl_poll_msecs,
> -       .get    =3D param_get_ulong,
> -};
> +static DEFINE_KERNEL_PARAM_OPS(disk_events_dfl_poll_msecs_param_ops,
> +                              disk_events_set_dfl_poll_msecs, param_get_=
ulong);
>
>  #undef MODULE_PARAM_PREFIX
>  #define MODULE_PARAM_PREFIX    "block."
> diff --git a/drivers/acpi/sysfs.c b/drivers/acpi/sysfs.c
> index a625de3c3c8b..3d32a5280432 100644
> --- a/drivers/acpi/sysfs.c
> +++ b/drivers/acpi/sysfs.c
> @@ -138,15 +138,11 @@ static int param_get_debug_level(char *buffer, cons=
t struct kernel_param *kp)
>         return result;
>  }
>
> -static const struct kernel_param_ops param_ops_debug_layer =3D {
> -       .set =3D param_set_uint,
> -       .get =3D param_get_debug_layer,
> -};
> +static DEFINE_KERNEL_PARAM_OPS(param_ops_debug_layer, param_set_uint,
> +                              param_get_debug_layer);
>
> -static const struct kernel_param_ops param_ops_debug_level =3D {
> -       .set =3D param_set_uint,
> -       .get =3D param_get_debug_level,
> -};
> +static DEFINE_KERNEL_PARAM_OPS(param_ops_debug_level, param_set_uint,
> +                              param_get_debug_level);
>
>  module_param_cb(debug_layer, &param_ops_debug_layer, &acpi_dbg_layer, 06=
44);
>  module_param_cb(debug_level, &param_ops_debug_level, &acpi_dbg_level, 06=
44);
> @@ -201,15 +197,12 @@ static int param_get_trace_method_name(char *buffer=
, const struct kernel_param *
>         return sysfs_emit(buffer, "%s\n", acpi_gbl_trace_method_name);
>  }
>
> -static const struct kernel_param_ops param_ops_trace_method =3D {
> -       .set =3D param_set_trace_method_name,
> -       .get =3D param_get_trace_method_name,
> -};
> +static DEFINE_KERNEL_PARAM_OPS(param_ops_trace_method,
> +                              param_set_trace_method_name,
> +                              param_get_trace_method_name);
>
> -static const struct kernel_param_ops param_ops_trace_attrib =3D {
> -       .set =3D param_set_uint,
> -       .get =3D param_get_uint,
> -};
> +static DEFINE_KERNEL_PARAM_OPS(param_ops_trace_attrib, param_set_uint,
> +                              param_get_uint);
>
>  module_param_cb(trace_method_name, &param_ops_trace_method, &trace_metho=
d_name, 0644);
>  module_param_cb(trace_debug_layer, &param_ops_trace_attrib, &acpi_gbl_tr=
ace_dbg_layer, 0644);
> diff --git a/drivers/block/loop.c b/drivers/block/loop.c
> index 0000913f7efc..147ad561e584 100644
> --- a/drivers/block/loop.c
> +++ b/drivers/block/loop.c
> @@ -1806,10 +1806,8 @@ static int max_loop_param_set_int(const char *val,
>         return 0;
>  }
>
> -static const struct kernel_param_ops max_loop_param_ops =3D {
> -       .set =3D max_loop_param_set_int,
> -       .get =3D param_get_int,
> -};
> +static DEFINE_KERNEL_PARAM_OPS(max_loop_param_ops, max_loop_param_set_in=
t,
> +                              param_get_int);
>
>  module_param_cb(max_loop, &max_loop_param_ops, &max_loop, 0444);
>  MODULE_PARM_DESC(max_loop, "Maximum number of loop devices");
> @@ -1836,10 +1834,8 @@ static int loop_set_hw_queue_depth(const char *s, =
const struct kernel_param *p)
>         return 0;
>  }
>
> -static const struct kernel_param_ops loop_hw_qdepth_param_ops =3D {
> -       .set    =3D loop_set_hw_queue_depth,
> -       .get    =3D param_get_int,
> -};
> +static DEFINE_KERNEL_PARAM_OPS(loop_hw_qdepth_param_ops,
> +                              loop_set_hw_queue_depth, param_get_int);
>
>  device_param_cb(hw_queue_depth, &loop_hw_qdepth_param_ops, &hw_queue_dep=
th, 0444);
>  MODULE_PARM_DESC(hw_queue_depth, "Queue depth for each hardware queue. D=
efault: " __stringify(LOOP_DEFAULT_HW_Q_DEPTH));
> diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.=
c
> index f8c0fd57e041..332ad6ac838a 100644
> --- a/drivers/block/null_blk/main.c
> +++ b/drivers/block/null_blk/main.c
> @@ -149,10 +149,8 @@ static int null_set_queue_mode(const char *str, cons=
t struct kernel_param *kp)
>         return null_param_store_val(str, &g_queue_mode, NULL_Q_BIO, NULL_=
Q_MQ);
>  }
>
> -static const struct kernel_param_ops null_queue_mode_param_ops =3D {
> -       .set    =3D null_set_queue_mode,
> -       .get    =3D param_get_int,
> -};
> +static DEFINE_KERNEL_PARAM_OPS(null_queue_mode_param_ops, null_set_queue=
_mode,
> +                              param_get_int);
>
>  device_param_cb(queue_mode, &null_queue_mode_param_ops, &g_queue_mode, 0=
444);
>  MODULE_PARM_DESC(queue_mode, "Block interface to use (0=3Dbio,1=3Drq,2=
=3Dmultiqueue)");
> @@ -193,10 +191,8 @@ static int null_set_irqmode(const char *str, const s=
truct kernel_param *kp)
>                                         NULL_IRQ_TIMER);
>  }
>
> -static const struct kernel_param_ops null_irqmode_param_ops =3D {
> -       .set    =3D null_set_irqmode,
> -       .get    =3D param_get_int,
> -};
> +static DEFINE_KERNEL_PARAM_OPS(null_irqmode_param_ops, null_set_irqmode,
> +                              param_get_int);
>
>  device_param_cb(irqmode, &null_irqmode_param_ops, &g_irqmode, 0444);
>  MODULE_PARM_DESC(irqmode, "IRQ completion handler. 0-none, 1-softirq, 2-=
timer");
> diff --git a/drivers/block/rnbd/rnbd-srv.c b/drivers/block/rnbd/rnbd-srv.=
c
> index 10e8c438bb43..81961f7c883a 100644
> --- a/drivers/block/rnbd/rnbd-srv.c
> +++ b/drivers/block/rnbd/rnbd-srv.c
> @@ -49,10 +49,8 @@ static struct kparam_string dev_search_path_kparam_str=
 =3D {
>         .string =3D dev_search_path
>  };
>
> -static const struct kernel_param_ops dev_search_path_ops =3D {
> -       .set    =3D dev_search_path_set,
> -       .get    =3D param_get_string,
> -};
> +static DEFINE_KERNEL_PARAM_OPS(dev_search_path_ops, dev_search_path_set,
> +                              param_get_string);
>
>  module_param_cb(dev_search_path, &dev_search_path_ops,
>                 &dev_search_path_kparam_str, 0444);
> diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> index 8e5f3738c203..f7bf7ea2d088 100644
> --- a/drivers/block/ublk_drv.c
> +++ b/drivers/block/ublk_drv.c
> @@ -5874,10 +5874,9 @@ static int ublk_get_max_unprivileged_ublks(char *b=
uf,
>         return sysfs_emit(buf, "%u\n", unprivileged_ublks_max);
>  }
>
> -static const struct kernel_param_ops ublk_max_unprivileged_ublks_ops =3D=
 {
> -       .set =3D ublk_set_max_unprivileged_ublks,
> -       .get =3D ublk_get_max_unprivileged_ublks,
> -};
> +static DEFINE_KERNEL_PARAM_OPS(ublk_max_unprivileged_ublks_ops,
> +                              ublk_set_max_unprivileged_ublks,
> +                              ublk_get_max_unprivileged_ublks);
>
>  module_param_cb(ublks_max, &ublk_max_unprivileged_ublks_ops,
>                 &unprivileged_ublks_max, 0644);
> diff --git a/drivers/char/ipmi/ipmi_msghandler.c b/drivers/char/ipmi/ipmi=
_msghandler.c
> index 869ac87a4b6a..b5fed11707e8 100644
> --- a/drivers/char/ipmi/ipmi_msghandler.c
> +++ b/drivers/char/ipmi/ipmi_msghandler.c
> @@ -102,10 +102,8 @@ static int panic_op_read_handler(char *buffer, const=
 struct kernel_param *kp)
>         return sprintf(buffer, "%s\n", event_str);
>  }
>
> -static const struct kernel_param_ops panic_op_ops =3D {
> -       .set =3D panic_op_write_handler,
> -       .get =3D panic_op_read_handler
> -};
> +static DEFINE_KERNEL_PARAM_OPS(panic_op_ops, panic_op_write_handler,
> +                              panic_op_read_handler);
>  module_param_cb(panic_op, &panic_op_ops, NULL, 0600);
>  MODULE_PARM_DESC(panic_op, "Sets if the IPMI driver will attempt to stor=
e panic information in the event log in the event of a panic.  Set to 'none=
' for no, 'event' for a single event, or 'string' for a generic event and t=
he panic string in IPMI OEM events.");
>
> diff --git a/drivers/char/ipmi/ipmi_watchdog.c b/drivers/char/ipmi/ipmi_w=
atchdog.c
> index a013ddbf1466..91a99417d204 100644
> --- a/drivers/char/ipmi/ipmi_watchdog.c
> +++ b/drivers/char/ipmi/ipmi_watchdog.c
> @@ -193,10 +193,8 @@ static int set_param_timeout(const char *val, const =
struct kernel_param *kp)
>         return rv;
>  }
>
> -static const struct kernel_param_ops param_ops_timeout =3D {
> -       .set =3D set_param_timeout,
> -       .get =3D param_get_int,
> -};
> +static DEFINE_KERNEL_PARAM_OPS(param_ops_timeout, set_param_timeout,
> +                              param_get_int);
>  #define param_check_timeout param_check_int
>
>  typedef int (*action_fn)(const char *intval, char *outval);
> @@ -259,17 +257,12 @@ static int set_param_wdog_ifnum(const char *val, co=
nst struct kernel_param *kp)
>         return 0;
>  }
>
> -static const struct kernel_param_ops param_ops_wdog_ifnum =3D {
> -       .set =3D set_param_wdog_ifnum,
> -       .get =3D param_get_int,
> -};
> +static DEFINE_KERNEL_PARAM_OPS(param_ops_wdog_ifnum, set_param_wdog_ifnu=
m,
> +                              param_get_int);
>
>  #define param_check_wdog_ifnum param_check_int
>
> -static const struct kernel_param_ops param_ops_str =3D {
> -       .set =3D set_param_str,
> -       .get =3D get_param_str,
> -};
> +static DEFINE_KERNEL_PARAM_OPS(param_ops_str, set_param_str, get_param_s=
tr);
>
>  module_param(ifnum_to_use, wdog_ifnum, 0644);
>  MODULE_PARM_DESC(ifnum_to_use, "The interface number to use for the watc=
hdog "
> diff --git a/drivers/crypto/hisilicon/hpre/hpre_main.c b/drivers/crypto/h=
isilicon/hpre/hpre_main.c
> index 357ab5e5887e..1104184c2f63 100644
> --- a/drivers/crypto/hisilicon/hpre/hpre_main.c
> +++ b/drivers/crypto/hisilicon/hpre/hpre_main.c
> @@ -420,10 +420,8 @@ static int hpre_cluster_regs_show(struct seq_file *s=
, void *unused)
>
>  DEFINE_SHOW_ATTRIBUTE(hpre_cluster_regs);
>
> -static const struct kernel_param_ops hpre_uacce_mode_ops =3D {
> -       .set =3D uacce_mode_set,
> -       .get =3D param_get_int,
> -};
> +static DEFINE_KERNEL_PARAM_OPS(hpre_uacce_mode_ops, uacce_mode_set,
> +                              param_get_int);
>
>  /*
>   * uacce_mode =3D 0 means hpre only register to crypto,
> @@ -441,19 +439,13 @@ static int pf_q_num_set(const char *val, const stru=
ct kernel_param *kp)
>         return hisi_qm_q_num_set(val, kp, PCI_DEVICE_ID_HUAWEI_HPRE_PF);
>  }
>
> -static const struct kernel_param_ops hpre_pf_q_num_ops =3D {
> -       .set =3D pf_q_num_set,
> -       .get =3D param_get_int,
> -};
> +static DEFINE_KERNEL_PARAM_OPS(hpre_pf_q_num_ops, pf_q_num_set, param_ge=
t_int);
>
>  static u32 pf_q_num =3D HPRE_PF_DEF_Q_NUM;
>  module_param_cb(pf_q_num, &hpre_pf_q_num_ops, &pf_q_num, 0444);
>  MODULE_PARM_DESC(pf_q_num, "Number of queues in PF of CS(2-1024)");
>
> -static const struct kernel_param_ops vfs_num_ops =3D {
> -       .set =3D vfs_num_set,
> -       .get =3D param_get_int,
> -};
> +static DEFINE_KERNEL_PARAM_OPS(vfs_num_ops, vfs_num_set, param_get_int);
>
>  static u32 vfs_num;
>  module_param_cb(vfs_num, &vfs_num_ops, &vfs_num, 0444);
> diff --git a/drivers/crypto/hisilicon/sec2/sec_main.c b/drivers/crypto/hi=
silicon/sec2/sec_main.c
> index 056bd8f4da5a..3d13f2faa3d0 100644
> --- a/drivers/crypto/hisilicon/sec2/sec_main.c
> +++ b/drivers/crypto/hisilicon/sec2/sec_main.c
> @@ -362,10 +362,8 @@ static int sec_pf_q_num_set(const char *val, const s=
truct kernel_param *kp)
>         return hisi_qm_q_num_set(val, kp, PCI_DEVICE_ID_HUAWEI_SEC_PF);
>  }
>
> -static const struct kernel_param_ops sec_pf_q_num_ops =3D {
> -       .set =3D sec_pf_q_num_set,
> -       .get =3D param_get_int,
> -};
> +static DEFINE_KERNEL_PARAM_OPS(sec_pf_q_num_ops, sec_pf_q_num_set,
> +                              param_get_int);
>
>  static u32 pf_q_num =3D SEC_PF_DEF_Q_NUM;
>  module_param_cb(pf_q_num, &sec_pf_q_num_ops, &pf_q_num, 0444);
> @@ -391,18 +389,13 @@ static int sec_ctx_q_num_set(const char *val, const=
 struct kernel_param *kp)
>         return param_set_int(val, kp);
>  }
>
> -static const struct kernel_param_ops sec_ctx_q_num_ops =3D {
> -       .set =3D sec_ctx_q_num_set,
> -       .get =3D param_get_int,
> -};
> +static DEFINE_KERNEL_PARAM_OPS(sec_ctx_q_num_ops, sec_ctx_q_num_set,
> +                              param_get_int);
>  static u32 ctx_q_num =3D SEC_CTX_Q_NUM_DEF;
>  module_param_cb(ctx_q_num, &sec_ctx_q_num_ops, &ctx_q_num, 0444);
>  MODULE_PARM_DESC(ctx_q_num, "Queue num in ctx (2 default, 2, 4, ..., 32)=
");
>
> -static const struct kernel_param_ops vfs_num_ops =3D {
> -       .set =3D vfs_num_set,
> -       .get =3D param_get_int,
> -};
> +static DEFINE_KERNEL_PARAM_OPS(vfs_num_ops, vfs_num_set, param_get_int);
>
>  static u32 vfs_num;
>  module_param_cb(vfs_num, &vfs_num_ops, &vfs_num, 0444);
> @@ -454,10 +447,8 @@ u64 sec_get_alg_bitmap(struct hisi_qm *qm, u32 high,=
 u32 low)
>         return ((u64)cap_val_h << SEC_ALG_BITMAP_SHIFT) | (u64)cap_val_l;
>  }
>
> -static const struct kernel_param_ops sec_uacce_mode_ops =3D {
> -       .set =3D uacce_mode_set,
> -       .get =3D param_get_int,
> -};
> +static DEFINE_KERNEL_PARAM_OPS(sec_uacce_mode_ops, uacce_mode_set,
> +                              param_get_int);
>
>  /*
>   * uacce_mode =3D 0 means sec only register to crypto,
> diff --git a/drivers/crypto/hisilicon/zip/zip_crypto.c b/drivers/crypto/h=
isilicon/zip/zip_crypto.c
> index 70adde049b53..8f8d57420fb4 100644
> --- a/drivers/crypto/hisilicon/zip/zip_crypto.c
> +++ b/drivers/crypto/hisilicon/zip/zip_crypto.c
> @@ -108,10 +108,7 @@ static int sgl_sge_nr_set(const char *val, const str=
uct kernel_param *kp)
>         return param_set_ushort(val, kp);
>  }
>
> -static const struct kernel_param_ops sgl_sge_nr_ops =3D {
> -       .set =3D sgl_sge_nr_set,
> -       .get =3D param_get_ushort,
> -};
> +static DEFINE_KERNEL_PARAM_OPS(sgl_sge_nr_ops, sgl_sge_nr_set, param_get=
_ushort);
>
>  static u16 sgl_sge_nr =3D HZIP_SGL_SGE_NR;
>  module_param_cb(sgl_sge_nr, &sgl_sge_nr_ops, &sgl_sge_nr, 0444);
> diff --git a/drivers/crypto/hisilicon/zip/zip_main.c b/drivers/crypto/his=
ilicon/zip/zip_main.c
> index 44df9c859bd8..e07d0cf8eca8 100644
> --- a/drivers/crypto/hisilicon/zip/zip_main.c
> +++ b/drivers/crypto/hisilicon/zip/zip_main.c
> @@ -394,10 +394,7 @@ static int perf_mode_set(const char *val, const stru=
ct kernel_param *kp)
>         return param_set_int(val, kp);
>  }
>
> -static const struct kernel_param_ops zip_com_perf_ops =3D {
> -       .set =3D perf_mode_set,
> -       .get =3D param_get_int,
> -};
> +static DEFINE_KERNEL_PARAM_OPS(zip_com_perf_ops, perf_mode_set, param_ge=
t_int);
>
>  /*
>   * perf_mode =3D 0 means enable high compression rate mode,
> @@ -408,10 +405,8 @@ static u32 perf_mode =3D HZIP_HIGH_COMP_RATE;
>  module_param_cb(perf_mode, &zip_com_perf_ops, &perf_mode, 0444);
>  MODULE_PARM_DESC(perf_mode, "ZIP high perf mode 0(default), 1(enable)");
>
> -static const struct kernel_param_ops zip_uacce_mode_ops =3D {
> -       .set =3D uacce_mode_set,
> -       .get =3D param_get_int,
> -};
> +static DEFINE_KERNEL_PARAM_OPS(zip_uacce_mode_ops, uacce_mode_set,
> +                              param_get_int);
>
>  /*
>   * uacce_mode =3D 0 means zip only register to crypto,
> @@ -429,19 +424,13 @@ static int pf_q_num_set(const char *val, const stru=
ct kernel_param *kp)
>         return hisi_qm_q_num_set(val, kp, PCI_DEVICE_ID_HUAWEI_ZIP_PF);
>  }
>
> -static const struct kernel_param_ops pf_q_num_ops =3D {
> -       .set =3D pf_q_num_set,
> -       .get =3D param_get_int,
> -};
> +static DEFINE_KERNEL_PARAM_OPS(pf_q_num_ops, pf_q_num_set, param_get_int=
);
>
>  static u32 pf_q_num =3D HZIP_PF_DEF_Q_NUM;
>  module_param_cb(pf_q_num, &pf_q_num_ops, &pf_q_num, 0444);
>  MODULE_PARM_DESC(pf_q_num, "Number of queues in PF(v1 2-4096, v2 2-1024)=
");
>
> -static const struct kernel_param_ops vfs_num_ops =3D {
> -       .set =3D vfs_num_set,
> -       .get =3D param_get_int,
> -};
> +static DEFINE_KERNEL_PARAM_OPS(vfs_num_ops, vfs_num_set, param_get_int);
>
>  static u32 vfs_num;
>  module_param_cb(vfs_num, &vfs_num_ops, &vfs_num, 0444);
> diff --git a/drivers/dma/dmatest.c b/drivers/dma/dmatest.c
> index df38681a1ff4..a7bddadcc52d 100644
> --- a/drivers/dma/dmatest.c
> +++ b/drivers/dma/dmatest.c
> @@ -154,20 +154,15 @@ static struct dmatest_info {
>
>  static int dmatest_run_set(const char *val, const struct kernel_param *k=
p);
>  static int dmatest_run_get(char *val, const struct kernel_param *kp);
> -static const struct kernel_param_ops run_ops =3D {
> -       .set =3D dmatest_run_set,
> -       .get =3D dmatest_run_get,
> -};
> +static DEFINE_KERNEL_PARAM_OPS(run_ops, dmatest_run_set, dmatest_run_get=
);
>  static bool dmatest_run;
>  module_param_cb(run, &run_ops, &dmatest_run, 0644);
>  MODULE_PARM_DESC(run, "Run the test (default: false)");
>
>  static int dmatest_chan_set(const char *val, const struct kernel_param *=
kp);
>  static int dmatest_chan_get(char *val, const struct kernel_param *kp);
> -static const struct kernel_param_ops multi_chan_ops =3D {
> -       .set =3D dmatest_chan_set,
> -       .get =3D dmatest_chan_get,
> -};
> +static DEFINE_KERNEL_PARAM_OPS(multi_chan_ops, dmatest_chan_set,
> +                              dmatest_chan_get);
>
>  static char test_channel[20];
>  static struct kparam_string newchan_kps =3D {
> @@ -178,9 +173,7 @@ module_param_cb(channel, &multi_chan_ops, &newchan_kp=
s, 0644);
>  MODULE_PARM_DESC(channel, "Bus ID of the channel to test (default: any)"=
);
>
>  static int dmatest_test_list_get(char *val, const struct kernel_param *k=
p);
> -static const struct kernel_param_ops test_list_ops =3D {
> -       .get =3D dmatest_test_list_get,
> -};
> +static DEFINE_KERNEL_PARAM_OPS(test_list_ops, NULL, dmatest_test_list_ge=
t);
>  module_param_cb(test_list, &test_list_ops, NULL, 0444);
>  MODULE_PARM_DESC(test_list, "Print current test list");
>
> @@ -292,10 +285,7 @@ static int dmatest_wait_get(char *val, const struct =
kernel_param *kp)
>         return param_get_bool(val, kp);
>  }
>
> -static const struct kernel_param_ops wait_ops =3D {
> -       .get =3D dmatest_wait_get,
> -       .set =3D param_set_bool,
> -};
> +static DEFINE_KERNEL_PARAM_OPS(wait_ops, param_set_bool, dmatest_wait_ge=
t);
>  module_param_cb(wait, &wait_ops, &wait, 0444);
>  MODULE_PARM_DESC(wait, "Wait for tests to complete (default: false)");
>
> diff --git a/drivers/edac/i10nm_base.c b/drivers/edac/i10nm_base.c
> index 63df35444214..ab05e58faaa8 100644
> --- a/drivers/edac/i10nm_base.c
> +++ b/drivers/edac/i10nm_base.c
> @@ -1284,10 +1284,8 @@ static int set_decoding_via_mca(const char *buf, c=
onst struct kernel_param *kp)
>         return ret;
>  }
>
> -static const struct kernel_param_ops decoding_via_mca_param_ops =3D {
> -       .set =3D set_decoding_via_mca,
> -       .get =3D param_get_int,
> -};
> +static DEFINE_KERNEL_PARAM_OPS(decoding_via_mca_param_ops, set_decoding_=
via_mca,
> +                              param_get_int);
>
>  module_param_cb(decoding_via_mca, &decoding_via_mca_param_ops, &decoding=
_via_mca, 0644);
>  MODULE_PARM_DESC(decoding_via_mca, "decoding_via_mca: 0=3Doff(default), =
1=3Denable");
> diff --git a/drivers/firmware/efi/efi-pstore.c b/drivers/firmware/efi/efi=
-pstore.c
> index a253b6144945..fd0f3579fd54 100644
> --- a/drivers/firmware/efi/efi-pstore.c
> +++ b/drivers/firmware/efi/efi-pstore.c
> @@ -43,10 +43,8 @@ static int efi_pstore_disable_set(const char *val, con=
st struct kernel_param *kp
>         return 0;
>  }
>
> -static const struct kernel_param_ops pstore_disable_ops =3D {
> -       .set    =3D efi_pstore_disable_set,
> -       .get    =3D param_get_bool,
> -};
> +static DEFINE_KERNEL_PARAM_OPS(pstore_disable_ops, efi_pstore_disable_se=
t,
> +                              param_get_bool);
>
>  module_param_cb(pstore_disable, &pstore_disable_ops, &pstore_disable, 06=
44);
>  __MODULE_PARM_TYPE(pstore_disable, "bool");
> diff --git a/drivers/firmware/qcom/qcom_scm.c b/drivers/firmware/qcom/qco=
m_scm.c
> index 9b06a69d3a6d..ef57df53e087 100644
> --- a/drivers/firmware/qcom/qcom_scm.c
> +++ b/drivers/firmware/qcom/qcom_scm.c
> @@ -2725,10 +2725,8 @@ static int set_download_mode(const char *val, cons=
t struct kernel_param *kp)
>         return 0;
>  }
>
> -static const struct kernel_param_ops download_mode_param_ops =3D {
> -       .get =3D get_download_mode,
> -       .set =3D set_download_mode,
> -};
> +static DEFINE_KERNEL_PARAM_OPS(download_mode_param_ops, set_download_mod=
e,
> +                              get_download_mode);
>
>  module_param_cb(download_mode, &download_mode_param_ops, NULL, 0644);
>  MODULE_PARM_DESC(download_mode, "download mode: off/0/N for no dump mode=
, full/on/1/Y for full dump mode, mini for minidump mode and full,mini for =
both full and minidump mode together are acceptable values");
> diff --git a/drivers/firmware/qemu_fw_cfg.c b/drivers/firmware/qemu_fw_cf=
g.c
> index 87a5421bc7d5..c87a5449ba8c 100644
> --- a/drivers/firmware/qemu_fw_cfg.c
> +++ b/drivers/firmware/qemu_fw_cfg.c
> @@ -897,10 +897,8 @@ static int fw_cfg_cmdline_get(char *buf, const struc=
t kernel_param *kp)
>         return 0;
>  }
>
> -static const struct kernel_param_ops fw_cfg_cmdline_param_ops =3D {
> -       .set =3D fw_cfg_cmdline_set,
> -       .get =3D fw_cfg_cmdline_get,
> -};
> +static DEFINE_KERNEL_PARAM_OPS(fw_cfg_cmdline_param_ops, fw_cfg_cmdline_=
set,
> +                              fw_cfg_cmdline_get);
>
>  device_param_cb(ioport, &fw_cfg_cmdline_param_ops, NULL, S_IRUSR);
>  device_param_cb(mmio, &fw_cfg_cmdline_param_ops, NULL, S_IRUSR);
> diff --git a/drivers/gpu/drm/drm_panic.c b/drivers/gpu/drm/drm_panic.c
> index d6d3b8d85dea..c35d1adf2ce3 100644
> --- a/drivers/gpu/drm/drm_panic.c
> +++ b/drivers/gpu/drm/drm_panic.c
> @@ -847,10 +847,8 @@ static int drm_panic_type_get(char *buffer, const st=
ruct kernel_param *kp)
>                          drm_panic_type_map[drm_panic_type]);
>  }
>
> -static const struct kernel_param_ops drm_panic_ops =3D {
> -       .set =3D drm_panic_type_set,
> -       .get =3D drm_panic_type_get,
> -};
> +static DEFINE_KERNEL_PARAM_OPS(drm_panic_ops, drm_panic_type_set,
> +                              drm_panic_type_get);
>
>  module_param_cb(panic_screen, &drm_panic_ops, NULL, 0644);
>  MODULE_PARM_DESC(panic_screen,
> diff --git a/drivers/gpu/drm/i915/i915_mitigations.c b/drivers/gpu/drm/i9=
15/i915_mitigations.c
> index def7302ef7fe..6061eae84e9c 100644
> --- a/drivers/gpu/drm/i915/i915_mitigations.c
> +++ b/drivers/gpu/drm/i915/i915_mitigations.c
> @@ -124,10 +124,7 @@ static int mitigations_get(char *buffer, const struc=
t kernel_param *kp)
>         return count;
>  }
>
> -static const struct kernel_param_ops ops =3D {
> -       .set =3D mitigations_set,
> -       .get =3D mitigations_get,
> -};
> +static DEFINE_KERNEL_PARAM_OPS(ops, mitigations_set, mitigations_get);
>
>  module_param_cb_unsafe(mitigations, &ops, NULL, 0600);
>  MODULE_PARM_DESC(mitigations,
> diff --git a/drivers/gpu/drm/imagination/pvr_fw_trace.c b/drivers/gpu/drm=
/imagination/pvr_fw_trace.c
> index 6193811ef7be..2df7274e21a8 100644
> --- a/drivers/gpu/drm/imagination/pvr_fw_trace.c
> +++ b/drivers/gpu/drm/imagination/pvr_fw_trace.c
> @@ -71,10 +71,8 @@ pvr_fw_trace_init_mask_set(const char *val, const stru=
ct kernel_param *kp)
>         return 0;
>  }
>
> -const struct kernel_param_ops pvr_fw_trace_init_mask_ops =3D {
> -       .set =3D pvr_fw_trace_init_mask_set,
> -       .get =3D param_get_hexint,
> -};
> +DEFINE_KERNEL_PARAM_OPS(pvr_fw_trace_init_mask_ops, pvr_fw_trace_init_ma=
sk_set,
> +                       param_get_hexint);
>
>  param_check_hexint(init_fw_trace_mask, &pvr_fw_trace_init_mask);
>  module_param_cb(init_fw_trace_mask, &pvr_fw_trace_init_mask_ops, &pvr_fw=
_trace_init_mask, 0600);
> diff --git a/drivers/hid/hid-cougar.c b/drivers/hid/hid-cougar.c
> index ad027c45f162..271048bdf7fc 100644
> --- a/drivers/hid/hid-cougar.c
> +++ b/drivers/hid/hid-cougar.c
> @@ -314,10 +314,8 @@ static int cougar_param_set_g6_is_space(const char *=
val,
>         return 0;
>  }
>
> -static const struct kernel_param_ops cougar_g6_is_space_ops =3D {
> -       .set    =3D cougar_param_set_g6_is_space,
> -       .get    =3D param_get_bool,
> -};
> +static DEFINE_KERNEL_PARAM_OPS(cougar_g6_is_space_ops,
> +                              cougar_param_set_g6_is_space, param_get_bo=
ol);
>  module_param_cb(g6_is_space, &cougar_g6_is_space_ops, &g6_is_space, 0644=
);
>
>  static const struct hid_device_id cougar_id_table[] =3D {
> diff --git a/drivers/hid/hid-steam.c b/drivers/hid/hid-steam.c
> index 197126d6e081..962ed60492ea 100644
> --- a/drivers/hid/hid-steam.c
> +++ b/drivers/hid/hid-steam.c
> @@ -1840,10 +1840,8 @@ static int steam_param_set_lizard_mode(const char =
*val,
>         return 0;
>  }
>
> -static const struct kernel_param_ops steam_lizard_mode_ops =3D {
> -       .set    =3D steam_param_set_lizard_mode,
> -       .get    =3D param_get_bool,
> -};
> +static DEFINE_KERNEL_PARAM_OPS(steam_lizard_mode_ops,
> +                              steam_param_set_lizard_mode, param_get_boo=
l);
>
>  module_param_cb(lizard_mode, &steam_lizard_mode_ops, &lizard_mode, 0644)=
;
>  MODULE_PARM_DESC(lizard_mode,
> diff --git a/drivers/infiniband/hw/hfi1/driver.c b/drivers/infiniband/hw/=
hfi1/driver.c
> index c7259cc39013..5b9b0b38b419 100644
> --- a/drivers/infiniband/hw/hfi1/driver.c
> +++ b/drivers/infiniband/hw/hfi1/driver.c
> @@ -42,10 +42,7 @@ MODULE_PARM_DESC(cu, "Credit return units");
>  unsigned long hfi1_cap_mask =3D HFI1_CAP_MASK_DEFAULT;
>  static int hfi1_caps_set(const char *val, const struct kernel_param *kp)=
;
>  static int hfi1_caps_get(char *buffer, const struct kernel_param *kp);
> -static const struct kernel_param_ops cap_ops =3D {
> -       .set =3D hfi1_caps_set,
> -       .get =3D hfi1_caps_get
> -};
> +static DEFINE_KERNEL_PARAM_OPS(cap_ops, hfi1_caps_set, hfi1_caps_get);
>  module_param_cb(cap_mask, &cap_ops, &hfi1_cap_mask, S_IWUSR | S_IRUGO);
>  MODULE_PARM_DESC(cap_mask, "Bit mask of enabled/disabled HW features");
>
> diff --git a/drivers/infiniband/ulp/iser/iscsi_iser.c b/drivers/infiniban=
d/ulp/iser/iscsi_iser.c
> index 7df441685780..758e527ca7c4 100644
> --- a/drivers/infiniband/ulp/iser/iscsi_iser.c
> +++ b/drivers/infiniband/ulp/iser/iscsi_iser.c
> @@ -90,10 +90,8 @@ module_param_named(debug_level, iser_debug_level, int,=
 S_IRUGO | S_IWUSR);
>  MODULE_PARM_DESC(debug_level, "Enable debug tracing if > 0 (default:disa=
bled)");
>
>  static int iscsi_iser_set(const char *val, const struct kernel_param *kp=
);
> -static const struct kernel_param_ops iscsi_iser_size_ops =3D {
> -       .set =3D iscsi_iser_set,
> -       .get =3D param_get_uint,
> -};
> +static DEFINE_KERNEL_PARAM_OPS(iscsi_iser_size_ops, iscsi_iser_set,
> +                              param_get_uint);
>
>  static unsigned int iscsi_max_lun =3D 512;
>  module_param_cb(max_lun, &iscsi_iser_size_ops, &iscsi_max_lun, S_IRUGO);
> diff --git a/drivers/infiniband/ulp/isert/ib_isert.c b/drivers/infiniband=
/ulp/isert/ib_isert.c
> index 348005e71891..bd91900a0ebf 100644
> --- a/drivers/infiniband/ulp/isert/ib_isert.c
> +++ b/drivers/infiniband/ulp/isert/ib_isert.c
> @@ -30,10 +30,8 @@ MODULE_PARM_DESC(debug_level, "Enable debug tracing if=
 > 0 (default:0)");
>
>  static int isert_sg_tablesize_set(const char *val,
>                                   const struct kernel_param *kp);
> -static const struct kernel_param_ops sg_tablesize_ops =3D {
> -       .set =3D isert_sg_tablesize_set,
> -       .get =3D param_get_int,
> -};
> +static DEFINE_KERNEL_PARAM_OPS(sg_tablesize_ops, isert_sg_tablesize_set,
> +                              param_get_int);
>
>  static int isert_sg_tablesize =3D ISCSI_ISER_MIN_SG_TABLESIZE;
>  module_param_cb(sg_tablesize, &sg_tablesize_ops, &isert_sg_tablesize, 06=
44);
> diff --git a/drivers/infiniband/ulp/srp/ib_srp.c b/drivers/infiniband/ulp=
/srp/ib_srp.c
> index b58868e1cf11..a81515f52a4f 100644
> --- a/drivers/infiniband/ulp/srp/ib_srp.c
> +++ b/drivers/infiniband/ulp/srp/ib_srp.c
> @@ -195,10 +195,7 @@ static int srp_tmo_set(const char *val, const struct=
 kernel_param *kp)
>         return res;
>  }
>
> -static const struct kernel_param_ops srp_tmo_ops =3D {
> -       .get =3D srp_tmo_get,
> -       .set =3D srp_tmo_set,
> -};
> +static DEFINE_KERNEL_PARAM_OPS(srp_tmo_ops, srp_tmo_set, srp_tmo_get);
>
>  static inline struct srp_target_port *host_to_target(struct Scsi_Host *h=
ost)
>  {
> diff --git a/drivers/input/misc/ati_remote2.c b/drivers/input/misc/ati_re=
mote2.c
> index 8db2dca84975..8b4ef7e163d3 100644
> --- a/drivers/input/misc/ati_remote2.c
> +++ b/drivers/input/misc/ati_remote2.c
> @@ -89,19 +89,16 @@ static int ati_remote2_get_mode_mask(char *buffer,
>
>  static unsigned int channel_mask =3D ATI_REMOTE2_MAX_CHANNEL_MASK;
>  #define param_check_channel_mask(name, p) __param_check(name, p, unsigne=
d int)
> -static const struct kernel_param_ops param_ops_channel_mask =3D {
> -       .set =3D ati_remote2_set_channel_mask,
> -       .get =3D ati_remote2_get_channel_mask,
> -};
> +static DEFINE_KERNEL_PARAM_OPS(param_ops_channel_mask,
> +                              ati_remote2_set_channel_mask,
> +                              ati_remote2_get_channel_mask);
>  module_param(channel_mask, channel_mask, 0644);
>  MODULE_PARM_DESC(channel_mask, "Bitmask of channels to accept <15:Channe=
l16>...<1:Channel2><0:Channel1>");
>
>  static unsigned int mode_mask =3D ATI_REMOTE2_MAX_MODE_MASK;
>  #define param_check_mode_mask(name, p) __param_check(name, p, unsigned i=
nt)
> -static const struct kernel_param_ops param_ops_mode_mask =3D {
> -       .set =3D ati_remote2_set_mode_mask,
> -       .get =3D ati_remote2_get_mode_mask,
> -};
> +static DEFINE_KERNEL_PARAM_OPS(param_ops_mode_mask, ati_remote2_set_mode=
_mask,
> +                              ati_remote2_get_mode_mask);
>  module_param(mode_mask, mode_mask, 0644);
>  MODULE_PARM_DESC(mode_mask, "Bitmask of modes to accept <4:PC><3:AUX4><2=
:AUX3><1:AUX2><0:AUX1>");
>
> diff --git a/drivers/input/mouse/psmouse-base.c b/drivers/input/mouse/psm=
ouse-base.c
> index 6ab5f1d96eae..f9ebb1fd0b6f 100644
> --- a/drivers/input/mouse/psmouse-base.c
> +++ b/drivers/input/mouse/psmouse-base.c
> @@ -45,10 +45,8 @@ MODULE_LICENSE("GPL");
>  static unsigned int psmouse_max_proto =3D PSMOUSE_AUTO;
>  static int psmouse_set_maxproto(const char *val, const struct kernel_par=
am *);
>  static int psmouse_get_maxproto(char *buffer, const struct kernel_param =
*kp);
> -static const struct kernel_param_ops param_ops_proto_abbrev =3D {
> -       .set =3D psmouse_set_maxproto,
> -       .get =3D psmouse_get_maxproto,
> -};
> +static DEFINE_KERNEL_PARAM_OPS(param_ops_proto_abbrev, psmouse_set_maxpr=
oto,
> +                              psmouse_get_maxproto);
>  #define param_check_proto_abbrev(name, p)      __param_check(name, p, un=
signed int)
>  module_param_named(proto, psmouse_max_proto, proto_abbrev, 0644);
>  MODULE_PARM_DESC(proto, "Highest protocol extension to probe (bare, imps=
, exps, any). Useful for KVM switches.");
> diff --git a/drivers/media/usb/uvc/uvc_driver.c b/drivers/media/usb/uvc/u=
vc_driver.c
> index 31b4ac3b48c1..2338cab7fef9 100644
> --- a/drivers/media/usb/uvc/uvc_driver.c
> +++ b/drivers/media/usb/uvc/uvc_driver.c
> @@ -2488,10 +2488,8 @@ static int param_set_nodrop(const char *val, const=
 struct kernel_param *kp)
>         return param_set_bool(val, kp);
>  }
>
> -static const struct kernel_param_ops param_ops_nodrop =3D {
> -       .set =3D param_set_nodrop,
> -       .get =3D param_get_uint,
> -};
> +static DEFINE_KERNEL_PARAM_OPS(param_ops_nodrop, param_set_nodrop,
> +                              param_get_uint);
>
>  param_check_uint(nodrop, &uvc_no_drop_param);
>  module_param_cb(nodrop, &param_ops_nodrop, &uvc_no_drop_param, 0644);
> diff --git a/drivers/misc/lis3lv02d/lis3lv02d.c b/drivers/misc/lis3lv02d/=
lis3lv02d.c
> index 21e8ad0a7444..6e40c14be51e 100644
> --- a/drivers/misc/lis3lv02d/lis3lv02d.c
> +++ b/drivers/misc/lis3lv02d/lis3lv02d.c
> @@ -103,10 +103,7 @@ static int param_set_axis(const char *val, const str=
uct kernel_param *kp)
>         return ret;
>  }
>
> -static const struct kernel_param_ops param_ops_axis =3D {
> -       .set =3D param_set_axis,
> -       .get =3D param_get_int,
> -};
> +static DEFINE_KERNEL_PARAM_OPS(param_ops_axis, param_set_axis, param_get=
_int);
>
>  #define param_check_axis(name, p) param_check_int(name, p)
>
> diff --git a/drivers/net/wireless/ath/wil6210/main.c b/drivers/net/wirele=
ss/ath/wil6210/main.c
> index d5aec72ecdce..e566d94d5f5c 100644
> --- a/drivers/net/wireless/ath/wil6210/main.c
> +++ b/drivers/net/wireless/ath/wil6210/main.c
> @@ -62,10 +62,7 @@ static int mtu_max_set(const char *val, const struct k=
ernel_param *kp)
>         return ret;
>  }
>
> -static const struct kernel_param_ops mtu_max_ops =3D {
> -       .set =3D mtu_max_set,
> -       .get =3D param_get_uint,
> -};
> +static DEFINE_KERNEL_PARAM_OPS(mtu_max_ops, mtu_max_set, param_get_uint)=
;
>
>  module_param_cb(mtu_max, &mtu_max_ops, &mtu_max, 0444);
>  MODULE_PARM_DESC(mtu_max, " Max MTU value.");
> @@ -91,10 +88,7 @@ static int ring_order_set(const char *val, const struc=
t kernel_param *kp)
>         return 0;
>  }
>
> -static const struct kernel_param_ops ring_order_ops =3D {
> -       .set =3D ring_order_set,
> -       .get =3D param_get_uint,
> -};
> +static DEFINE_KERNEL_PARAM_OPS(ring_order_ops, ring_order_set, param_get=
_uint);
>
>  module_param_cb(rx_ring_order, &ring_order_ops, &rx_ring_order, 0444);
>  MODULE_PARM_DESC(rx_ring_order, " Rx ring order; size =3D 1 << order");
> diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.=
c
> index 263161cb8ac0..f7362377e427 100644
> --- a/drivers/nvme/host/multipath.c
> +++ b/drivers/nvme/host/multipath.c
> @@ -30,10 +30,8 @@ static int multipath_param_set(const char *val, const =
struct kernel_param *kp)
>         return 0;
>  }
>
> -static const struct kernel_param_ops multipath_param_ops =3D {
> -       .set =3D multipath_param_set,
> -       .get =3D param_get_bool,
> -};
> +static DEFINE_KERNEL_PARAM_OPS(multipath_param_ops, multipath_param_set,
> +                              param_get_bool);
>
>  module_param_cb(multipath, &multipath_param_ops, &multipath, 0444);
>  MODULE_PARM_DESC(multipath,
> @@ -55,10 +53,8 @@ static int multipath_always_on_set(const char *val,
>         return 0;
>  }
>
> -static const struct kernel_param_ops multipath_always_on_ops =3D {
> -       .set =3D multipath_always_on_set,
> -       .get =3D param_get_bool,
> -};
> +static DEFINE_KERNEL_PARAM_OPS(multipath_always_on_ops, multipath_always=
_on_set,
> +                              param_get_bool);
>
>  module_param_cb(multipath_always_on, &multipath_always_on_ops,
>                 &multipath_always_on, 0444);
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index 9fd04cd7c5cb..c77e9b848d03 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -100,10 +100,8 @@ MODULE_PARM_DESC(sgl_threshold,
>  #define NVME_PCI_MIN_QUEUE_SIZE 2
>  #define NVME_PCI_MAX_QUEUE_SIZE 4095
>  static int io_queue_depth_set(const char *val, const struct kernel_param=
 *kp);
> -static const struct kernel_param_ops io_queue_depth_ops =3D {
> -       .set =3D io_queue_depth_set,
> -       .get =3D param_get_uint,
> -};
> +static DEFINE_KERNEL_PARAM_OPS(io_queue_depth_ops, io_queue_depth_set,
> +                              param_get_uint);
>
>  static unsigned int io_queue_depth =3D 1024;
>  module_param_cb(io_queue_depth, &io_queue_depth_ops, &io_queue_depth, 06=
44);
> @@ -232,10 +230,8 @@ static int quirks_param_set(const char *value, const=
 struct kernel_param *kp)
>  }
>
>  static char quirks_param[128];
> -static const struct kernel_param_ops quirks_param_ops =3D {
> -       .set =3D quirks_param_set,
> -       .get =3D param_get_string,
> -};
> +static DEFINE_KERNEL_PARAM_OPS(quirks_param_ops, quirks_param_set,
> +                              param_get_string);
>
>  static struct kparam_string quirks_param_string =3D {
>         .maxlen =3D sizeof(quirks_param),
> @@ -257,10 +253,8 @@ static int io_queue_count_set(const char *val, const=
 struct kernel_param *kp)
>         return param_set_uint(val, kp);
>  }
>
> -static const struct kernel_param_ops io_queue_count_ops =3D {
> -       .set =3D io_queue_count_set,
> -       .get =3D param_get_uint,
> -};
> +static DEFINE_KERNEL_PARAM_OPS(io_queue_count_ops, io_queue_count_set,
> +                              param_get_uint);
>
>  static unsigned int write_queues;
>  module_param_cb(write_queues, &io_queue_count_ops, &write_queues, 0644);
> diff --git a/drivers/nvme/target/rdma.c b/drivers/nvme/target/rdma.c
> index e6e2c3f9afdf..dc544813300f 100644
> --- a/drivers/nvme/target/rdma.c
> +++ b/drivers/nvme/target/rdma.c
> @@ -147,10 +147,7 @@ module_param_named(use_srq, nvmet_rdma_use_srq, bool=
, 0444);
>  MODULE_PARM_DESC(use_srq, "Use shared receive queue.");
>
>  static int srq_size_set(const char *val, const struct kernel_param *kp);
> -static const struct kernel_param_ops srq_size_ops =3D {
> -       .set =3D srq_size_set,
> -       .get =3D param_get_int,
> -};
> +static DEFINE_KERNEL_PARAM_OPS(srq_size_ops, srq_size_set, param_get_int=
);
>
>  static int nvmet_rdma_srq_size =3D 1024;
>  module_param_cb(srq_size, &srq_size_ops, &nvmet_rdma_srq_size, 0644);
> diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
> index 164a564ba3b4..2f336cd7e559 100644
> --- a/drivers/nvme/target/tcp.c
> +++ b/drivers/nvme/target/tcp.c
> @@ -46,10 +46,7 @@ static int set_params(const char *str, const struct ke=
rnel_param *kp)
>         return param_store_val(str, kp->arg, 0, INT_MAX);
>  }
>
> -static const struct kernel_param_ops set_param_ops =3D {
> -       .set    =3D set_params,
> -       .get    =3D param_get_int,
> -};
> +static DEFINE_KERNEL_PARAM_OPS(set_param_ops, set_params, param_get_int)=
;
>
>  /* Define the socket priority to use for connections were it is desirabl=
e
>   * that the NIC consider performing optimized packet processing or filte=
ring.
> diff --git a/drivers/platform/x86/acerhdf.c b/drivers/platform/x86/acerhd=
f.c
> index 5ce5ad3efe69..bd59c3f3f2c5 100644
> --- a/drivers/platform/x86/acerhdf.c
> +++ b/drivers/platform/x86/acerhdf.c
> @@ -762,10 +762,7 @@ static int interval_set_uint(const char *val, const =
struct kernel_param *kp)
>         return 0;
>  }
>
> -static const struct kernel_param_ops interval_ops =3D {
> -       .set =3D interval_set_uint,
> -       .get =3D param_get_uint,
> -};
> +static DEFINE_KERNEL_PARAM_OPS(interval_ops, interval_set_uint, param_ge=
t_uint);
>
>  module_param_cb(interval, &interval_ops, &interval, 0000);
>  MODULE_PARM_DESC(interval, "Polling interval of temperature check");
> diff --git a/drivers/power/supply/bq27xxx_battery.c b/drivers/power/suppl=
y/bq27xxx_battery.c
> index 45f0e39b8c2d..09829ee1a49d 100644
> --- a/drivers/power/supply/bq27xxx_battery.c
> +++ b/drivers/power/supply/bq27xxx_battery.c
> @@ -1133,10 +1133,8 @@ static int poll_interval_param_set(const char *val=
, const struct kernel_param *k
>         return ret;
>  }
>
> -static const struct kernel_param_ops param_ops_poll_interval =3D {
> -       .get =3D param_get_uint,
> -       .set =3D poll_interval_param_set,
> -};
> +static DEFINE_KERNEL_PARAM_OPS(param_ops_poll_interval, poll_interval_pa=
ram_set,
> +                              param_get_uint);
>
>  static unsigned int poll_interval =3D 360;
>  module_param_cb(poll_interval, &param_ops_poll_interval, &poll_interval,=
 0644);
> diff --git a/drivers/power/supply/test_power.c b/drivers/power/supply/tes=
t_power.c
> index 2c0e9ad820c0..0bf2bef3383a 100644
> --- a/drivers/power/supply/test_power.c
> +++ b/drivers/power/supply/test_power.c
> @@ -649,60 +649,47 @@ static int param_set_battery_extension(const char *=
key,
>
>  #define param_get_battery_extension param_get_bool
>
> -static const struct kernel_param_ops param_ops_ac_online =3D {
> -       .set =3D param_set_ac_online,
> -       .get =3D param_get_ac_online,
> -};
> +static DEFINE_KERNEL_PARAM_OPS(param_ops_ac_online, param_set_ac_online,
> +                              param_get_ac_online);
>
> -static const struct kernel_param_ops param_ops_usb_online =3D {
> -       .set =3D param_set_usb_online,
> -       .get =3D param_get_usb_online,
> -};
> +static DEFINE_KERNEL_PARAM_OPS(param_ops_usb_online, param_set_usb_onlin=
e,
> +                              param_get_usb_online);
>
> -static const struct kernel_param_ops param_ops_battery_status =3D {
> -       .set =3D param_set_battery_status,
> -       .get =3D param_get_battery_status,
> -};
> +static DEFINE_KERNEL_PARAM_OPS(param_ops_battery_status,
> +                              param_set_battery_status,
> +                              param_get_battery_status);
>
> -static const struct kernel_param_ops param_ops_battery_present =3D {
> -       .set =3D param_set_battery_present,
> -       .get =3D param_get_battery_present,
> -};
> +static DEFINE_KERNEL_PARAM_OPS(param_ops_battery_present,
> +                              param_set_battery_present,
> +                              param_get_battery_present);
>
> -static const struct kernel_param_ops param_ops_battery_technology =3D {
> -       .set =3D param_set_battery_technology,
> -       .get =3D param_get_battery_technology,
> -};
> +static DEFINE_KERNEL_PARAM_OPS(param_ops_battery_technology,
> +                              param_set_battery_technology,
> +                              param_get_battery_technology);
>
> -static const struct kernel_param_ops param_ops_battery_health =3D {
> -       .set =3D param_set_battery_health,
> -       .get =3D param_get_battery_health,
> -};
> +static DEFINE_KERNEL_PARAM_OPS(param_ops_battery_health,
> +                              param_set_battery_health,
> +                              param_get_battery_health);
>
> -static const struct kernel_param_ops param_ops_battery_capacity =3D {
> -       .set =3D param_set_battery_capacity,
> -       .get =3D param_get_battery_capacity,
> -};
> +static DEFINE_KERNEL_PARAM_OPS(param_ops_battery_capacity,
> +                              param_set_battery_capacity,
> +                              param_get_battery_capacity);
>
> -static const struct kernel_param_ops param_ops_battery_voltage =3D {
> -       .set =3D param_set_battery_voltage,
> -       .get =3D param_get_battery_voltage,
> -};
> +static DEFINE_KERNEL_PARAM_OPS(param_ops_battery_voltage,
> +                              param_set_battery_voltage,
> +                              param_get_battery_voltage);
>
> -static const struct kernel_param_ops param_ops_battery_charge_counter =
=3D {
> -       .set =3D param_set_battery_charge_counter,
> -       .get =3D param_get_battery_charge_counter,
> -};
> +static DEFINE_KERNEL_PARAM_OPS(param_ops_battery_charge_counter,
> +                              param_set_battery_charge_counter,
> +                              param_get_battery_charge_counter);
>
> -static const struct kernel_param_ops param_ops_battery_current =3D {
> -       .set =3D param_set_battery_current,
> -       .get =3D param_get_battery_current,
> -};
> +static DEFINE_KERNEL_PARAM_OPS(param_ops_battery_current,
> +                              param_set_battery_current,
> +                              param_get_battery_current);
>
> -static const struct kernel_param_ops param_ops_battery_extension =3D {
> -       .set =3D param_set_battery_extension,
> -       .get =3D param_get_battery_extension,
> -};
> +static DEFINE_KERNEL_PARAM_OPS(param_ops_battery_extension,
> +                              param_set_battery_extension,
> +                              param_get_battery_extension);
>
>  #define param_check_ac_online(name, p) __param_check(name, p, void);
>  #define param_check_usb_online(name, p) __param_check(name, p, void);
> diff --git a/drivers/scsi/sg.c b/drivers/scsi/sg.c
> index 2b4b2a1a8e44..c075b567f84e 100644
> --- a/drivers/scsi/sg.c
> +++ b/drivers/scsi/sg.c
> @@ -1644,10 +1644,8 @@ static int def_reserved_size_set(const char *val, =
const struct kernel_param *kp)
>         return 0;
>  }
>
> -static const struct kernel_param_ops def_reserved_size_ops =3D {
> -       .set    =3D def_reserved_size_set,
> -       .get    =3D param_get_int,
> -};
> +static DEFINE_KERNEL_PARAM_OPS(def_reserved_size_ops, def_reserved_size_=
set,
> +                              param_get_int);
>
>  module_param_cb(def_reserved_size, &def_reserved_size_ops, &def_reserved=
_size,
>                    S_IRUGO | S_IWUSR);
> diff --git a/drivers/target/target_core_user.c b/drivers/target/target_co=
re_user.c
> index edc2afd5f4ee..676a12b44e88 100644
> --- a/drivers/target/target_core_user.c
> +++ b/drivers/target/target_core_user.c
> @@ -255,10 +255,9 @@ static int tcmu_get_global_max_data_area(char *buffe=
r,
>         return sprintf(buffer, "%d\n", TCMU_PAGES_TO_MBS(tcmu_global_max_=
pages));
>  }
>
> -static const struct kernel_param_ops tcmu_global_max_data_area_op =3D {
> -       .set =3D tcmu_set_global_max_data_area,
> -       .get =3D tcmu_get_global_max_data_area,
> -};
> +static DEFINE_KERNEL_PARAM_OPS(tcmu_global_max_data_area_op,
> +                              tcmu_set_global_max_data_area,
> +                              tcmu_get_global_max_data_area);
>
>  module_param_cb(global_max_data_area_mb, &tcmu_global_max_data_area_op, =
NULL,
>                 S_IWUSR | S_IRUGO);
> @@ -292,10 +291,8 @@ static int tcmu_set_block_netlink(const char *str,
>         return 0;
>  }
>
> -static const struct kernel_param_ops tcmu_block_netlink_op =3D {
> -       .set =3D tcmu_set_block_netlink,
> -       .get =3D tcmu_get_block_netlink,
> -};
> +static DEFINE_KERNEL_PARAM_OPS(tcmu_block_netlink_op, tcmu_set_block_net=
link,
> +                              tcmu_get_block_netlink);
>
>  module_param_cb(block_netlink, &tcmu_block_netlink_op, NULL, S_IWUSR | S=
_IRUGO);
>  MODULE_PARM_DESC(block_netlink, "Block new netlink commands.");
> diff --git a/drivers/thermal/intel/int340x_thermal/processor_thermal_soc_=
slider.c b/drivers/thermal/intel/int340x_thermal/processor_thermal_soc_slid=
er.c
> index 91f291627132..68275c3f2c9b 100644
> --- a/drivers/thermal/intel/int340x_thermal/processor_thermal_soc_slider.=
c
> +++ b/drivers/thermal/intel/int340x_thermal/processor_thermal_soc_slider.=
c
> @@ -83,10 +83,8 @@ static int slider_def_balance_get(char *buf, const str=
uct kernel_param *kp)
>         return sysfs_emit(buf, "%02x\n", slider_values[SOC_POWER_SLIDER_B=
ALANCE]);
>  }
>
> -static const struct kernel_param_ops slider_def_balance_ops =3D {
> -       .set =3D slider_def_balance_set,
> -       .get =3D slider_def_balance_get,
> -};
> +static DEFINE_KERNEL_PARAM_OPS(slider_def_balance_ops, slider_def_balanc=
e_set,
> +                              slider_def_balance_get);
>
>  module_param_cb(slider_balance, &slider_def_balance_ops, NULL, 0644);
>  MODULE_PARM_DESC(slider_balance, "Set slider default value for balance")=
;
> @@ -117,10 +115,8 @@ static int slider_def_offset_get(char *buf, const st=
ruct kernel_param *kp)
>         return sysfs_emit(buf, "%02x\n", slider_offset);
>  }
>
> -static const struct kernel_param_ops slider_offset_ops =3D {
> -       .set =3D slider_def_offset_set,
> -       .get =3D slider_def_offset_get,
> -};
> +static DEFINE_KERNEL_PARAM_OPS(slider_offset_ops, slider_def_offset_set,
> +                              slider_def_offset_get);
>
>  /*
>   * To enhance power efficiency dynamically, the firmware can optionally
> diff --git a/drivers/thermal/intel/intel_powerclamp.c b/drivers/thermal/i=
ntel/intel_powerclamp.c
> index ccf380da12f2..98fbc6892714 100644
> --- a/drivers/thermal/intel/intel_powerclamp.c
> +++ b/drivers/thermal/intel/intel_powerclamp.c
> @@ -112,10 +112,7 @@ static int duration_get(char *buf, const struct kern=
el_param *kp)
>         return ret;
>  }
>
> -static const struct kernel_param_ops duration_ops =3D {
> -       .set =3D duration_set,
> -       .get =3D duration_get,
> -};
> +static DEFINE_KERNEL_PARAM_OPS(duration_ops, duration_set, duration_get)=
;
>
>  module_param_cb(duration, &duration_ops, NULL, 0644);
>  MODULE_PARM_DESC(duration, "forced idle time for each attempt in msec.")=
;
> @@ -203,10 +200,7 @@ static int cpumask_get(char *buf, const struct kerne=
l_param *kp)
>         return cpumap_print_to_pagebuf(false, buf, idle_injection_cpu_mas=
k);
>  }
>
> -static const struct kernel_param_ops cpumask_ops =3D {
> -       .set =3D cpumask_set,
> -       .get =3D cpumask_get,
> -};
> +static DEFINE_KERNEL_PARAM_OPS(cpumask_ops, cpumask_set, cpumask_get);
>
>  module_param_cb(cpumask, &cpumask_ops, NULL, 0644);
>  MODULE_PARM_DESC(cpumask, "Mask of CPUs to use for idle injection.");
> @@ -252,10 +246,7 @@ static int max_idle_set(const char *arg, const struc=
t kernel_param *kp)
>         return ret;
>  }
>
> -static const struct kernel_param_ops max_idle_ops =3D {
> -       .set =3D max_idle_set,
> -       .get =3D param_get_byte,
> -};
> +static DEFINE_KERNEL_PARAM_OPS(max_idle_ops, max_idle_set, param_get_byt=
e);
>
>  module_param_cb(max_idle, &max_idle_ops, &max_idle, 0644);
>  MODULE_PARM_DESC(max_idle, "maximum injected idle time to the total CPU =
time ratio in percent range:1-100");
> @@ -299,10 +290,7 @@ static int window_size_set(const char *arg, const st=
ruct kernel_param *kp)
>         return ret;
>  }
>
> -static const struct kernel_param_ops window_size_ops =3D {
> -       .set =3D window_size_set,
> -       .get =3D param_get_int,
> -};
> +static DEFINE_KERNEL_PARAM_OPS(window_size_ops, window_size_set, param_g=
et_int);
>
>  module_param_cb(window_size, &window_size_ops, &window_size, 0644);
>  MODULE_PARM_DESC(window_size, "sliding window in number of clamping cycl=
es\n"
> diff --git a/drivers/tty/hvc/hvc_iucv.c b/drivers/tty/hvc/hvc_iucv.c
> index 37db8a3e5158..29612a4a32cb 100644
> --- a/drivers/tty/hvc/hvc_iucv.c
> +++ b/drivers/tty/hvc/hvc_iucv.c
> @@ -1290,10 +1290,8 @@ static int param_get_vmidfilter(char *buffer, cons=
t struct kernel_param *kp)
>
>  #define param_check_vmidfilter(name, p) __param_check(name, p, void)
>
> -static const struct kernel_param_ops param_ops_vmidfilter =3D {
> -       .set =3D param_set_vmidfilter,
> -       .get =3D param_get_vmidfilter,
> -};
> +static DEFINE_KERNEL_PARAM_OPS(param_ops_vmidfilter, param_set_vmidfilte=
r,
> +                              param_get_vmidfilter);
>
>  /**
>   * hvc_iucv_init() - z/VM IUCV HVC device driver initialization
> diff --git a/drivers/tty/sysrq.c b/drivers/tty/sysrq.c
> index c2e4b31b699a..c6279c496279 100644
> --- a/drivers/tty/sysrq.c
> +++ b/drivers/tty/sysrq.c
> @@ -1074,10 +1074,8 @@ static int sysrq_reset_seq_param_set(const char *b=
uffer,
>         return 0;
>  }
>
> -static const struct kernel_param_ops param_ops_sysrq_reset_seq =3D {
> -       .get    =3D param_get_ushort,
> -       .set    =3D sysrq_reset_seq_param_set,
> -};
> +static DEFINE_KERNEL_PARAM_OPS(param_ops_sysrq_reset_seq,
> +                              sysrq_reset_seq_param_set, param_get_ushor=
t);
>
>  #define param_check_sysrq_reset_seq(name, p)   \
>         __param_check(name, p, unsigned short)
> diff --git a/drivers/ufs/core/ufs-fault-injection.c b/drivers/ufs/core/uf=
s-fault-injection.c
> index 55db38e75cc4..7d2873da7dc5 100644
> --- a/drivers/ufs/core/ufs-fault-injection.c
> +++ b/drivers/ufs/core/ufs-fault-injection.c
> @@ -11,10 +11,7 @@
>  static int ufs_fault_get(char *buffer, const struct kernel_param *kp);
>  static int ufs_fault_set(const char *val, const struct kernel_param *kp)=
;
>
> -static const struct kernel_param_ops ufs_fault_ops =3D {
> -       .get =3D ufs_fault_get,
> -       .set =3D ufs_fault_set,
> -};
> +static DEFINE_KERNEL_PARAM_OPS(ufs_fault_ops, ufs_fault_set, ufs_fault_g=
et);
>
>  enum { FAULT_INJ_STR_SIZE =3D 80 };
>
> diff --git a/drivers/ufs/core/ufs-mcq.c b/drivers/ufs/core/ufs-mcq.c
> index c1b1d67a1ddc..83100aad2a97 100644
> --- a/drivers/ufs/core/ufs-mcq.c
> +++ b/drivers/ufs/core/ufs-mcq.c
> @@ -43,10 +43,8 @@ static int rw_queue_count_set(const char *val, const s=
truct kernel_param *kp)
>                                      num_possible_cpus());
>  }
>
> -static const struct kernel_param_ops rw_queue_count_ops =3D {
> -       .set =3D rw_queue_count_set,
> -       .get =3D param_get_uint,
> -};
> +static DEFINE_KERNEL_PARAM_OPS(rw_queue_count_ops, rw_queue_count_set,
> +                              param_get_uint);
>
>  static unsigned int rw_queues;
>  module_param_cb(rw_queues, &rw_queue_count_ops, &rw_queues, 0644);
> @@ -59,10 +57,8 @@ static int read_queue_count_set(const char *val, const=
 struct kernel_param *kp)
>                                      num_possible_cpus());
>  }
>
> -static const struct kernel_param_ops read_queue_count_ops =3D {
> -       .set =3D read_queue_count_set,
> -       .get =3D param_get_uint,
> -};
> +static DEFINE_KERNEL_PARAM_OPS(read_queue_count_ops, read_queue_count_se=
t,
> +                              param_get_uint);
>
>  static unsigned int read_queues;
>  module_param_cb(read_queues, &read_queue_count_ops, &read_queues, 0644);
> @@ -75,10 +71,8 @@ static int poll_queue_count_set(const char *val, const=
 struct kernel_param *kp)
>                                      num_possible_cpus());
>  }
>
> -static const struct kernel_param_ops poll_queue_count_ops =3D {
> -       .set =3D poll_queue_count_set,
> -       .get =3D param_get_uint,
> -};
> +static DEFINE_KERNEL_PARAM_OPS(poll_queue_count_ops, poll_queue_count_se=
t,
> +                              param_get_uint);
>
>  static unsigned int poll_queues =3D 1;
>  module_param_cb(poll_queues, &poll_queue_count_ops, &poll_queues, 0644);
> diff --git a/drivers/ufs/core/ufs-txeq.c b/drivers/ufs/core/ufs-txeq.c
> index b2dc89124353..3bdd87b434ad 100644
> --- a/drivers/ufs/core/ufs-txeq.c
> +++ b/drivers/ufs/core/ufs-txeq.c
> @@ -23,10 +23,7 @@ static int txeq_gear_set(const char *val, const struct=
 kernel_param *kp)
>         return param_set_uint_minmax(val, kp, UFS_HS_G1, UFS_HS_GEAR_MAX)=
;
>  }
>
> -static const struct kernel_param_ops txeq_gear_ops =3D {
> -       .set =3D txeq_gear_set,
> -       .get =3D param_get_uint,
> -};
> +static DEFINE_KERNEL_PARAM_OPS(txeq_gear_ops, txeq_gear_set, param_get_u=
int);
>
>  static unsigned int adaptive_txeq_gear =3D UFS_HS_G6;
>  module_param_cb(adaptive_txeq_gear, &txeq_gear_ops, &adaptive_txeq_gear,=
 0644);
> diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
> index 4805e40ed4d7..4e930710d9a6 100644
> --- a/drivers/ufs/core/ufshcd.c
> +++ b/drivers/ufs/core/ufshcd.c
> @@ -128,10 +128,8 @@ static int uic_cmd_timeout_set(const char *val, cons=
t struct kernel_param *kp)
>                                      UIC_CMD_TIMEOUT_MAX);
>  }
>
> -static const struct kernel_param_ops uic_cmd_timeout_ops =3D {
> -       .set =3D uic_cmd_timeout_set,
> -       .get =3D param_get_uint,
> -};
> +static DEFINE_KERNEL_PARAM_OPS(uic_cmd_timeout_ops, uic_cmd_timeout_set,
> +                              param_get_uint);
>
>  module_param_cb(uic_cmd_timeout, &uic_cmd_timeout_ops, &uic_cmd_timeout,=
 0644);
>  MODULE_PARM_DESC(uic_cmd_timeout,
> @@ -145,10 +143,8 @@ static int dev_cmd_timeout_set(const char *val, cons=
t struct kernel_param *kp)
>                                      QUERY_REQ_TIMEOUT_MAX);
>  }
>
> -static const struct kernel_param_ops dev_cmd_timeout_ops =3D {
> -       .set =3D dev_cmd_timeout_set,
> -       .get =3D param_get_uint,
> -};
> +static DEFINE_KERNEL_PARAM_OPS(dev_cmd_timeout_ops, dev_cmd_timeout_set,
> +                              param_get_uint);
>
>  module_param_cb(dev_cmd_timeout, &dev_cmd_timeout_ops, &dev_cmd_timeout,=
 0644);
>  MODULE_PARM_DESC(dev_cmd_timeout,
> diff --git a/drivers/usb/core/quirks.c b/drivers/usb/core/quirks.c
> index 0ffdaefba508..d52ecc886925 100644
> --- a/drivers/usb/core/quirks.c
> +++ b/drivers/usb/core/quirks.c
> @@ -160,10 +160,8 @@ static int quirks_param_set(const char *value, const=
 struct kernel_param *kp)
>         return 0;
>  }
>
> -static const struct kernel_param_ops quirks_param_ops =3D {
> -       .set =3D quirks_param_set,
> -       .get =3D param_get_string,
> -};
> +static DEFINE_KERNEL_PARAM_OPS(quirks_param_ops, quirks_param_set,
> +                              param_get_string);
>
>  static struct kparam_string quirks_param_string =3D {
>         .maxlen =3D sizeof(quirks_param),
> diff --git a/drivers/usb/gadget/legacy/serial.c b/drivers/usb/gadget/lega=
cy/serial.c
> index 4974bee6049a..e34717e553da 100644
> --- a/drivers/usb/gadget/legacy/serial.c
> +++ b/drivers/usb/gadget/legacy/serial.c
> @@ -121,10 +121,7 @@ static int enable_set(const char *s, const struct ke=
rnel_param *kp)
>         return ret;
>  }
>
> -static const struct kernel_param_ops enable_ops =3D {
> -       .set =3D enable_set,
> -       .get =3D param_get_bool,
> -};
> +static DEFINE_KERNEL_PARAM_OPS(enable_ops, enable_set, param_get_bool);
>
>  module_param_cb(enable, &enable_ops, &enable, 0644);
>
> diff --git a/drivers/usb/storage/usb.c b/drivers/usb/storage/usb.c
> index fa83fe0defe2..71dd623b95c9 100644
> --- a/drivers/usb/storage/usb.c
> +++ b/drivers/usb/storage/usb.c
> @@ -158,10 +158,7 @@ static int delay_use_get(char *s, const struct kerne=
l_param *kp)
>         return format_delay_ms(delay_ms, 3, "ms", s, PAGE_SIZE);
>  }
>
> -static const struct kernel_param_ops delay_use_ops =3D {
> -       .set =3D delay_use_set,
> -       .get =3D delay_use_get,
> -};
> +static DEFINE_KERNEL_PARAM_OPS(delay_use_ops, delay_use_set, delay_use_g=
et);
>  module_param_cb(delay_use, &delay_use_ops, &delay_use, 0644);
>  MODULE_PARM_DESC(delay_use, "time to delay before using a new device");
>
> diff --git a/drivers/vhost/scsi.c b/drivers/vhost/scsi.c
> index 9a1253b9d8c5..fd52f2213e27 100644
> --- a/drivers/vhost/scsi.c
> +++ b/drivers/vhost/scsi.c
> @@ -87,10 +87,9 @@ static int vhost_scsi_get_inline_sg_cnt(char *buf,
>         return sprintf(buf, "%u\n", vhost_scsi_inline_sg_cnt);
>  }
>
> -static const struct kernel_param_ops vhost_scsi_inline_sg_cnt_op =3D {
> -       .get =3D vhost_scsi_get_inline_sg_cnt,
> -       .set =3D vhost_scsi_set_inline_sg_cnt,
> -};
> +static DEFINE_KERNEL_PARAM_OPS(vhost_scsi_inline_sg_cnt_op,
> +                              vhost_scsi_set_inline_sg_cnt,
> +                              vhost_scsi_get_inline_sg_cnt);
>
>  module_param_cb(inline_sg_cnt, &vhost_scsi_inline_sg_cnt_op, NULL, 0644)=
;
>  MODULE_PARM_DESC(inline_sg_cnt, "Set the number of scatterlist entries t=
o pre-allocate. The default is 2048.");
> diff --git a/drivers/virt/nitro_enclaves/ne_misc_dev.c b/drivers/virt/nit=
ro_enclaves/ne_misc_dev.c
> index c91300a73f50..218ddd93f960 100644
> --- a/drivers/virt/nitro_enclaves/ne_misc_dev.c
> +++ b/drivers/virt/nitro_enclaves/ne_misc_dev.c
> @@ -86,10 +86,8 @@ struct ne_devs ne_devs =3D {
>   */
>  static int ne_set_kernel_param(const char *val, const struct kernel_para=
m *kp);
>
> -static const struct kernel_param_ops ne_cpu_pool_ops =3D {
> -       .get    =3D param_get_string,
> -       .set    =3D ne_set_kernel_param,
> -};
> +static DEFINE_KERNEL_PARAM_OPS(ne_cpu_pool_ops, ne_set_kernel_param,
> +                              param_get_string);
>
>  static char ne_cpus[NE_CPUS_SIZE];
>  static struct kparam_string ne_cpus_arg =3D {
> diff --git a/drivers/virtio/virtio_mmio.c b/drivers/virtio/virtio_mmio.c
> index 595c2274fbb5..f6df9c76ee81 100644
> --- a/drivers/virtio/virtio_mmio.c
> +++ b/drivers/virtio/virtio_mmio.c
> @@ -748,10 +748,8 @@ static int vm_cmdline_get(char *buffer, const struct=
 kernel_param *kp)
>         return strlen(buffer) + 1;
>  }
>
> -static const struct kernel_param_ops vm_cmdline_param_ops =3D {
> -       .set =3D vm_cmdline_set,
> -       .get =3D vm_cmdline_get,
> -};
> +static DEFINE_KERNEL_PARAM_OPS(vm_cmdline_param_ops, vm_cmdline_set,
> +                              vm_cmdline_get);
>
>  device_param_cb(device, &vm_cmdline_param_ops, NULL, S_IRUSR);
>
> diff --git a/fs/ceph/super.c b/fs/ceph/super.c
> index c05fbd4237f8..dec8024b8ac7 100644
> --- a/fs/ceph/super.c
> +++ b/fs/ceph/super.c
> @@ -1684,10 +1684,8 @@ static int param_set_metrics(const char *val, cons=
t struct kernel_param *kp)
>         return 0;
>  }
>
> -static const struct kernel_param_ops param_ops_metrics =3D {
> -       .set =3D param_set_metrics,
> -       .get =3D param_get_bool,
> -};
> +static DEFINE_KERNEL_PARAM_OPS(param_ops_metrics, param_set_metrics,
> +                              param_get_bool);
>
>  bool disable_send_metrics =3D false;
>  module_param_cb(disable_send_metrics, &param_ops_metrics, &disable_send_=
metrics, 0644);
> @@ -1695,9 +1693,7 @@ MODULE_PARM_DESC(disable_send_metrics, "Enable send=
ing perf metrics to ceph clus
>
>  /* for both v1 and v2 syntax */
>  static bool mount_support =3D true;
> -static const struct kernel_param_ops param_ops_mount_syntax =3D {
> -       .get =3D param_get_bool,
> -};
> +static DEFINE_KERNEL_PARAM_OPS(param_ops_mount_syntax, NULL, param_get_b=
ool);
>  module_param_cb(mount_syntax_v1, &param_ops_mount_syntax, &mount_support=
, 0444);
>  module_param_cb(mount_syntax_v2, &param_ops_mount_syntax, &mount_support=
, 0444);
>
> diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
> index b658b6baf72f..cc955c9952d1 100644
> --- a/fs/fuse/dir.c
> +++ b/fs/fuse/dir.c
> @@ -71,10 +71,7 @@ static int inval_wq_set(const char *val, const struct =
kernel_param *kp)
>
>         return 0;
>  }
> -static const struct kernel_param_ops inval_wq_ops =3D {
> -       .set =3D inval_wq_set,
> -       .get =3D param_get_uint,
> -};
> +static DEFINE_KERNEL_PARAM_OPS(inval_wq_ops, inval_wq_set, param_get_uin=
t);
>  module_param_cb(inval_wq, &inval_wq_ops, &inval_wq, 0644);
>  __MODULE_PARM_TYPE(inval_wq, "uint");
>  MODULE_PARM_DESC(inval_wq,
> diff --git a/fs/nfs/namespace.c b/fs/nfs/namespace.c
> index af9be0c5f516..f2fba60dc5ed 100644
> --- a/fs/nfs/namespace.c
> +++ b/fs/nfs/namespace.c
> @@ -372,10 +372,8 @@ static int param_get_nfs_timeout(char *buffer, const=
 struct kernel_param *kp)
>         return sysfs_emit(buffer, "%li\n", num);
>  }
>
> -static const struct kernel_param_ops param_ops_nfs_timeout =3D {
> -       .set =3D param_set_nfs_timeout,
> -       .get =3D param_get_nfs_timeout,
> -};
> +static DEFINE_KERNEL_PARAM_OPS(param_ops_nfs_timeout, param_set_nfs_time=
out,
> +                              param_get_nfs_timeout);
>  #define param_check_nfs_timeout(name, p) __param_check(name, p, int)
>
>  module_param(nfs_mountpoint_expiry_timeout, nfs_timeout, 0644);
> diff --git a/fs/nfs/super.c b/fs/nfs/super.c
> index 4cd420b14ce3..59d89a18aba6 100644
> --- a/fs/nfs/super.c
> +++ b/fs/nfs/super.c
> @@ -1419,10 +1419,8 @@ static int param_set_portnr(const char *val, const=
 struct kernel_param *kp)
>         *((unsigned int *)kp->arg) =3D num;
>         return 0;
>  }
> -static const struct kernel_param_ops param_ops_portnr =3D {
> -       .set =3D param_set_portnr,
> -       .get =3D param_get_uint,
> -};
> +static DEFINE_KERNEL_PARAM_OPS(param_ops_portnr, param_set_portnr,
> +                              param_get_uint);
>  #define param_check_portnr(name, p) __param_check(name, p, unsigned int)
>
>  module_param_named(callback_tcpport, nfs_callback_set_tcpport, portnr, 0=
644);
> diff --git a/fs/ubifs/super.c b/fs/ubifs/super.c
> index 9a77d8b64ffa..e44f8e18f756 100644
> --- a/fs/ubifs/super.c
> +++ b/fs/ubifs/super.c
> @@ -36,10 +36,8 @@ static int ubifs_default_version_set(const char *val, =
const struct kernel_param
>         return param_set_int(val, kp);
>  }
>
> -static const struct kernel_param_ops ubifs_default_version_ops =3D {
> -       .set =3D ubifs_default_version_set,
> -       .get =3D param_get_int,
> -};
> +static DEFINE_KERNEL_PARAM_OPS(ubifs_default_version_ops,
> +                              ubifs_default_version_set, param_get_int);
>
>  int ubifs_default_version =3D UBIFS_FORMAT_VERSION;
>  module_param_cb(default_version, &ubifs_default_version_ops, &ubifs_defa=
ult_version, 0600);
> diff --git a/kernel/locking/locktorture.c b/kernel/locking/locktorture.c
> index e618bcf75e2d..38ae3b596ef2 100644
> --- a/kernel/locking/locktorture.c
> +++ b/kernel/locking/locktorture.c
> @@ -98,10 +98,8 @@ static bool cpumask_nonempty(cpumask_var_t mask)
>         return cpumask_available(mask) && !cpumask_empty(mask);
>  }
>
> -static const struct kernel_param_ops lt_bind_ops =3D {
> -       .set =3D param_set_cpumask,
> -       .get =3D param_get_cpumask,
> -};
> +static DEFINE_KERNEL_PARAM_OPS(lt_bind_ops, param_set_cpumask,
> +                              param_get_cpumask);
>
>  module_param_cb(bind_readers, &lt_bind_ops, &bind_readers, 0444);
>  module_param_cb(bind_writers, &lt_bind_ops, &bind_writers, 0444);
> diff --git a/kernel/panic.c b/kernel/panic.c
> index 42e5ebde4585..8698374b0d21 100644
> --- a/kernel/panic.c
> +++ b/kernel/panic.c
> @@ -1214,10 +1214,8 @@ static int panic_print_set(const char *val, const =
struct kernel_param *kp)
>         return  param_set_ulong(val, kp);
>  }
>
> -static const struct kernel_param_ops panic_print_ops =3D {
> -       .set    =3D panic_print_set,
> -       .get    =3D param_get_ulong,
> -};
> +static DEFINE_KERNEL_PARAM_OPS(panic_print_ops, panic_print_set,
> +                              param_get_ulong);
>  __core_param_cb(panic_print, &panic_print_ops, &panic_print, 0644);
>
>  static int __init oops_setup(char *s)
> diff --git a/kernel/params.c b/kernel/params.c
> index 2cbad1f4dd06..e19fff2926bc 100644
> --- a/kernel/params.c
> +++ b/kernel/params.c
> @@ -297,11 +297,8 @@ void param_free_charp(void *arg)
>  }
>  EXPORT_SYMBOL(param_free_charp);
>
> -const struct kernel_param_ops param_ops_charp =3D {
> -       .set =3D param_set_charp,
> -       .get =3D param_get_charp,
> -       .free =3D param_free_charp,
> -};
> +DEFINE_KERNEL_PARAM_OPS_FREE(param_ops_charp, param_set_charp, param_get=
_charp,
> +                            param_free_charp);
>  EXPORT_SYMBOL(param_ops_charp);
>
>  /* Actually could be a bool or an int, for historical reasons. */
> @@ -322,11 +319,7 @@ int param_get_bool(char *buffer, const struct kernel=
_param *kp)
>  }
>  EXPORT_SYMBOL(param_get_bool);
>
> -const struct kernel_param_ops param_ops_bool =3D {
> -       .flags =3D KERNEL_PARAM_OPS_FL_NOARG,
> -       .set =3D param_set_bool,
> -       .get =3D param_get_bool,
> -};
> +DEFINE_KERNEL_PARAM_OPS_NOARG(param_ops_bool, param_set_bool, param_get_=
bool);
>  EXPORT_SYMBOL(param_ops_bool);
>
>  int param_set_bool_enable_only(const char *val, const struct kernel_para=
m *kp)
> @@ -353,11 +346,8 @@ int param_set_bool_enable_only(const char *val, cons=
t struct kernel_param *kp)
>  }
>  EXPORT_SYMBOL_GPL(param_set_bool_enable_only);
>
> -const struct kernel_param_ops param_ops_bool_enable_only =3D {
> -       .flags =3D KERNEL_PARAM_OPS_FL_NOARG,
> -       .set =3D param_set_bool_enable_only,
> -       .get =3D param_get_bool,
> -};
> +DEFINE_KERNEL_PARAM_OPS_NOARG(param_ops_bool_enable_only,
> +                             param_set_bool_enable_only, param_get_bool)=
;
>  EXPORT_SYMBOL_GPL(param_ops_bool_enable_only);
>
>  /* This one must be bool. */
> @@ -381,10 +371,7 @@ int param_get_invbool(char *buffer, const struct ker=
nel_param *kp)
>  }
>  EXPORT_SYMBOL(param_get_invbool);
>
> -const struct kernel_param_ops param_ops_invbool =3D {
> -       .set =3D param_set_invbool,
> -       .get =3D param_get_invbool,
> -};
> +DEFINE_KERNEL_PARAM_OPS(param_ops_invbool, param_set_invbool, param_get_=
invbool);
>  EXPORT_SYMBOL(param_ops_invbool);
>
>  int param_set_bint(const char *val, const struct kernel_param *kp)
> @@ -403,11 +390,7 @@ int param_set_bint(const char *val, const struct ker=
nel_param *kp)
>  }
>  EXPORT_SYMBOL(param_set_bint);
>
> -const struct kernel_param_ops param_ops_bint =3D {
> -       .flags =3D KERNEL_PARAM_OPS_FL_NOARG,
> -       .set =3D param_set_bint,
> -       .get =3D param_get_int,
> -};
> +DEFINE_KERNEL_PARAM_OPS_NOARG(param_ops_bint, param_set_bint, param_get_=
int);
>  EXPORT_SYMBOL(param_ops_bint);
>
>  /* We break the rule and mangle the string. */
> @@ -515,11 +498,8 @@ static void param_array_free(void *arg)
>                         arr->ops->free(arr->elem + arr->elemsize * i);
>  }
>
> -const struct kernel_param_ops param_array_ops =3D {
> -       .set =3D param_array_set,
> -       .get =3D param_array_get,
> -       .free =3D param_array_free,
> -};
> +DEFINE_KERNEL_PARAM_OPS_FREE(param_array_ops, param_array_set, param_arr=
ay_get,
> +                            param_array_free);
>  EXPORT_SYMBOL(param_array_ops);
>
>  int param_set_copystring(const char *val, const struct kernel_param *kp)
> @@ -544,10 +524,8 @@ int param_get_string(char *buffer, const struct kern=
el_param *kp)
>  }
>  EXPORT_SYMBOL(param_get_string);
>
> -const struct kernel_param_ops param_ops_string =3D {
> -       .set =3D param_set_copystring,
> -       .get =3D param_get_string,
> -};
> +DEFINE_KERNEL_PARAM_OPS(param_ops_string, param_set_copystring,
> +                       param_get_string);
>  EXPORT_SYMBOL(param_ops_string);
>
>  /* sysfs output in /sys/modules/XYZ/parameters/ */
> diff --git a/kernel/power/hibernate.c b/kernel/power/hibernate.c
> index af8d07bafe02..aba1e4489447 100644
> --- a/kernel/power/hibernate.c
> +++ b/kernel/power/hibernate.c
> @@ -1528,10 +1528,8 @@ static int hibernate_compressor_param_set(const ch=
ar *compressor,
>         return ret;
>  }
>
> -static const struct kernel_param_ops hibernate_compressor_param_ops =3D =
{
> -       .set    =3D hibernate_compressor_param_set,
> -       .get    =3D param_get_string,
> -};
> +static DEFINE_KERNEL_PARAM_OPS(hibernate_compressor_param_ops,
> +                              hibernate_compressor_param_set, param_get_=
string);
>
>  static struct kparam_string hibernate_compressor_param_string =3D {
>         .maxlen =3D sizeof(hibernate_compressor),
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index 55df6d37145e..e675d7f1b4ee 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -498,15 +498,11 @@ static int param_set_next_fqs_jiffies(const char *v=
al, const struct kernel_param
>         return ret;
>  }
>
> -static const struct kernel_param_ops first_fqs_jiffies_ops =3D {
> -       .set =3D param_set_first_fqs_jiffies,
> -       .get =3D param_get_ulong,
> -};
> +static DEFINE_KERNEL_PARAM_OPS(first_fqs_jiffies_ops,
> +                              param_set_first_fqs_jiffies, param_get_ulo=
ng);
>
> -static const struct kernel_param_ops next_fqs_jiffies_ops =3D {
> -       .set =3D param_set_next_fqs_jiffies,
> -       .get =3D param_get_ulong,
> -};
> +static DEFINE_KERNEL_PARAM_OPS(next_fqs_jiffies_ops, param_set_next_fqs_=
jiffies,
> +                              param_get_ulong);
>
>  module_param_cb(jiffies_till_first_fqs, &first_fqs_jiffies_ops, &jiffies=
_till_first_fqs, 0644);
>  module_param_cb(jiffies_till_next_fqs, &next_fqs_jiffies_ops, &jiffies_t=
ill_next_fqs, 0644);
> @@ -3979,10 +3975,8 @@ static int param_get_do_rcu_barrier(char *buffer, =
const struct kernel_param *kp)
>         return sprintf(buffer, "%d\n", atomic_read((atomic_t *)kp->arg));
>  }
>
> -static const struct kernel_param_ops do_rcu_barrier_ops =3D {
> -       .set =3D param_set_do_rcu_barrier,
> -       .get =3D param_get_do_rcu_barrier,
> -};
> +static DEFINE_KERNEL_PARAM_OPS(do_rcu_barrier_ops, param_set_do_rcu_barr=
ier,
> +                              param_get_do_rcu_barrier);
>  static atomic_t do_rcu_barrier;
>  module_param_cb(do_rcu_barrier, &do_rcu_barrier_ops, &do_rcu_barrier, 06=
44);
>
> diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
> index 345aa11b84b2..fcf31e3e4965 100644
> --- a/kernel/sched/ext.c
> +++ b/kernel/sched/ext.c
> @@ -166,20 +166,15 @@ static int set_slice_us(const char *val, const stru=
ct kernel_param *kp)
>         return param_set_uint_minmax(val, kp, 100, 100 * USEC_PER_MSEC);
>  }
>
> -static const struct kernel_param_ops slice_us_param_ops =3D {
> -       .set =3D set_slice_us,
> -       .get =3D param_get_uint,
> -};
> +static DEFINE_KERNEL_PARAM_OPS(slice_us_param_ops, set_slice_us, param_g=
et_uint);
>
>  static int set_bypass_lb_intv_us(const char *val, const struct kernel_pa=
ram *kp)
>  {
>         return param_set_uint_minmax(val, kp, 0, 10 * USEC_PER_SEC);
>  }
>
> -static const struct kernel_param_ops bypass_lb_intv_us_param_ops =3D {
> -       .set =3D set_bypass_lb_intv_us,
> -       .get =3D param_get_uint,
> -};
> +static DEFINE_KERNEL_PARAM_OPS(bypass_lb_intv_us_param_ops,
> +                              set_bypass_lb_intv_us, param_get_uint);
>
>  #undef MODULE_PARAM_PREFIX
>  #define MODULE_PARAM_PREFIX    "sched_ext."
> diff --git a/kernel/workqueue.c b/kernel/workqueue.c
> index 5f747f241a5f..42562b811d94 100644
> --- a/kernel/workqueue.c
> +++ b/kernel/workqueue.c
> @@ -7162,10 +7162,8 @@ static int wq_affn_dfl_get(char *buffer, const str=
uct kernel_param *kp)
>         return scnprintf(buffer, PAGE_SIZE, "%s\n", wq_affn_names[wq_affn=
_dfl]);
>  }
>
> -static const struct kernel_param_ops wq_affn_dfl_ops =3D {
> -       .set    =3D wq_affn_dfl_set,
> -       .get    =3D wq_affn_dfl_get,
> -};
> +static DEFINE_KERNEL_PARAM_OPS(wq_affn_dfl_ops, wq_affn_dfl_set,
> +                              wq_affn_dfl_get);
>
>  module_param_cb(default_affinity_scope, &wq_affn_dfl_ops, NULL, 0644);
>
> @@ -7861,10 +7859,8 @@ static int wq_watchdog_param_set_thresh(const char=
 *val,
>         return 0;
>  }
>
> -static const struct kernel_param_ops wq_watchdog_thresh_ops =3D {
> -       .set    =3D wq_watchdog_param_set_thresh,
> -       .get    =3D param_get_ulong,
> -};
> +static DEFINE_KERNEL_PARAM_OPS(wq_watchdog_thresh_ops,
> +                              wq_watchdog_param_set_thresh, param_get_ul=
ong);
>
>  module_param_cb(watchdog_thresh, &wq_watchdog_thresh_ops, &wq_watchdog_t=
hresh,
>                 0644);
> diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
> index 18a71a9108d3..cf0405ba0dbd 100644
> --- a/lib/dynamic_debug.c
> +++ b/lib/dynamic_debug.c
> @@ -807,10 +807,8 @@ int param_get_dyndbg_classes(char *buffer, const str=
uct kernel_param *kp)
>  }
>  EXPORT_SYMBOL(param_get_dyndbg_classes);
>
> -const struct kernel_param_ops param_ops_dyndbg_classes =3D {
> -       .set =3D param_set_dyndbg_classes,
> -       .get =3D param_get_dyndbg_classes,
> -};
> +DEFINE_KERNEL_PARAM_OPS(param_ops_dyndbg_classes, param_set_dyndbg_class=
es,
> +                       param_get_dyndbg_classes);
>  EXPORT_SYMBOL(param_ops_dyndbg_classes);
>
>  #define PREFIX_SIZE 128
> diff --git a/lib/test_dynamic_debug.c b/lib/test_dynamic_debug.c
> index 77c2a669b6af..30880b6c726a 100644
> --- a/lib/test_dynamic_debug.c
> +++ b/lib/test_dynamic_debug.c
> @@ -23,10 +23,8 @@ static int param_get_do_prints(char *buffer, const str=
uct kernel_param *kp)
>         do_prints();
>         return scnprintf(buffer, PAGE_SIZE, "did do_prints\n");
>  }
> -static const struct kernel_param_ops param_ops_do_prints =3D {
> -       .set =3D param_set_do_prints,
> -       .get =3D param_get_do_prints,
> -};
> +static DEFINE_KERNEL_PARAM_OPS(param_ops_do_prints, param_set_do_prints,
> +                              param_get_do_prints);
>  module_param_cb(do_prints, &param_ops_do_prints, NULL, 0600);
>
>  /*
> diff --git a/mm/damon/lru_sort.c b/mm/damon/lru_sort.c
> index 8494040b1ee4..5feb93c5262e 100644
> --- a/mm/damon/lru_sort.c
> +++ b/mm/damon/lru_sort.c
> @@ -405,10 +405,8 @@ static int damon_lru_sort_addr_unit_store(const char=
 *val,
>         return 0;
>  }
>
> -static const struct kernel_param_ops addr_unit_param_ops =3D {
> -       .set =3D damon_lru_sort_addr_unit_store,
> -       .get =3D param_get_ulong,
> -};
> +static DEFINE_KERNEL_PARAM_OPS(addr_unit_param_ops,
> +                              damon_lru_sort_addr_unit_store, param_get_=
ulong);
>
>  module_param_cb(addr_unit, &addr_unit_param_ops, &addr_unit, 0600);
>  MODULE_PARM_DESC(addr_unit,
> @@ -446,10 +444,8 @@ static int damon_lru_sort_enabled_load(char *buffer,
>         return sprintf(buffer, "%c\n", damon_lru_sort_enabled() ? 'Y' : '=
N');
>  }
>
> -static const struct kernel_param_ops enabled_param_ops =3D {
> -       .set =3D damon_lru_sort_enabled_store,
> -       .get =3D damon_lru_sort_enabled_load,
> -};
> +static DEFINE_KERNEL_PARAM_OPS(enabled_param_ops, damon_lru_sort_enabled=
_store,
> +                              damon_lru_sort_enabled_load);
>
>  module_param_cb(enabled, &enabled_param_ops, &enabled, 0600);
>  MODULE_PARM_DESC(enabled,
> @@ -478,10 +474,9 @@ static int damon_lru_sort_kdamond_pid_load(char *buf=
fer,
>         return sprintf(buffer, "%d\n", kdamond_pid);
>  }
>
> -static const struct kernel_param_ops kdamond_pid_param_ops =3D {
> -       .set =3D damon_lru_sort_kdamond_pid_store,
> -       .get =3D damon_lru_sort_kdamond_pid_load,
> -};
> +static DEFINE_KERNEL_PARAM_OPS(kdamond_pid_param_ops,
> +                              damon_lru_sort_kdamond_pid_store,
> +                              damon_lru_sort_kdamond_pid_load);
>
>  /*
>   * PID of the DAMON thread
> diff --git a/mm/damon/reclaim.c b/mm/damon/reclaim.c
> index fe7fce26cf6c..27e772b095fa 100644
> --- a/mm/damon/reclaim.c
> +++ b/mm/damon/reclaim.c
> @@ -307,10 +307,8 @@ static int damon_reclaim_addr_unit_store(const char =
*val,
>         return 0;
>  }
>
> -static const struct kernel_param_ops addr_unit_param_ops =3D {
> -       .set =3D damon_reclaim_addr_unit_store,
> -       .get =3D param_get_ulong,
> -};
> +static DEFINE_KERNEL_PARAM_OPS(addr_unit_param_ops,
> +                              damon_reclaim_addr_unit_store, param_get_u=
long);
>
>  module_param_cb(addr_unit, &addr_unit_param_ops, &addr_unit, 0600);
>  MODULE_PARM_DESC(addr_unit,
> @@ -348,10 +346,8 @@ static int damon_reclaim_enabled_load(char *buffer,
>         return sprintf(buffer, "%c\n", damon_reclaim_enabled() ? 'Y' : 'N=
');
>  }
>
> -static const struct kernel_param_ops enabled_param_ops =3D {
> -       .set =3D damon_reclaim_enabled_store,
> -       .get =3D damon_reclaim_enabled_load,
> -};
> +static DEFINE_KERNEL_PARAM_OPS(enabled_param_ops, damon_reclaim_enabled_=
store,
> +                              damon_reclaim_enabled_load);
>
>  module_param_cb(enabled, &enabled_param_ops, &enabled, 0600);
>  MODULE_PARM_DESC(enabled,
> @@ -380,10 +376,9 @@ static int damon_reclaim_kdamond_pid_load(char *buff=
er,
>         return sprintf(buffer, "%d\n", kdamond_pid);
>  }
>
> -static const struct kernel_param_ops kdamond_pid_param_ops =3D {
> -       .set =3D damon_reclaim_kdamond_pid_store,
> -       .get =3D damon_reclaim_kdamond_pid_load,
> -};
> +static DEFINE_KERNEL_PARAM_OPS(kdamond_pid_param_ops,
> +                              damon_reclaim_kdamond_pid_store,
> +                              damon_reclaim_kdamond_pid_load);
>
>  /*
>   * PID of the DAMON thread
> diff --git a/mm/damon/stat.c b/mm/damon/stat.c
> index 3951b762cbdd..6eb548793802 100644
> --- a/mm/damon/stat.c
> +++ b/mm/damon/stat.c
> @@ -22,10 +22,8 @@ static int damon_stat_enabled_store(
>  static int damon_stat_enabled_load(char *buffer,
>                 const struct kernel_param *kp);
>
> -static const struct kernel_param_ops enabled_param_ops =3D {
> -       .set =3D damon_stat_enabled_store,
> -       .get =3D damon_stat_enabled_load,
> -};
> +static DEFINE_KERNEL_PARAM_OPS(enabled_param_ops, damon_stat_enabled_sto=
re,
> +                              damon_stat_enabled_load);
>
>  static bool enabled __read_mostly =3D IS_ENABLED(
>         CONFIG_DAMON_STAT_ENABLED_DEFAULT);
> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> index 2a943ec57c85..42e0cf313281 100644
> --- a/mm/memory_hotplug.c
> +++ b/mm/memory_hotplug.c
> @@ -109,10 +109,8 @@ static int get_memmap_mode(char *buffer, const struc=
t kernel_param *kp)
>         return sprintf(buffer, "%c\n", mode ? 'Y' : 'N');
>  }
>
> -static const struct kernel_param_ops memmap_mode_ops =3D {
> -       .set =3D set_memmap_mode,
> -       .get =3D get_memmap_mode,
> -};
> +static DEFINE_KERNEL_PARAM_OPS(memmap_mode_ops, set_memmap_mode,
> +                              get_memmap_mode);
>  module_param_cb(memmap_on_memory, &memmap_mode_ops, &memmap_mode, 0444);
>  MODULE_PARM_DESC(memmap_on_memory, "Enable memmap on memory for memory h=
otplug\n"
>                  "With value \"force\" it could result in memory wastage =
due "
> @@ -163,10 +161,8 @@ static int get_online_policy(char *buffer, const str=
uct kernel_param *kp)
>   *                 (auto_movable_ratio, auto_movable_numa_aware) allows =
for it
>   */
>  static int online_policy __read_mostly =3D ONLINE_POLICY_CONTIG_ZONES;
> -static const struct kernel_param_ops online_policy_ops =3D {
> -       .set =3D set_online_policy,
> -       .get =3D get_online_policy,
> -};
> +static DEFINE_KERNEL_PARAM_OPS(online_policy_ops, set_online_policy,
> +                              get_online_policy);
>  module_param_cb(online_policy, &online_policy_ops, &online_policy, 0644)=
;
>  MODULE_PARM_DESC(online_policy,
>                 "Set the online policy (\"contig-zones\", \"auto-movable\=
") "
> diff --git a/mm/page_reporting.c b/mm/page_reporting.c
> index 7418f2e500bb..61351e12b4d9 100644
> --- a/mm/page_reporting.c
> +++ b/mm/page_reporting.c
> @@ -23,15 +23,8 @@ static int page_order_update_notify(const char *val, c=
onst struct kernel_param *
>         return  param_set_uint_minmax(val, kp, 0, MAX_PAGE_ORDER);
>  }
>
> -static const struct kernel_param_ops page_reporting_param_ops =3D {
> -       .set =3D &page_order_update_notify,
> -       /*
> -        * For the get op, use param_get_int instead of param_get_uint.
> -        * This is to make sure that when unset the initialized value of
> -        * -1 is shown correctly
> -        */
> -       .get =3D &param_get_int,
> -};
> +static DEFINE_KERNEL_PARAM_OPS(page_reporting_param_ops,
> +                              &page_order_update_notify, &param_get_int)=
;
>
>  module_param_cb(page_reporting_order, &page_reporting_param_ops,
>                         &page_reporting_order, 0644);
> diff --git a/mm/shuffle.c b/mm/shuffle.c
> index fb1393b8b3a9..114fe7467516 100644
> --- a/mm/shuffle.c
> +++ b/mm/shuffle.c
> @@ -23,10 +23,8 @@ static __meminit int shuffle_param_set(const char *val=
,
>         return 0;
>  }
>
> -static const struct kernel_param_ops shuffle_param_ops =3D {
> -       .set =3D shuffle_param_set,
> -       .get =3D param_get_bool,
> -};
> +static DEFINE_KERNEL_PARAM_OPS(shuffle_param_ops, shuffle_param_set,
> +                              param_get_bool);
>  module_param_cb(shuffle, &shuffle_param_ops, &shuffle_param, 0400);
>
>  /*
> diff --git a/mm/zswap.c b/mm/zswap.c
> index 4b5149173b0e..ed3aa07c2f1d 100644
> --- a/mm/zswap.c
> +++ b/mm/zswap.c
> @@ -90,21 +90,17 @@ static DEFINE_STATIC_KEY_MAYBE(CONFIG_ZSWAP_DEFAULT_O=
N, zswap_ever_enabled);
>  static bool zswap_enabled =3D IS_ENABLED(CONFIG_ZSWAP_DEFAULT_ON);
>  static int zswap_enabled_param_set(const char *,
>                                    const struct kernel_param *);
> -static const struct kernel_param_ops zswap_enabled_param_ops =3D {
> -       .set =3D          zswap_enabled_param_set,
> -       .get =3D          param_get_bool,
> -};
> +static DEFINE_KERNEL_PARAM_OPS(zswap_enabled_param_ops, zswap_enabled_pa=
ram_set,
> +                              param_get_bool);
>  module_param_cb(enabled, &zswap_enabled_param_ops, &zswap_enabled, 0644)=
;
>
>  /* Crypto compressor to use */
>  static char *zswap_compressor =3D CONFIG_ZSWAP_COMPRESSOR_DEFAULT;
>  static int zswap_compressor_param_set(const char *,
>                                       const struct kernel_param *);
> -static const struct kernel_param_ops zswap_compressor_param_ops =3D {
> -       .set =3D          zswap_compressor_param_set,
> -       .get =3D          param_get_charp,
> -       .free =3D         param_free_charp,
> -};
> +static DEFINE_KERNEL_PARAM_OPS_FREE(zswap_compressor_param_ops,
> +                                   zswap_compressor_param_set, param_get=
_charp,
> +                                   param_free_charp);
>  module_param_cb(compressor, &zswap_compressor_param_ops,
>                 &zswap_compressor, 0644);
>
> diff --git a/net/batman-adv/bat_algo.c b/net/batman-adv/bat_algo.c
> index 49e5861b58ec..54d66a948298 100644
> --- a/net/batman-adv/bat_algo.c
> +++ b/net/batman-adv/bat_algo.c
> @@ -134,10 +134,8 @@ static int batadv_param_set_ra(const char *val, cons=
t struct kernel_param *kp)
>         return param_set_copystring(algo_name, kp);
>  }
>
> -static const struct kernel_param_ops batadv_param_ops_ra =3D {
> -       .set =3D batadv_param_set_ra,
> -       .get =3D param_get_string,
> -};
> +static DEFINE_KERNEL_PARAM_OPS(batadv_param_ops_ra, batadv_param_set_ra,
> +                              param_get_string);
>
>  static struct kparam_string batadv_param_string_ra =3D {
>         .maxlen =3D sizeof(batadv_routing_algo),
> diff --git a/net/ceph/ceph_common.c b/net/ceph/ceph_common.c
> index 952121849180..633202a99e4a 100644
> --- a/net/ceph/ceph_common.c
> +++ b/net/ceph/ceph_common.c
> @@ -52,9 +52,8 @@ static int param_get_supported_features(char *buffer,
>  {
>         return sprintf(buffer, "0x%llx", CEPH_FEATURES_SUPPORTED_DEFAULT)=
;
>  }
> -static const struct kernel_param_ops param_ops_supported_features =3D {
> -       .get =3D param_get_supported_features,
> -};
> +static DEFINE_KERNEL_PARAM_OPS(param_ops_supported_features, NULL,
> +                              param_get_supported_features);
>  module_param_cb(supported_features, &param_ops_supported_features, NULL,
>                 0444);
>
> diff --git a/net/ipv4/tcp_dctcp.c b/net/ipv4/tcp_dctcp.c
> index 274e628e7cf8..2c9c3d0f3c3d 100644
> --- a/net/ipv4/tcp_dctcp.c
> +++ b/net/ipv4/tcp_dctcp.c
> @@ -64,10 +64,8 @@ static int dctcp_shift_g_set(const char *val, const st=
ruct kernel_param *kp)
>         return param_set_uint_minmax(val, kp, 0, 10);
>  }
>
> -static const struct kernel_param_ops dctcp_shift_g_ops =3D {
> -       .set =3D dctcp_shift_g_set,
> -       .get =3D param_get_uint,
> -};
> +static DEFINE_KERNEL_PARAM_OPS(dctcp_shift_g_ops, dctcp_shift_g_set,
> +                              param_get_uint);
>
>  module_param_cb(dctcp_shift_g, &dctcp_shift_g_ops, &dctcp_shift_g, 0644)=
;
>  MODULE_PARM_DESC(dctcp_shift_g, "parameter g for updating dctcp_alpha");
> diff --git a/net/sunrpc/auth.c b/net/sunrpc/auth.c
> index 68c0595ea2fd..64a3e894fd4c 100644
> --- a/net/sunrpc/auth.c
> +++ b/net/sunrpc/auth.c
> @@ -83,10 +83,8 @@ static int param_get_hashtbl_sz(char *buffer, const st=
ruct kernel_param *kp)
>
>  #define param_check_hashtbl_sz(name, p) __param_check(name, p, unsigned =
int);
>
> -static const struct kernel_param_ops param_ops_hashtbl_sz =3D {
> -       .set =3D param_set_hashtbl_sz,
> -       .get =3D param_get_hashtbl_sz,
> -};
> +static DEFINE_KERNEL_PARAM_OPS(param_ops_hashtbl_sz, param_set_hashtbl_s=
z,
> +                              param_get_hashtbl_sz);
>
>  module_param_named(auth_hashtable_size, auth_hashbits, hashtbl_sz, 0644)=
;
>  MODULE_PARM_DESC(auth_hashtable_size, "RPC credential cache hashtable si=
ze");
> diff --git a/net/sunrpc/xprtsock.c b/net/sunrpc/xprtsock.c
> index 2e1fe6013361..e8d087798994 100644
> --- a/net/sunrpc/xprtsock.c
> +++ b/net/sunrpc/xprtsock.c
> @@ -3710,10 +3710,8 @@ static int param_set_portnr(const char *val, const=
 struct kernel_param *kp)
>                         RPC_MAX_RESVPORT);
>  }
>
> -static const struct kernel_param_ops param_ops_portnr =3D {
> -       .set =3D param_set_portnr,
> -       .get =3D param_get_uint,
> -};
> +static DEFINE_KERNEL_PARAM_OPS(param_ops_portnr, param_set_portnr,
> +                              param_get_uint);
>
>  #define param_check_portnr(name, p) \
>         __param_check(name, p, unsigned int);
> @@ -3729,10 +3727,8 @@ static int param_set_slot_table_size(const char *v=
al,
>                         RPC_MAX_SLOT_TABLE);
>  }
>
> -static const struct kernel_param_ops param_ops_slot_table_size =3D {
> -       .set =3D param_set_slot_table_size,
> -       .get =3D param_get_uint,
> -};
> +static DEFINE_KERNEL_PARAM_OPS(param_ops_slot_table_size,
> +                              param_set_slot_table_size, param_get_uint)=
;
>
>  #define param_check_slot_table_size(name, p) \
>         __param_check(name, p, unsigned int);
> @@ -3745,10 +3741,8 @@ static int param_set_max_slot_table_size(const cha=
r *val,
>                         RPC_MAX_SLOT_TABLE_LIMIT);
>  }
>
> -static const struct kernel_param_ops param_ops_max_slot_table_size =3D {
> -       .set =3D param_set_max_slot_table_size,
> -       .get =3D param_get_uint,
> -};
> +static DEFINE_KERNEL_PARAM_OPS(param_ops_max_slot_table_size,
> +                              param_set_max_slot_table_size, param_get_u=
int);
>
>  #define param_check_max_slot_table_size(name, p) \
>         __param_check(name, p, unsigned int);
> diff --git a/samples/damon/mtier.c b/samples/damon/mtier.c
> index 775838a23d93..c8018a7ea891 100644
> --- a/samples/damon/mtier.c
> +++ b/samples/damon/mtier.c
> @@ -38,10 +38,8 @@ module_param(node0_mem_free_bp, ulong, 0600);
>  static int damon_sample_mtier_enable_store(
>                 const char *val, const struct kernel_param *kp);
>
> -static const struct kernel_param_ops enabled_param_ops =3D {
> -       .set =3D damon_sample_mtier_enable_store,
> -       .get =3D param_get_bool,
> -};
> +static DEFINE_KERNEL_PARAM_OPS(enabled_param_ops,
> +                              damon_sample_mtier_enable_store, param_get=
_bool);
>
>  static bool enabled __read_mostly;
>  module_param_cb(enabled, &enabled_param_ops, &enabled, 0600);
> diff --git a/samples/damon/prcl.c b/samples/damon/prcl.c
> index b7c50f2656ce..7cab9bd0f7bd 100644
> --- a/samples/damon/prcl.c
> +++ b/samples/damon/prcl.c
> @@ -22,10 +22,8 @@ module_param(target_pid, int, 0600);
>  static int damon_sample_prcl_enable_store(
>                 const char *val, const struct kernel_param *kp);
>
> -static const struct kernel_param_ops enabled_param_ops =3D {
> -       .set =3D damon_sample_prcl_enable_store,
> -       .get =3D param_get_bool,
> -};
> +static DEFINE_KERNEL_PARAM_OPS(enabled_param_ops,
> +                              damon_sample_prcl_enable_store, param_get_=
bool);
>
>  static bool enabled __read_mostly;
>  module_param_cb(enabled, &enabled_param_ops, &enabled, 0600);
> diff --git a/samples/damon/wsse.c b/samples/damon/wsse.c
> index 799ad4443943..56634853bd0b 100644
> --- a/samples/damon/wsse.c
> +++ b/samples/damon/wsse.c
> @@ -23,10 +23,8 @@ module_param(target_pid, int, 0600);
>  static int damon_sample_wsse_enable_store(
>                 const char *val, const struct kernel_param *kp);
>
> -static const struct kernel_param_ops enabled_param_ops =3D {
> -       .set =3D damon_sample_wsse_enable_store,
> -       .get =3D param_get_bool,
> -};
> +static DEFINE_KERNEL_PARAM_OPS(enabled_param_ops,
> +                              damon_sample_wsse_enable_store, param_get_=
bool);
>
>  static bool enabled __read_mostly;
>  module_param_cb(enabled, &enabled_param_ops, &enabled, 0600);
> diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
> index 3491e9f60194..8a253c743363 100644
> --- a/security/apparmor/lsm.c
> +++ b/security/apparmor/lsm.c
> @@ -1767,38 +1767,30 @@ static struct security_hook_list apparmor_hooks[]=
 __ro_after_init =3D {
>  static int param_set_aabool(const char *val, const struct kernel_param *=
kp);
>  static int param_get_aabool(char *buffer, const struct kernel_param *kp)=
;
>  #define param_check_aabool param_check_bool
> -static const struct kernel_param_ops param_ops_aabool =3D {
> -       .flags =3D KERNEL_PARAM_OPS_FL_NOARG,
> -       .set =3D param_set_aabool,
> -       .get =3D param_get_aabool
> -};
> +static DEFINE_KERNEL_PARAM_OPS_NOARG(param_ops_aabool, param_set_aabool,
> +                                    param_get_aabool);
>
>  static int param_set_aauint(const char *val, const struct kernel_param *=
kp);
>  static int param_get_aauint(char *buffer, const struct kernel_param *kp)=
;
>  #define param_check_aauint param_check_uint
> -static const struct kernel_param_ops param_ops_aauint =3D {
> -       .set =3D param_set_aauint,
> -       .get =3D param_get_aauint
> -};
> +static DEFINE_KERNEL_PARAM_OPS(param_ops_aauint, param_set_aauint,
> +                              param_get_aauint);
>
>  static int param_set_aacompressionlevel(const char *val,
>                                         const struct kernel_param *kp);
>  static int param_get_aacompressionlevel(char *buffer,
>                                         const struct kernel_param *kp);
>  #define param_check_aacompressionlevel param_check_int
> -static const struct kernel_param_ops param_ops_aacompressionlevel =3D {
> -       .set =3D param_set_aacompressionlevel,
> -       .get =3D param_get_aacompressionlevel
> -};
> +static DEFINE_KERNEL_PARAM_OPS(param_ops_aacompressionlevel,
> +                              param_set_aacompressionlevel,
> +                              param_get_aacompressionlevel);
>
>  static int param_set_aalockpolicy(const char *val, const struct kernel_p=
aram *kp);
>  static int param_get_aalockpolicy(char *buffer, const struct kernel_para=
m *kp);
>  #define param_check_aalockpolicy param_check_bool
> -static const struct kernel_param_ops param_ops_aalockpolicy =3D {
> -       .flags =3D KERNEL_PARAM_OPS_FL_NOARG,
> -       .set =3D param_set_aalockpolicy,
> -       .get =3D param_get_aalockpolicy
> -};
> +static DEFINE_KERNEL_PARAM_OPS_NOARG(param_ops_aalockpolicy,
> +                                    param_set_aalockpolicy,
> +                                    param_get_aalockpolicy);
>
>  static int param_set_debug(const char *val, const struct kernel_param *k=
p);
>  static int param_get_debug(char *buffer, const struct kernel_param *kp);
> @@ -1879,10 +1871,8 @@ module_param_named(paranoid_load, aa_g_paranoid_lo=
ad, aabool, S_IRUGO);
>  static int param_get_aaintbool(char *buffer, const struct kernel_param *=
kp);
>  static int param_set_aaintbool(const char *val, const struct kernel_para=
m *kp);
>  #define param_check_aaintbool param_check_int
> -static const struct kernel_param_ops param_ops_aaintbool =3D {
> -       .set =3D param_set_aaintbool,
> -       .get =3D param_get_aaintbool
> -};
> +static DEFINE_KERNEL_PARAM_OPS(param_ops_aaintbool, param_set_aaintbool,
> +                              param_get_aaintbool);
>  /* Boot time disable flag */
>  static int apparmor_enabled __ro_after_init =3D 1;
>  module_param_named(enabled, apparmor_enabled, aaintbool, 0444);
> diff --git a/sound/hda/controllers/intel.c b/sound/hda/controllers/intel.=
c
> index c87d75dbd8aa..02bd61e67902 100644
> --- a/sound/hda/controllers/intel.c
> +++ b/sound/hda/controllers/intel.c
> @@ -164,10 +164,7 @@ MODULE_PARM_DESC(ctl_dev_id, "Use control device ide=
ntifier (based on codec addr
>
>  #ifdef CONFIG_PM
>  static int param_set_xint(const char *val, const struct kernel_param *kp=
);
> -static const struct kernel_param_ops param_ops_xint =3D {
> -       .set =3D param_set_xint,
> -       .get =3D param_get_int,
> -};
> +static DEFINE_KERNEL_PARAM_OPS(param_ops_xint, param_set_xint, param_get=
_int);
>  #define param_check_xint param_check_int
>
>  static int power_save =3D CONFIG_SND_HDA_POWER_SAVE_DEFAULT;
> diff --git a/sound/usb/card.c b/sound/usb/card.c
> index f42d72cd0378..34cbb9d72315 100644
> --- a/sound/usb/card.c
> +++ b/sound/usb/card.c
> @@ -118,11 +118,8 @@ static int param_set_quirkp(const char *val,
>         return param_set_charp(val, kp);
>  }
>
> -static const struct kernel_param_ops param_ops_quirkp =3D {
> -       .set =3D param_set_quirkp,
> -       .get =3D param_get_charp,
> -       .free =3D param_free_charp,
> -};
> +static DEFINE_KERNEL_PARAM_OPS_FREE(param_ops_quirkp, param_set_quirkp,
> +                                   param_get_charp, param_free_charp);
>
>  #define param_check_quirkp param_check_charp
>
> --
> 2.34.1
>

