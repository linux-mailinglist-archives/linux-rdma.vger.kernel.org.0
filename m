Return-Path: <linux-rdma+bounces-21160-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oC12KlmOEGqIZgYAu9opvQ
	(envelope-from <linux-rdma+bounces-21160-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 22 May 2026 19:11:53 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 208A55B7FDA
	for <lists+linux-rdma@lfdr.de>; Fri, 22 May 2026 19:11:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 42C8C301226F
	for <lists+linux-rdma@lfdr.de>; Fri, 22 May 2026 17:03:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31018477E42;
	Fri, 22 May 2026 17:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fr+5iYfH"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59E7439DBDF
	for <linux-rdma@vger.kernel.org>; Fri, 22 May 2026 17:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779469417; cv=none; b=r9Lo8p9UuZ230aTEKffjCqqV6eRo7Or2akg2m87u4SQG96XCtc4ypTaUmurnrXiGAHPnAG5QvuZ6LK2p+Ci7cBaA/Iiyo5x398RhA6hzbSK7XXOpie6Lcd7RQHJXBeqUiS+g7r5pH/WxTZo3wei0L6OE8ZG9ID0LTOazVBSsF6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779469417; c=relaxed/simple;
	bh=37wNZRHsPVvvAZVxIAUHTgHOrT5Vit+uE/Ekx8gmbFk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YtJbocA0yzHze+5UJ+GIZk+mV9yJ54BEkXFJPx+SyNaE/caonERy76iAvzLpKySzseyfC+qy603PvjTpWG5jfTsP2O4foBAkeWwK5bvkc1cQ+/LG+8vEznMQ6mAIMjtdnkBW3q25ZWxhYS76uNtRPiZwEwPZnub7HyO7a8Pcq/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fr+5iYfH; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB6031F01565
	for <linux-rdma@vger.kernel.org>; Fri, 22 May 2026 17:03:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779469415;
	bh=KOkCEBj0pTwvpVvCxW1dL7G0mO/AP7o92azBkdf/Z1c=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=Fr+5iYfHLdHZCq9Crnq1zdeN0KWbJQNhQgOudgMwdbe6LBwpZ5Ogi9sSwqSdiZhMI
	 whfVimc+rpGg120B2Akia+Wpmu5I53PI2EqZZbsFlz4+bMc/vgMznUVWrmVbQ6ejWQ
	 kyTFxprGZLiqnq/Z/TlCTdLKW2AxpJ7ZVRow1wNNevAcBJ1u9ZrIoD2qvsyt3t/MW4
	 WIHSTT0gcKMuhcuSFJ1xgHQzNFc0wRsQJi/68amfsePHEoIsjB87Nmhtitl2R3KIKf
	 09Y1Von7aCLof5uU5Jz+50kRXuypDaaVJmuQqLjZKLRQ/Ul/ggws35T7FvEeCxO6aC
	 fQ6S3emJops8g==
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5a88de2b52eso10047126e87.2
        for <linux-rdma@vger.kernel.org>; Fri, 22 May 2026 10:03:34 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ+a/aqvogOXMNp6HUKaixbkXsB0rj0Y/04koQtJsnNkVv2u5SOzGCqmYg2U3Si/uK7SDu1pOu2dV9VY@vger.kernel.org
X-Gm-Message-State: AOJu0YzlxQ+7LkPMNAjxWp8bLHMKNnvFiCjJ71CWzPkchvJMant4H462
	6U4VFz/5i45PcUVkBG+AoPfmiRWVBV/VyO9AJ/Ri/7rvDTSjDH0zCbl4P7l2oYiopDy2T45oi5i
	7PO1oGHjlGzopgW+Sn9wgHCOHgIZPPwY=
X-Received: by 2002:ac2:4e10:0:b0:5a8:e5a0:e0f4 with SMTP id
 2adb3069b0e04-5aa3235e1e8mr1376978e87.12.1779469412736; Fri, 22 May 2026
 10:03:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260521133315.work.845-kees@kernel.org> <20260521133326.2465264-9-kees@kernel.org>
In-Reply-To: <20260521133326.2465264-9-kees@kernel.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 22 May 2026 19:03:20 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0iEi9NQ3GxM_zap5v2G6NKB+WiAodjp1qwVQoCH=_ruzg@mail.gmail.com>
X-Gm-Features: AVHnY4L84y6TjBfUCDkrqpCArzdq6VtbFgQHVJFWsji9QlICgavXwZXfeU39nfA
Message-ID: <CAJZ5v0iEi9NQ3GxM_zap5v2G6NKB+WiAodjp1qwVQoCH=_ruzg@mail.gmail.com>
Subject: Re: [PATCH 09/11] treewide: Convert custom kernel_param_ops .get
 callbacks to seq_buf via cocci
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
	TAGGED_FROM(0.00)[bounces-21160-lists,linux-rdma=lfdr.de];
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
X-Rspamd-Queue-Id: 208A55B7FDA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, May 21, 2026 at 3:33=E2=80=AFPM Kees Cook <kees@kernel.org> wrote:
>
> Using the following Coccinelle script, convert struct kernel_param_ops
> .get callbacks from "char *" to "struct seq_buf *" when the only write
> to the buffer is via a final call of scnprintf(), snprintf(), sprintf(),
> or sysfs_emit().
>
> Since seq_buf_printf() will return -1 on overflow, and struct
> kernel_param_ops .get callbacks are expected to truncate without error,
> we must ignore the return value from seq_buf_print() and always return 0
> (as the length is calculated in the common dispatcher code).
>
> @@
> identifier FN, BUF, KP;
> expression FMT;
> expression list ARGS;
> @@
>  int FN(
> -               char *BUF
> +               struct seq_buf *BUF
>                 , const struct kernel_param *KP)
>  {
>         ... when any
> (
> -       return scnprintf(BUF, PAGE_SIZE, FMT, ARGS);
> |
> -       return snprintf(BUF, PAGE_SIZE, FMT, ARGS);
> |
> -       return sprintf(BUF, FMT, ARGS);
> |
> -       return sysfs_emit(BUF, FMT, ARGS);
> )
> +       seq_buf_printf(BUF, FMT, ARGS);
> +       return 0;
>  }
>
> No struct kernel_param_ops initializations need changing since
> DEFINE_KERNEL_PARAM_OPS already routes the pointer to .get or .get_str
> via _Generic based on the function signature, so converted callbacks
> are automatically moved from the .get_str to the .get callback.
>
> Signed-off-by: Kees Cook <kees@kernel.org>

For ACPI:

Acked-by: Rafael J. Wysocki (Intel) <rafael@kernel.org>

> ---
>  arch/s390/kernel/perf_cpum_sf.c               |  6 ++-
>  arch/x86/kernel/msr.c                         |  5 +-
>  arch/x86/kvm/vmx/vmx.c                        | 18 ++++---
>  arch/x86/platform/uv/uv_nmi.c                 | 12 +++--
>  drivers/acpi/ec.c                             | 14 ++++--
>  drivers/acpi/sysfs.c                          |  6 ++-
>  drivers/block/ublk_drv.c                      |  5 +-
>  drivers/char/ipmi/ipmi_msghandler.c           |  6 ++-
>  drivers/firmware/qcom/qcom_scm.c              | 12 +++--
>  drivers/gpu/drm/drm_panic.c                   |  7 +--
>  drivers/infiniband/hw/hfi1/driver.c           |  7 +--
>  drivers/infiniband/ulp/srpt/ib_srpt.c         |  5 +-
>  drivers/input/misc/ati_remote2.c              | 10 ++--
>  drivers/input/mouse/psmouse-base.c            |  9 ++--
>  drivers/md/md.c                               |  5 +-
>  drivers/media/pci/tw686x/tw686x-core.c        |  6 ++-
>  drivers/nvme/host/multipath.c                 |  5 +-
>  drivers/power/supply/test_power.c             | 47 +++++++++++--------
>  drivers/target/target_core_user.c             | 12 +++--
>  .../processor_thermal_soc_slider.c            | 12 +++--
>  drivers/ufs/core/ufs-fault-injection.c        |  7 +--
>  drivers/vhost/scsi.c                          |  5 +-
>  fs/nfs/namespace.c                            |  6 ++-
>  fs/ocfs2/dlmfs/dlmfs.c                        |  5 +-
>  fs/overlayfs/copy_up.c                        |  5 +-
>  kernel/locking/locktorture.c                  |  6 ++-
>  kernel/rcu/tree.c                             |  6 ++-
>  kernel/workqueue.c                            |  6 ++-
>  lib/test_dynamic_debug.c                      |  6 ++-
>  mm/damon/lru_sort.c                           | 14 +++---
>  mm/damon/reclaim.c                            | 14 +++---
>  mm/damon/stat.c                               | 10 ++--
>  mm/memory_hotplug.c                           | 18 ++++---
>  net/ceph/ceph_common.c                        |  5 +-
>  net/sunrpc/auth.c                             |  6 ++-
>  net/sunrpc/svc.c                              |  5 +-
>  security/apparmor/lsm.c                       | 16 ++++---
>  37 files changed, 218 insertions(+), 131 deletions(-)
>
> diff --git a/arch/s390/kernel/perf_cpum_sf.c b/arch/s390/kernel/perf_cpum=
_sf.c
> index 76119542562b..75b0d441d238 100644
> --- a/arch/s390/kernel/perf_cpum_sf.c
> +++ b/arch/s390/kernel/perf_cpum_sf.c
> @@ -1991,11 +1991,13 @@ static int s390_pmu_sf_offline_cpu(unsigned int c=
pu)
>         return cpusf_pmu_setup(cpu, PMC_RELEASE);
>  }
>
> -static int param_get_sfb_size(char *buffer, const struct kernel_param *k=
p)
> +static int param_get_sfb_size(struct seq_buf *buffer,
> +                             const struct kernel_param *kp)
>  {
>         if (!cpum_sf_avail())
>                 return -ENODEV;
> -       return sprintf(buffer, "%lu,%lu", CPUM_SF_MIN_SDB, CPUM_SF_MAX_SD=
B);
> +       seq_buf_printf(buffer, "%lu,%lu", CPUM_SF_MIN_SDB, CPUM_SF_MAX_SD=
B);
> +       return 0;
>  }
>
>  static int param_set_sfb_size(const char *val, const struct kernel_param=
 *kp)
> diff --git a/arch/x86/kernel/msr.c b/arch/x86/kernel/msr.c
> index 5f4e1814dc4d..9f07f66c3cfc 100644
> --- a/arch/x86/kernel/msr.c
> +++ b/arch/x86/kernel/msr.c
> @@ -309,7 +309,7 @@ static int set_allow_writes(const char *val, const st=
ruct kernel_param *cp)
>         return 0;
>  }
>
> -static int get_allow_writes(char *buf, const struct kernel_param *kp)
> +static int get_allow_writes(struct seq_buf *buf, const struct kernel_par=
am *kp)
>  {
>         const char *res;
>
> @@ -319,7 +319,8 @@ static int get_allow_writes(char *buf, const struct k=
ernel_param *kp)
>         default: res =3D "default"; break;
>         }
>
> -       return sprintf(buf, "%s\n", res);
> +       seq_buf_printf(buf, "%s\n", res);
> +       return 0;
>  }
>
>  static DEFINE_KERNEL_PARAM_OPS(allow_writes_ops, set_allow_writes,
> diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
> index 07f4c7209ac0..00317774a90b 100644
> --- a/arch/x86/kvm/vmx/vmx.c
> +++ b/arch/x86/kvm/vmx/vmx.c
> @@ -368,12 +368,16 @@ static int vmentry_l1d_flush_set(const char *s, con=
st struct kernel_param *kp)
>         return ret;
>  }
>
> -static int vmentry_l1d_flush_get(char *s, const struct kernel_param *kp)
> +static int vmentry_l1d_flush_get(struct seq_buf *s,
> +                                const struct kernel_param *kp)
>  {
> -       if (WARN_ON_ONCE(l1tf_vmx_mitigation >=3D ARRAY_SIZE(vmentry_l1d_=
param)))
> -               return sysfs_emit(s, "???\n");
> +       if (WARN_ON_ONCE(l1tf_vmx_mitigation >=3D ARRAY_SIZE(vmentry_l1d_=
param))) {
> +               seq_buf_printf(s, "???\n");
> +               return 0;
> +       }
>
> -       return sysfs_emit(s, "%s\n", vmentry_l1d_param[l1tf_vmx_mitigatio=
n].option);
> +       seq_buf_printf(s, "%s\n", vmentry_l1d_param[l1tf_vmx_mitigation].=
option);
> +       return 0;
>  }
>
>  /*
> @@ -459,9 +463,11 @@ static int vmentry_l1d_flush_set(const char *s, cons=
t struct kernel_param *kp)
>         pr_warn_once("Kernel compiled without mitigations, ignoring vment=
ry_l1d_flush\n");
>         return 0;
>  }
> -static int vmentry_l1d_flush_get(char *s, const struct kernel_param *kp)
> +static int vmentry_l1d_flush_get(struct seq_buf *s,
> +                                const struct kernel_param *kp)
>  {
> -       return sysfs_emit(s, "never\n");
> +       seq_buf_printf(s, "never\n");
> +       return 0;
>  }
>  #endif
>
> diff --git a/arch/x86/platform/uv/uv_nmi.c b/arch/x86/platform/uv/uv_nmi.=
c
> index a7ac80b5f8d9..c401369efe22 100644
> --- a/arch/x86/platform/uv/uv_nmi.c
> +++ b/arch/x86/platform/uv/uv_nmi.c
> @@ -111,9 +111,11 @@ module_param_named(dump_loglevel, uv_nmi_loglevel, i=
nt, 0644);
>   * The following values show statistics on how perf events are affecting
>   * this system.
>   */
> -static int param_get_local64(char *buffer, const struct kernel_param *kp=
)
> +static int param_get_local64(struct seq_buf *buffer,
> +                            const struct kernel_param *kp)
>  {
> -       return sprintf(buffer, "%lu\n", local64_read((local64_t *)kp->arg=
));
> +       seq_buf_printf(buffer, "%lu\n", local64_read((local64_t *)kp->arg=
));
> +       return 0;
>  }
>
>  static int param_set_local64(const char *val, const struct kernel_param =
*kp)
> @@ -207,9 +209,11 @@ static const char * const actions_desc[nmi_act_max] =
=3D {
>
>  static enum action_t uv_nmi_action =3D nmi_act_dump;
>
> -static int param_get_action(char *buffer, const struct kernel_param *kp)
> +static int param_get_action(struct seq_buf *buffer,
> +                           const struct kernel_param *kp)
>  {
> -       return sprintf(buffer, "%s\n", actions[uv_nmi_action]);
> +       seq_buf_printf(buffer, "%s\n", actions[uv_nmi_action]);
> +       return 0;
>  }
>
>  static int param_set_action(const char *val, const struct kernel_param *=
kp)
> diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
> index 45204538ed87..6478e5290faf 100644
> --- a/drivers/acpi/ec.c
> +++ b/drivers/acpi/ec.c
> @@ -2236,18 +2236,22 @@ static int param_set_event_clearing(const char *v=
al,
>         return result;
>  }
>
> -static int param_get_event_clearing(char *buffer,
> +static int param_get_event_clearing(struct seq_buf *buffer,
>                                     const struct kernel_param *kp)
>  {
>         switch (ec_event_clearing) {
>         case ACPI_EC_EVT_TIMING_STATUS:
> -               return sprintf(buffer, "status\n");
> +               seq_buf_printf(buffer, "status\n");
> +               return 0;
>         case ACPI_EC_EVT_TIMING_QUERY:
> -               return sprintf(buffer, "query\n");
> +               seq_buf_printf(buffer, "query\n");
> +               return 0;
>         case ACPI_EC_EVT_TIMING_EVENT:
> -               return sprintf(buffer, "event\n");
> +               seq_buf_printf(buffer, "event\n");
> +               return 0;
>         default:
> -               return sprintf(buffer, "invalid\n");
> +               seq_buf_printf(buffer, "invalid\n");
> +               return 0;
>         }
>         return 0;
>  }
> diff --git a/drivers/acpi/sysfs.c b/drivers/acpi/sysfs.c
> index 3d32a5280432..5247ed7e05cc 100644
> --- a/drivers/acpi/sysfs.c
> +++ b/drivers/acpi/sysfs.c
> @@ -192,9 +192,11 @@ static int param_set_trace_method_name(const char *v=
al,
>         return 0;
>  }
>
> -static int param_get_trace_method_name(char *buffer, const struct kernel=
_param *kp)
> +static int param_get_trace_method_name(struct seq_buf *buffer,
> +                                      const struct kernel_param *kp)
>  {
> -       return sysfs_emit(buffer, "%s\n", acpi_gbl_trace_method_name);
> +       seq_buf_printf(buffer, "%s\n", acpi_gbl_trace_method_name);
> +       return 0;
>  }
>
>  static DEFINE_KERNEL_PARAM_OPS(param_ops_trace_method,
> diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> index f7bf7ea2d088..ea35662381bf 100644
> --- a/drivers/block/ublk_drv.c
> +++ b/drivers/block/ublk_drv.c
> @@ -5868,10 +5868,11 @@ static int ublk_set_max_unprivileged_ublks(const =
char *buf,
>         return param_set_uint_minmax(buf, kp, 0, UBLK_MAX_UBLKS);
>  }
>
> -static int ublk_get_max_unprivileged_ublks(char *buf,
> +static int ublk_get_max_unprivileged_ublks(struct seq_buf *buf,
>                                            const struct kernel_param *kp)
>  {
> -       return sysfs_emit(buf, "%u\n", unprivileged_ublks_max);
> +       seq_buf_printf(buf, "%u\n", unprivileged_ublks_max);
> +       return 0;
>  }
>
>  static DEFINE_KERNEL_PARAM_OPS(ublk_max_unprivileged_ublks_ops,
> diff --git a/drivers/char/ipmi/ipmi_msghandler.c b/drivers/char/ipmi/ipmi=
_msghandler.c
> index b5fed11707e8..45941605b88f 100644
> --- a/drivers/char/ipmi/ipmi_msghandler.c
> +++ b/drivers/char/ipmi/ipmi_msghandler.c
> @@ -90,7 +90,8 @@ static int panic_op_write_handler(const char *val,
>         return 0;
>  }
>
> -static int panic_op_read_handler(char *buffer, const struct kernel_param=
 *kp)
> +static int panic_op_read_handler(struct seq_buf *buffer,
> +                                const struct kernel_param *kp)
>  {
>         const char *event_str;
>
> @@ -99,7 +100,8 @@ static int panic_op_read_handler(char *buffer, const s=
truct kernel_param *kp)
>         else
>                 event_str =3D ipmi_panic_event_str[ipmi_send_panic_event]=
;
>
> -       return sprintf(buffer, "%s\n", event_str);
> +       seq_buf_printf(buffer, "%s\n", event_str);
> +       return 0;
>  }
>
>  static DEFINE_KERNEL_PARAM_OPS(panic_op_ops, panic_op_write_handler,
> diff --git a/drivers/firmware/qcom/qcom_scm.c b/drivers/firmware/qcom/qco=
m_scm.c
> index ef57df53e087..1bdb497e354e 100644
> --- a/drivers/firmware/qcom/qcom_scm.c
> +++ b/drivers/firmware/qcom/qcom_scm.c
> @@ -2694,12 +2694,16 @@ static irqreturn_t qcom_scm_irq_handler(int irq, =
void *data)
>         return IRQ_HANDLED;
>  }
>
> -static int get_download_mode(char *buffer, const struct kernel_param *kp=
)
> +static int get_download_mode(struct seq_buf *buffer,
> +                            const struct kernel_param *kp)
>  {
> -       if (download_mode >=3D ARRAY_SIZE(download_mode_name))
> -               return sysfs_emit(buffer, "unknown mode\n");
> +       if (download_mode >=3D ARRAY_SIZE(download_mode_name)) {
> +               seq_buf_printf(buffer, "unknown mode\n");
> +               return 0;
> +       }
>
> -       return sysfs_emit(buffer, "%s\n", download_mode_name[download_mod=
e]);
> +       seq_buf_printf(buffer, "%s\n", download_mode_name[download_mode])=
;
> +       return 0;
>  }
>
>  static int set_download_mode(const char *val, const struct kernel_param =
*kp)
> diff --git a/drivers/gpu/drm/drm_panic.c b/drivers/gpu/drm/drm_panic.c
> index c35d1adf2ce3..8b3b749284f0 100644
> --- a/drivers/gpu/drm/drm_panic.c
> +++ b/drivers/gpu/drm/drm_panic.c
> @@ -841,10 +841,11 @@ static int drm_panic_type_set(const char *val, cons=
t struct kernel_param *kp)
>         return -EINVAL;
>  }
>
> -static int drm_panic_type_get(char *buffer, const struct kernel_param *k=
p)
> +static int drm_panic_type_get(struct seq_buf *buffer,
> +                             const struct kernel_param *kp)
>  {
> -       return scnprintf(buffer, PAGE_SIZE, "%s\n",
> -                        drm_panic_type_map[drm_panic_type]);
> +       seq_buf_printf(buffer, "%s\n", drm_panic_type_map[drm_panic_type]=
);
> +       return 0;
>  }
>
>  static DEFINE_KERNEL_PARAM_OPS(drm_panic_ops, drm_panic_type_set,
> diff --git a/drivers/infiniband/hw/hfi1/driver.c b/drivers/infiniband/hw/=
hfi1/driver.c
> index 5b9b0b38b419..3c3f8d4db99d 100644
> --- a/drivers/infiniband/hw/hfi1/driver.c
> +++ b/drivers/infiniband/hw/hfi1/driver.c
> @@ -41,7 +41,7 @@ MODULE_PARM_DESC(cu, "Credit return units");
>
>  unsigned long hfi1_cap_mask =3D HFI1_CAP_MASK_DEFAULT;
>  static int hfi1_caps_set(const char *val, const struct kernel_param *kp)=
;
> -static int hfi1_caps_get(char *buffer, const struct kernel_param *kp);
> +static int hfi1_caps_get(struct seq_buf *buffer, const struct kernel_par=
am *kp);
>  static DEFINE_KERNEL_PARAM_OPS(cap_ops, hfi1_caps_set, hfi1_caps_get);
>  module_param_cb(cap_mask, &cap_ops, &hfi1_cap_mask, S_IWUSR | S_IRUGO);
>  MODULE_PARM_DESC(cap_mask, "Bit mask of enabled/disabled HW features");
> @@ -101,14 +101,15 @@ static int hfi1_caps_set(const char *val, const str=
uct kernel_param *kp)
>         return ret;
>  }
>
> -static int hfi1_caps_get(char *buffer, const struct kernel_param *kp)
> +static int hfi1_caps_get(struct seq_buf *buffer, const struct kernel_par=
am *kp)
>  {
>         unsigned long cap_mask =3D *(unsigned long *)kp->arg;
>
>         cap_mask &=3D ~HFI1_CAP_LOCKED_SMASK;
>         cap_mask |=3D ((cap_mask & HFI1_CAP_K2U) << HFI1_CAP_USER_SHIFT);
>
> -       return sysfs_emit(buffer, "0x%lx\n", cap_mask);
> +       seq_buf_printf(buffer, "0x%lx\n", cap_mask);
> +       return 0;
>  }
>
>  struct pci_dev *get_pci_dev(struct rvt_dev_info *rdi)
> diff --git a/drivers/infiniband/ulp/srpt/ib_srpt.c b/drivers/infiniband/u=
lp/srpt/ib_srpt.c
> index 9aec5d80117f..97c77d52a86a 100644
> --- a/drivers/infiniband/ulp/srpt/ib_srpt.c
> +++ b/drivers/infiniband/ulp/srpt/ib_srpt.c
> @@ -86,9 +86,10 @@ static int srpt_set_u64_x(const char *buffer, const st=
ruct kernel_param *kp)
>  {
>         return kstrtou64(buffer, 16, (u64 *)kp->arg);
>  }
> -static int srpt_get_u64_x(char *buffer, const struct kernel_param *kp)
> +static int srpt_get_u64_x(struct seq_buf *buffer, const struct kernel_pa=
ram *kp)
>  {
> -       return sprintf(buffer, "0x%016llx\n", *(u64 *)kp->arg);
> +       seq_buf_printf(buffer, "0x%016llx\n", *(u64 *)kp->arg);
> +       return 0;
>  }
>  module_param_call(srpt_service_guid, srpt_set_u64_x, srpt_get_u64_x,
>                   &srpt_service_guid, 0444);
> diff --git a/drivers/input/misc/ati_remote2.c b/drivers/input/misc/ati_re=
mote2.c
> index 8b4ef7e163d3..d101fe1c2c4c 100644
> --- a/drivers/input/misc/ati_remote2.c
> +++ b/drivers/input/misc/ati_remote2.c
> @@ -63,12 +63,13 @@ static int ati_remote2_set_channel_mask(const char *v=
al,
>         return ati_remote2_set_mask(val, kp, ATI_REMOTE2_MAX_CHANNEL_MASK=
);
>  }
>
> -static int ati_remote2_get_channel_mask(char *buffer,
> +static int ati_remote2_get_channel_mask(struct seq_buf *buffer,
>                                         const struct kernel_param *kp)
>  {
>         pr_debug("%s()\n", __func__);
>
> -       return sprintf(buffer, "0x%04x\n", *(unsigned int *)kp->arg);
> +       seq_buf_printf(buffer, "0x%04x\n", *(unsigned int *)kp->arg);
> +       return 0;
>  }
>
>  static int ati_remote2_set_mode_mask(const char *val,
> @@ -79,12 +80,13 @@ static int ati_remote2_set_mode_mask(const char *val,
>         return ati_remote2_set_mask(val, kp, ATI_REMOTE2_MAX_MODE_MASK);
>  }
>
> -static int ati_remote2_get_mode_mask(char *buffer,
> +static int ati_remote2_get_mode_mask(struct seq_buf *buffer,
>                                      const struct kernel_param *kp)
>  {
>         pr_debug("%s()\n", __func__);
>
> -       return sprintf(buffer, "0x%02x\n", *(unsigned int *)kp->arg);
> +       seq_buf_printf(buffer, "0x%02x\n", *(unsigned int *)kp->arg);
> +       return 0;
>  }
>
>  static unsigned int channel_mask =3D ATI_REMOTE2_MAX_CHANNEL_MASK;
> diff --git a/drivers/input/mouse/psmouse-base.c b/drivers/input/mouse/psm=
ouse-base.c
> index f9ebb1fd0b6f..39a9b87e69d1 100644
> --- a/drivers/input/mouse/psmouse-base.c
> +++ b/drivers/input/mouse/psmouse-base.c
> @@ -44,7 +44,8 @@ MODULE_LICENSE("GPL");
>
>  static unsigned int psmouse_max_proto =3D PSMOUSE_AUTO;
>  static int psmouse_set_maxproto(const char *val, const struct kernel_par=
am *);
> -static int psmouse_get_maxproto(char *buffer, const struct kernel_param =
*kp);
> +static int psmouse_get_maxproto(struct seq_buf *buffer,
> +                               const struct kernel_param *kp);
>  static DEFINE_KERNEL_PARAM_OPS(param_ops_proto_abbrev, psmouse_set_maxpr=
oto,
>                                psmouse_get_maxproto);
>  #define param_check_proto_abbrev(name, p)      __param_check(name, p, un=
signed int)
> @@ -1994,11 +1995,13 @@ static int psmouse_set_maxproto(const char *val, =
const struct kernel_param *kp)
>         return 0;
>  }
>
> -static int psmouse_get_maxproto(char *buffer, const struct kernel_param =
*kp)
> +static int psmouse_get_maxproto(struct seq_buf *buffer,
> +                               const struct kernel_param *kp)
>  {
>         int type =3D *((unsigned int *)kp->arg);
>
> -       return sprintf(buffer, "%s\n", psmouse_protocol_by_type(type)->na=
me);
> +       seq_buf_printf(buffer, "%s\n", psmouse_protocol_by_type(type)->na=
me);
> +       return 0;
>  }
>
>  static int __init psmouse_init(void)
> diff --git a/drivers/md/md.c b/drivers/md/md.c
> index 8b568eee8743..ce3eb1396ad0 100644
> --- a/drivers/md/md.c
> +++ b/drivers/md/md.c
> @@ -10989,9 +10989,10 @@ static __exit void md_exit(void)
>  subsys_initcall(md_init);
>  module_exit(md_exit)
>
> -static int get_ro(char *buffer, const struct kernel_param *kp)
> +static int get_ro(struct seq_buf *buffer, const struct kernel_param *kp)
>  {
> -       return sprintf(buffer, "%d\n", start_readonly);
> +       seq_buf_printf(buffer, "%d\n", start_readonly);
> +       return 0;
>  }
>  static int set_ro(const char *val, const struct kernel_param *kp)
>  {
> diff --git a/drivers/media/pci/tw686x/tw686x-core.c b/drivers/media/pci/t=
w686x/tw686x-core.c
> index a10e38221817..35a6ff8d77fc 100644
> --- a/drivers/media/pci/tw686x/tw686x-core.c
> +++ b/drivers/media/pci/tw686x/tw686x-core.c
> @@ -69,9 +69,11 @@ static const char *dma_mode_name(unsigned int mode)
>         }
>  }
>
> -static int tw686x_dma_mode_get(char *buffer, const struct kernel_param *=
kp)
> +static int tw686x_dma_mode_get(struct seq_buf *buffer,
> +                              const struct kernel_param *kp)
>  {
> -       return sprintf(buffer, "%s", dma_mode_name(dma_mode));
> +       seq_buf_printf(buffer, "%s", dma_mode_name(dma_mode));
> +       return 0;
>  }
>
>  static int tw686x_dma_mode_set(const char *val, const struct kernel_para=
m *kp)
> diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.=
c
> index f7362377e427..e0c87447074d 100644
> --- a/drivers/nvme/host/multipath.c
> +++ b/drivers/nvme/host/multipath.c
> @@ -85,9 +85,10 @@ static int nvme_set_iopolicy(const char *val, const st=
ruct kernel_param *kp)
>         return 0;
>  }
>
> -static int nvme_get_iopolicy(char *buf, const struct kernel_param *kp)
> +static int nvme_get_iopolicy(struct seq_buf *buf, const struct kernel_pa=
ram *kp)
>  {
> -       return sprintf(buf, "%s\n", nvme_iopolicy_names[iopolicy]);
> +       seq_buf_printf(buf, "%s\n", nvme_iopolicy_names[iopolicy]);
> +       return 0;
>  }
>
>  module_param_call(iopolicy, nvme_set_iopolicy, nvme_get_iopolicy,
> diff --git a/drivers/power/supply/test_power.c b/drivers/power/supply/tes=
t_power.c
> index 0bf2bef3383a..9dcd588ab5c9 100644
> --- a/drivers/power/supply/test_power.c
> +++ b/drivers/power/supply/test_power.c
> @@ -490,10 +490,12 @@ static int param_set_ac_online(const char *key, con=
st struct kernel_param *kp)
>         return 0;
>  }
>
> -static int param_get_ac_online(char *buffer, const struct kernel_param *=
kp)
> +static int param_get_ac_online(struct seq_buf *buffer,
> +                              const struct kernel_param *kp)
>  {
> -       return sprintf(buffer, "%s\n",
> -                       map_get_key(map_ac_online, ac_online, "unknown"))=
;
> +       seq_buf_printf(buffer, "%s\n",
> +                      map_get_key(map_ac_online, ac_online, "unknown"));
> +       return 0;
>  }
>
>  static int param_set_usb_online(const char *key, const struct kernel_par=
am *kp)
> @@ -503,10 +505,12 @@ static int param_set_usb_online(const char *key, co=
nst struct kernel_param *kp)
>         return 0;
>  }
>
> -static int param_get_usb_online(char *buffer, const struct kernel_param =
*kp)
> +static int param_get_usb_online(struct seq_buf *buffer,
> +                               const struct kernel_param *kp)
>  {
> -       return sprintf(buffer, "%s\n",
> -                       map_get_key(map_ac_online, usb_online, "unknown")=
);
> +       seq_buf_printf(buffer, "%s\n",
> +                      map_get_key(map_ac_online, usb_online, "unknown"))=
;
> +       return 0;
>  }
>
>  static int param_set_battery_status(const char *key,
> @@ -517,10 +521,12 @@ static int param_set_battery_status(const char *key=
,
>         return 0;
>  }
>
> -static int param_get_battery_status(char *buffer, const struct kernel_pa=
ram *kp)
> +static int param_get_battery_status(struct seq_buf *buffer,
> +                                   const struct kernel_param *kp)
>  {
> -       return sprintf(buffer, "%s\n",
> -                       map_get_key(map_ac_online, battery_status, "unkno=
wn"));
> +       seq_buf_printf(buffer, "%s\n",
> +                      map_get_key(map_ac_online, battery_status, "unknow=
n"));
> +       return 0;
>  }
>
>  static int param_set_battery_health(const char *key,
> @@ -531,10 +537,12 @@ static int param_set_battery_health(const char *key=
,
>         return 0;
>  }
>
> -static int param_get_battery_health(char *buffer, const struct kernel_pa=
ram *kp)
> +static int param_get_battery_health(struct seq_buf *buffer,
> +                                   const struct kernel_param *kp)
>  {
> -       return sprintf(buffer, "%s\n",
> -                       map_get_key(map_ac_online, battery_health, "unkno=
wn"));
> +       seq_buf_printf(buffer, "%s\n",
> +                      map_get_key(map_ac_online, battery_health, "unknow=
n"));
> +       return 0;
>  }
>
>  static int param_set_battery_present(const char *key,
> @@ -545,11 +553,12 @@ static int param_set_battery_present(const char *ke=
y,
>         return 0;
>  }
>
> -static int param_get_battery_present(char *buffer,
> +static int param_get_battery_present(struct seq_buf *buffer,
>                                         const struct kernel_param *kp)
>  {
> -       return sprintf(buffer, "%s\n",
> -                       map_get_key(map_ac_online, battery_present, "unkn=
own"));
> +       seq_buf_printf(buffer, "%s\n",
> +                      map_get_key(map_ac_online, battery_present, "unkno=
wn"));
> +       return 0;
>  }
>
>  static int param_set_battery_technology(const char *key,
> @@ -561,12 +570,12 @@ static int param_set_battery_technology(const char =
*key,
>         return 0;
>  }
>
> -static int param_get_battery_technology(char *buffer,
> +static int param_get_battery_technology(struct seq_buf *buffer,
>                                         const struct kernel_param *kp)
>  {
> -       return sprintf(buffer, "%s\n",
> -                       map_get_key(map_ac_online, battery_technology,
> -                                       "unknown"));
> +       seq_buf_printf(buffer, "%s\n",
> +                      map_get_key(map_ac_online, battery_technology, "un=
known"));
> +       return 0;
>  }
>
>  static int param_set_battery_capacity(const char *key,
> diff --git a/drivers/target/target_core_user.c b/drivers/target/target_co=
re_user.c
> index 676a12b44e88..5e8817a63726 100644
> --- a/drivers/target/target_core_user.c
> +++ b/drivers/target/target_core_user.c
> @@ -249,10 +249,11 @@ static int tcmu_set_global_max_data_area(const char=
 *str,
>         return 0;
>  }
>
> -static int tcmu_get_global_max_data_area(char *buffer,
> +static int tcmu_get_global_max_data_area(struct seq_buf *buffer,
>                                          const struct kernel_param *kp)
>  {
> -       return sprintf(buffer, "%d\n", TCMU_PAGES_TO_MBS(tcmu_global_max_=
pages));
> +       seq_buf_printf(buffer, "%d\n", TCMU_PAGES_TO_MBS(tcmu_global_max_=
pages));
> +       return 0;
>  }
>
>  static DEFINE_KERNEL_PARAM_OPS(tcmu_global_max_data_area_op,
> @@ -265,11 +266,12 @@ MODULE_PARM_DESC(global_max_data_area_mb,
>                  "Max MBs allowed to be allocated to all the tcmu device'=
s "
>                  "data areas.");
>
> -static int tcmu_get_block_netlink(char *buffer,
> +static int tcmu_get_block_netlink(struct seq_buf *buffer,
>                                   const struct kernel_param *kp)
>  {
> -       return sprintf(buffer, "%s\n", tcmu_netlink_blocked ?
> -                      "blocked" : "unblocked");
> +       seq_buf_printf(buffer, "%s\n",
> +                      tcmu_netlink_blocked ? "blocked" : "unblocked");
> +       return 0;
>  }
>
>  static int tcmu_set_block_netlink(const char *str,
> diff --git a/drivers/thermal/intel/int340x_thermal/processor_thermal_soc_=
slider.c b/drivers/thermal/intel/int340x_thermal/processor_thermal_soc_slid=
er.c
> index 68275c3f2c9b..1a68721748d9 100644
> --- a/drivers/thermal/intel/int340x_thermal/processor_thermal_soc_slider.=
c
> +++ b/drivers/thermal/intel/int340x_thermal/processor_thermal_soc_slider.=
c
> @@ -77,10 +77,12 @@ static int slider_def_balance_set(const char *arg, co=
nst struct kernel_param *kp
>         return ret;
>  }
>
> -static int slider_def_balance_get(char *buf, const struct kernel_param *=
kp)
> +static int slider_def_balance_get(struct seq_buf *buf,
> +                                 const struct kernel_param *kp)
>  {
>         guard(mutex)(&slider_param_lock);
> -       return sysfs_emit(buf, "%02x\n", slider_values[SOC_POWER_SLIDER_B=
ALANCE]);
> +       seq_buf_printf(buf, "%02x\n", slider_values[SOC_POWER_SLIDER_BALA=
NCE]);
> +       return 0;
>  }
>
>  static DEFINE_KERNEL_PARAM_OPS(slider_def_balance_ops, slider_def_balanc=
e_set,
> @@ -109,10 +111,12 @@ static int slider_def_offset_set(const char *arg, c=
onst struct kernel_param *kp)
>         return ret;
>  }
>
> -static int slider_def_offset_get(char *buf, const struct kernel_param *k=
p)
> +static int slider_def_offset_get(struct seq_buf *buf,
> +                                const struct kernel_param *kp)
>  {
>         guard(mutex)(&slider_param_lock);
> -       return sysfs_emit(buf, "%02x\n", slider_offset);
> +       seq_buf_printf(buf, "%02x\n", slider_offset);
> +       return 0;
>  }
>
>  static DEFINE_KERNEL_PARAM_OPS(slider_offset_ops, slider_def_offset_set,
> diff --git a/drivers/ufs/core/ufs-fault-injection.c b/drivers/ufs/core/uf=
s-fault-injection.c
> index 7d2873da7dc5..88f348b41614 100644
> --- a/drivers/ufs/core/ufs-fault-injection.c
> +++ b/drivers/ufs/core/ufs-fault-injection.c
> @@ -8,7 +8,7 @@
>  #include <ufs/ufshcd.h>
>  #include "ufs-fault-injection.h"
>
> -static int ufs_fault_get(char *buffer, const struct kernel_param *kp);
> +static int ufs_fault_get(struct seq_buf *buffer, const struct kernel_par=
am *kp);
>  static int ufs_fault_set(const char *val, const struct kernel_param *kp)=
;
>
>  static DEFINE_KERNEL_PARAM_OPS(ufs_fault_ops, ufs_fault_set, ufs_fault_g=
et);
> @@ -31,11 +31,12 @@ MODULE_PARM_DESC(timeout,
>         "Fault injection. timeout=3D<interval>,<probability>,<space>,<tim=
es>");
>  static DECLARE_FAULT_ATTR(ufs_timeout_attr);
>
> -static int ufs_fault_get(char *buffer, const struct kernel_param *kp)
> +static int ufs_fault_get(struct seq_buf *buffer, const struct kernel_par=
am *kp)
>  {
>         const char *fault_str =3D kp->arg;
>
> -       return sysfs_emit(buffer, "%s\n", fault_str);
> +       seq_buf_printf(buffer, "%s\n", fault_str);
> +       return 0;
>  }
>
>  static int ufs_fault_set(const char *val, const struct kernel_param *kp)
> diff --git a/drivers/vhost/scsi.c b/drivers/vhost/scsi.c
> index fd52f2213e27..23ca63ebf3d2 100644
> --- a/drivers/vhost/scsi.c
> +++ b/drivers/vhost/scsi.c
> @@ -81,10 +81,11 @@ static int vhost_scsi_set_inline_sg_cnt(const char *b=
uf,
>  }
>  #endif
>
> -static int vhost_scsi_get_inline_sg_cnt(char *buf,
> +static int vhost_scsi_get_inline_sg_cnt(struct seq_buf *buf,
>                                         const struct kernel_param *kp)
>  {
> -       return sprintf(buf, "%u\n", vhost_scsi_inline_sg_cnt);
> +       seq_buf_printf(buf, "%u\n", vhost_scsi_inline_sg_cnt);
> +       return 0;
>  }
>
>  static DEFINE_KERNEL_PARAM_OPS(vhost_scsi_inline_sg_cnt_op,
> diff --git a/fs/nfs/namespace.c b/fs/nfs/namespace.c
> index f2fba60dc5ed..5b7debe5274b 100644
> --- a/fs/nfs/namespace.c
> +++ b/fs/nfs/namespace.c
> @@ -358,7 +358,8 @@ static int param_set_nfs_timeout(const char *val, con=
st struct kernel_param *kp)
>         return 0;
>  }
>
> -static int param_get_nfs_timeout(char *buffer, const struct kernel_param=
 *kp)
> +static int param_get_nfs_timeout(struct seq_buf *buffer,
> +                                const struct kernel_param *kp)
>  {
>         long num =3D *((int *)kp->arg);
>
> @@ -369,7 +370,8 @@ static int param_get_nfs_timeout(char *buffer, const =
struct kernel_param *kp)
>                         num =3D (num + (HZ - 1)) / HZ;
>         } else
>                 num =3D -1;
> -       return sysfs_emit(buffer, "%li\n", num);
> +       seq_buf_printf(buffer, "%li\n", num);
> +       return 0;
>  }
>
>  static DEFINE_KERNEL_PARAM_OPS(param_ops_nfs_timeout, param_set_nfs_time=
out,
> diff --git a/fs/ocfs2/dlmfs/dlmfs.c b/fs/ocfs2/dlmfs/dlmfs.c
> index 5821e33df78f..8fd759d31ff9 100644
> --- a/fs/ocfs2/dlmfs/dlmfs.c
> +++ b/fs/ocfs2/dlmfs/dlmfs.c
> @@ -78,10 +78,11 @@ static int param_set_dlmfs_capabilities(const char *v=
al,
>         printk(KERN_ERR "%s: readonly parameter\n", kp->name);
>         return -EINVAL;
>  }
> -static int param_get_dlmfs_capabilities(char *buffer,
> +static int param_get_dlmfs_capabilities(struct seq_buf *buffer,
>                                         const struct kernel_param *kp)
>  {
> -       return sysfs_emit(buffer, DLMFS_CAPABILITIES);
> +       seq_buf_printf(buffer, DLMFS_CAPABILITIES);
> +       return 0;
>  }
>  module_param_call(capabilities, param_set_dlmfs_capabilities,
>                   param_get_dlmfs_capabilities, NULL, 0444);
> diff --git a/fs/overlayfs/copy_up.c b/fs/overlayfs/copy_up.c
> index 13cb60b52bd6..d9a21b813b4f 100644
> --- a/fs/overlayfs/copy_up.c
> +++ b/fs/overlayfs/copy_up.c
> @@ -28,9 +28,10 @@ static int ovl_ccup_set(const char *buf, const struct =
kernel_param *param)
>         return 0;
>  }
>
> -static int ovl_ccup_get(char *buf, const struct kernel_param *param)
> +static int ovl_ccup_get(struct seq_buf *buf, const struct kernel_param *=
param)
>  {
> -       return sprintf(buf, "N\n");
> +       seq_buf_printf(buf, "N\n");
> +       return 0;
>  }
>
>  module_param_call(check_copy_up, ovl_ccup_set, ovl_ccup_get, NULL, 0644)=
;
> diff --git a/kernel/locking/locktorture.c b/kernel/locking/locktorture.c
> index 38ae3b596ef2..9c9b6dc25888 100644
> --- a/kernel/locking/locktorture.c
> +++ b/kernel/locking/locktorture.c
> @@ -86,11 +86,13 @@ static int param_set_cpumask(const char *val, const s=
truct kernel_param *kp)
>  }
>
>  // Output a cpumask kernel parameter.
> -static int param_get_cpumask(char *buffer, const struct kernel_param *kp=
)
> +static int param_get_cpumask(struct seq_buf *buffer,
> +                            const struct kernel_param *kp)
>  {
>         cpumask_var_t *cm_bind =3D kp->arg;
>
> -       return sprintf(buffer, "%*pbl", cpumask_pr_args(*cm_bind));
> +       seq_buf_printf(buffer, "%*pbl", cpumask_pr_args(*cm_bind));
> +       return 0;
>  }
>
>  static bool cpumask_nonempty(cpumask_var_t mask)
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index e675d7f1b4ee..ffbbb7d4ff2a 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -3970,9 +3970,11 @@ static int param_set_do_rcu_barrier(const char *va=
l, const struct kernel_param *
>  /*
>   * Output the number of outstanding rcutree.do_rcu_barrier requests.
>   */
> -static int param_get_do_rcu_barrier(char *buffer, const struct kernel_pa=
ram *kp)
> +static int param_get_do_rcu_barrier(struct seq_buf *buffer,
> +                                   const struct kernel_param *kp)
>  {
> -       return sprintf(buffer, "%d\n", atomic_read((atomic_t *)kp->arg));
> +       seq_buf_printf(buffer, "%d\n", atomic_read((atomic_t *)kp->arg));
> +       return 0;
>  }
>
>  static DEFINE_KERNEL_PARAM_OPS(do_rcu_barrier_ops, param_set_do_rcu_barr=
ier,
> diff --git a/kernel/workqueue.c b/kernel/workqueue.c
> index 42562b811d94..3fe338d2ca64 100644
> --- a/kernel/workqueue.c
> +++ b/kernel/workqueue.c
> @@ -7157,9 +7157,11 @@ static int wq_affn_dfl_set(const char *val, const =
struct kernel_param *kp)
>         return 0;
>  }
>
> -static int wq_affn_dfl_get(char *buffer, const struct kernel_param *kp)
> +static int wq_affn_dfl_get(struct seq_buf *buffer,
> +                          const struct kernel_param *kp)
>  {
> -       return scnprintf(buffer, PAGE_SIZE, "%s\n", wq_affn_names[wq_affn=
_dfl]);
> +       seq_buf_printf(buffer, "%s\n", wq_affn_names[wq_affn_dfl]);
> +       return 0;
>  }
>
>  static DEFINE_KERNEL_PARAM_OPS(wq_affn_dfl_ops, wq_affn_dfl_set,
> diff --git a/lib/test_dynamic_debug.c b/lib/test_dynamic_debug.c
> index 30880b6c726a..70faf8ede76d 100644
> --- a/lib/test_dynamic_debug.c
> +++ b/lib/test_dynamic_debug.c
> @@ -18,10 +18,12 @@ static int param_set_do_prints(const char *instr, con=
st struct kernel_param *kp)
>         do_prints();
>         return 0;
>  }
> -static int param_get_do_prints(char *buffer, const struct kernel_param *=
kp)
> +static int param_get_do_prints(struct seq_buf *buffer,
> +                              const struct kernel_param *kp)
>  {
>         do_prints();
> -       return scnprintf(buffer, PAGE_SIZE, "did do_prints\n");
> +       seq_buf_printf(buffer, "did do_prints\n");
> +       return 0;
>  }
>  static DEFINE_KERNEL_PARAM_OPS(param_ops_do_prints, param_set_do_prints,
>                                param_get_do_prints);
> diff --git a/mm/damon/lru_sort.c b/mm/damon/lru_sort.c
> index 5feb93c5262e..84e607f76126 100644
> --- a/mm/damon/lru_sort.c
> +++ b/mm/damon/lru_sort.c
> @@ -438,10 +438,11 @@ static int damon_lru_sort_enabled_store(const char =
*val,
>         return damon_lru_sort_turn(enabled);
>  }
>
> -static int damon_lru_sort_enabled_load(char *buffer,
> -               const struct kernel_param *kp)
> +static int damon_lru_sort_enabled_load(struct seq_buf *buffer,
> +                                      const struct kernel_param *kp)
>  {
> -       return sprintf(buffer, "%c\n", damon_lru_sort_enabled() ? 'Y' : '=
N');
> +       seq_buf_printf(buffer, "%c\n", damon_lru_sort_enabled() ? 'Y' : '=
N');
> +       return 0;
>  }
>
>  static DEFINE_KERNEL_PARAM_OPS(enabled_param_ops, damon_lru_sort_enabled=
_store,
> @@ -461,8 +462,8 @@ static int damon_lru_sort_kdamond_pid_store(const cha=
r *val,
>         return 0;
>  }
>
> -static int damon_lru_sort_kdamond_pid_load(char *buffer,
> -               const struct kernel_param *kp)
> +static int damon_lru_sort_kdamond_pid_load(struct seq_buf *buffer,
> +                                          const struct kernel_param *kp)
>  {
>         int kdamond_pid =3D -1;
>
> @@ -471,7 +472,8 @@ static int damon_lru_sort_kdamond_pid_load(char *buff=
er,
>                 if (kdamond_pid < 0)
>                         kdamond_pid =3D -1;
>         }
> -       return sprintf(buffer, "%d\n", kdamond_pid);
> +       seq_buf_printf(buffer, "%d\n", kdamond_pid);
> +       return 0;
>  }
>
>  static DEFINE_KERNEL_PARAM_OPS(kdamond_pid_param_ops,
> diff --git a/mm/damon/reclaim.c b/mm/damon/reclaim.c
> index 27e772b095fa..546bdf356a40 100644
> --- a/mm/damon/reclaim.c
> +++ b/mm/damon/reclaim.c
> @@ -340,10 +340,11 @@ static int damon_reclaim_enabled_store(const char *=
val,
>         return damon_reclaim_turn(enabled);
>  }
>
> -static int damon_reclaim_enabled_load(char *buffer,
> -               const struct kernel_param *kp)
> +static int damon_reclaim_enabled_load(struct seq_buf *buffer,
> +                                     const struct kernel_param *kp)
>  {
> -       return sprintf(buffer, "%c\n", damon_reclaim_enabled() ? 'Y' : 'N=
');
> +       seq_buf_printf(buffer, "%c\n", damon_reclaim_enabled() ? 'Y' : 'N=
');
> +       return 0;
>  }
>
>  static DEFINE_KERNEL_PARAM_OPS(enabled_param_ops, damon_reclaim_enabled_=
store,
> @@ -363,8 +364,8 @@ static int damon_reclaim_kdamond_pid_store(const char=
 *val,
>         return 0;
>  }
>
> -static int damon_reclaim_kdamond_pid_load(char *buffer,
> -               const struct kernel_param *kp)
> +static int damon_reclaim_kdamond_pid_load(struct seq_buf *buffer,
> +                                         const struct kernel_param *kp)
>  {
>         int kdamond_pid =3D -1;
>
> @@ -373,7 +374,8 @@ static int damon_reclaim_kdamond_pid_load(char *buffe=
r,
>                 if (kdamond_pid < 0)
>                         kdamond_pid =3D -1;
>         }
> -       return sprintf(buffer, "%d\n", kdamond_pid);
> +       seq_buf_printf(buffer, "%d\n", kdamond_pid);
> +       return 0;
>  }
>
>  static DEFINE_KERNEL_PARAM_OPS(kdamond_pid_param_ops,
> diff --git a/mm/damon/stat.c b/mm/damon/stat.c
> index 6eb548793802..70d6b477fc0b 100644
> --- a/mm/damon/stat.c
> +++ b/mm/damon/stat.c
> @@ -19,8 +19,8 @@
>  static int damon_stat_enabled_store(
>                 const char *val, const struct kernel_param *kp);
>
> -static int damon_stat_enabled_load(char *buffer,
> -               const struct kernel_param *kp);
> +static int damon_stat_enabled_load(struct seq_buf *buffer,
> +                                  const struct kernel_param *kp);
>
>  static DEFINE_KERNEL_PARAM_OPS(enabled_param_ops, damon_stat_enabled_sto=
re,
>                                damon_stat_enabled_load);
> @@ -306,9 +306,11 @@ static int damon_stat_enabled_store(
>         return 0;
>  }
>
> -static int damon_stat_enabled_load(char *buffer, const struct kernel_par=
am *kp)
> +static int damon_stat_enabled_load(struct seq_buf *buffer,
> +                                  const struct kernel_param *kp)
>  {
> -       return sprintf(buffer, "%c\n", damon_stat_enabled() ? 'Y' : 'N');
> +       seq_buf_printf(buffer, "%c\n", damon_stat_enabled() ? 'Y' : 'N');
> +       return 0;
>  }
>
>  static int __init damon_stat_init(void)
> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> index 42e0cf313281..887c18a193ac 100644
> --- a/mm/memory_hotplug.c
> +++ b/mm/memory_hotplug.c
> @@ -100,13 +100,17 @@ static int set_memmap_mode(const char *val, const s=
truct kernel_param *kp)
>         return 0;
>  }
>
> -static int get_memmap_mode(char *buffer, const struct kernel_param *kp)
> +static int get_memmap_mode(struct seq_buf *buffer,
> +                          const struct kernel_param *kp)
>  {
>         int mode =3D *((int *)kp->arg);
>
> -       if (mode =3D=3D MEMMAP_ON_MEMORY_FORCE)
> -               return sprintf(buffer, "force\n");
> -       return sprintf(buffer, "%c\n", mode ? 'Y' : 'N');
> +       if (mode =3D=3D MEMMAP_ON_MEMORY_FORCE) {
> +               seq_buf_printf(buffer, "force\n");
> +               return 0;
> +       }
> +       seq_buf_printf(buffer, "%c\n", mode ? 'Y' : 'N');
> +       return 0;
>  }
>
>  static DEFINE_KERNEL_PARAM_OPS(memmap_mode_ops, set_memmap_mode,
> @@ -147,9 +151,11 @@ static int set_online_policy(const char *val, const =
struct kernel_param *kp)
>         return 0;
>  }
>
> -static int get_online_policy(char *buffer, const struct kernel_param *kp=
)
> +static int get_online_policy(struct seq_buf *buffer,
> +                            const struct kernel_param *kp)
>  {
> -       return sprintf(buffer, "%s\n", online_policy_to_str[*((int *)kp->=
arg)]);
> +       seq_buf_printf(buffer, "%s\n", online_policy_to_str[*((int *)kp->=
arg)]);
> +       return 0;
>  }
>
>  /*
> diff --git a/net/ceph/ceph_common.c b/net/ceph/ceph_common.c
> index 633202a99e4a..583b11a2489c 100644
> --- a/net/ceph/ceph_common.c
> +++ b/net/ceph/ceph_common.c
> @@ -47,10 +47,11 @@ bool libceph_compatible(void *data)
>  }
>  EXPORT_SYMBOL(libceph_compatible);
>
> -static int param_get_supported_features(char *buffer,
> +static int param_get_supported_features(struct seq_buf *buffer,
>                                         const struct kernel_param *kp)
>  {
> -       return sprintf(buffer, "0x%llx", CEPH_FEATURES_SUPPORTED_DEFAULT)=
;
> +       seq_buf_printf(buffer, "0x%llx", CEPH_FEATURES_SUPPORTED_DEFAULT)=
;
> +       return 0;
>  }
>  static DEFINE_KERNEL_PARAM_OPS(param_ops_supported_features, NULL,
>                                param_get_supported_features);
> diff --git a/net/sunrpc/auth.c b/net/sunrpc/auth.c
> index 64a3e894fd4c..5a2b64dcf9e5 100644
> --- a/net/sunrpc/auth.c
> +++ b/net/sunrpc/auth.c
> @@ -73,12 +73,14 @@ static int param_set_hashtbl_sz(const char *val, cons=
t struct kernel_param *kp)
>         return -EINVAL;
>  }
>
> -static int param_get_hashtbl_sz(char *buffer, const struct kernel_param =
*kp)
> +static int param_get_hashtbl_sz(struct seq_buf *buffer,
> +                               const struct kernel_param *kp)
>  {
>         unsigned int nbits;
>
>         nbits =3D *(unsigned int *)kp->arg;
> -       return sprintf(buffer, "%u\n", 1U << nbits);
> +       seq_buf_printf(buffer, "%u\n", 1U << nbits);
> +       return 0;
>  }
>
>  #define param_check_hashtbl_sz(name, p) __param_check(name, p, unsigned =
int);
> diff --git a/net/sunrpc/svc.c b/net/sunrpc/svc.c
> index 576fa42e7abf..26b85077ecc8 100644
> --- a/net/sunrpc/svc.c
> +++ b/net/sunrpc/svc.c
> @@ -148,7 +148,7 @@ sunrpc_get_pool_mode(char *buf, size_t size)
>  EXPORT_SYMBOL(sunrpc_get_pool_mode);
>
>  static int
> -param_get_pool_mode(char *buf, const struct kernel_param *kp)
> +param_get_pool_mode(struct seq_buf *buf, const struct kernel_param *kp)
>  {
>         char str[16];
>         int len;
> @@ -162,7 +162,8 @@ param_get_pool_mode(char *buf, const struct kernel_pa=
ram *kp)
>         str[len] =3D '\n';
>         str[len + 1] =3D '\0';
>
> -       return sysfs_emit(buf, "%s", str);
> +       seq_buf_printf(buf, "%s", str);
> +       return 0;
>  }
>
>  module_param_call(pool_mode, param_set_pool_mode, param_get_pool_mode,
> diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
> index a6815b4bd0da..748d08c57f60 100644
> --- a/security/apparmor/lsm.c
> +++ b/security/apparmor/lsm.c
> @@ -1797,10 +1797,11 @@ static int param_set_debug(const char *val, const=
 struct kernel_param *kp);
>  static int param_get_debug(struct seq_buf *buffer, const struct kernel_p=
aram *kp);
>
>  static int param_set_audit(const char *val, const struct kernel_param *k=
p);
> -static int param_get_audit(char *buffer, const struct kernel_param *kp);
> +static int param_get_audit(struct seq_buf *buffer,
> +                          const struct kernel_param *kp);
>
>  static int param_set_mode(const char *val, const struct kernel_param *kp=
);
> -static int param_get_mode(char *buffer, const struct kernel_param *kp);
> +static int param_get_mode(struct seq_buf *buffer, const struct kernel_pa=
ram *kp);
>
>  /* Flag values, also controllable via /sys/module/apparmor/parameters
>   * We define special types as we want to do additional mediation.
> @@ -2050,13 +2051,15 @@ static int param_set_debug(const char *val, const=
 struct kernel_param *kp)
>         return 0;
>  }
>
> -static int param_get_audit(char *buffer, const struct kernel_param *kp)
> +static int param_get_audit(struct seq_buf *buffer,
> +                          const struct kernel_param *kp)
>  {
>         if (!apparmor_enabled)
>                 return -EINVAL;
>         if (apparmor_initialized && !aa_current_policy_view_capable(NULL)=
)
>                 return -EPERM;
> -       return sysfs_emit(buffer, "%s\n", audit_mode_names[aa_g_audit]);
> +       seq_buf_printf(buffer, "%s\n", audit_mode_names[aa_g_audit]);
> +       return 0;
>  }
>
>  static int param_set_audit(const char *val, const struct kernel_param *k=
p)
> @@ -2078,13 +2081,14 @@ static int param_set_audit(const char *val, const=
 struct kernel_param *kp)
>         return 0;
>  }
>
> -static int param_get_mode(char *buffer, const struct kernel_param *kp)
> +static int param_get_mode(struct seq_buf *buffer, const struct kernel_pa=
ram *kp)
>  {
>         if (!apparmor_enabled)
>                 return -EINVAL;
>         if (apparmor_initialized && !aa_current_policy_view_capable(NULL)=
)
>                 return -EPERM;
> -       return sysfs_emit(buffer, "%s\n", aa_profile_mode_names[aa_g_prof=
ile_mode]);
> +       seq_buf_printf(buffer, "%s\n", aa_profile_mode_names[aa_g_profile=
_mode]);
> +       return 0;
>  }
>
>  static int param_set_mode(const char *val, const struct kernel_param *kp=
)
> --
> 2.34.1
>

