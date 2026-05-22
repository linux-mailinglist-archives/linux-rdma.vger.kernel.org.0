Return-Path: <linux-rdma+bounces-21161-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QAVpCyeNEGrEZQYAu9opvQ
	(envelope-from <linux-rdma+bounces-21161-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 22 May 2026 19:06:47 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B3B875B7EC5
	for <lists+linux-rdma@lfdr.de>; Fri, 22 May 2026 19:06:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id EB67A3003D2F
	for <lists+linux-rdma@lfdr.de>; Fri, 22 May 2026 17:06:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44E9747D932;
	Fri, 22 May 2026 17:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O7jVfnwK"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2761A47A0DC
	for <linux-rdma@vger.kernel.org>; Fri, 22 May 2026 17:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779469569; cv=none; b=YLjzGXPb/tvTvO5LFgb5V9VF4KE9szbOBH9gQPIhEot44NK9CHjPP8Kr1RNtdgqmdiyqGNXlsMuGE2ZitmKWF0fnFDd8wVeShKxXeLz51Ks66c8l4Wwe85RPKKIuczoaiiKezLaDYrtmEYqlOt3eSqtoQMMdE513AFM+lC0SvRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779469569; c=relaxed/simple;
	bh=f4HCJ2OM7YbYxnr4uCU99lpdNpAb7NbwMBpIeXtirZA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hfYap7kbr13X8nPfRxlarfQDBOxE0QUiRwQ0ENa7vX2qyvo2b1ini5LRufTq/OUn7rsVUoH3hqLshdnfcapYq7Djf/Cl55TCUq9lp+KjiT0zJ9LaaqM8SHWseCbQhkWMxCzkVXIwBxvAQ1YzbyQIuHUsocP1cHQUydGrEG6j9OA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O7jVfnwK; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C6DF1F01806
	for <linux-rdma@vger.kernel.org>; Fri, 22 May 2026 17:05:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779469559;
	bh=vhBz6+FER7gVadySruFBg+pjjqPZJ5HC+vntfE1g4Xw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=O7jVfnwKPdJszvk1wSKfHP8MV59g4SFWi+mjuuxf+o7vj+nVAHkLpiOaaX3otgQu7
	 FbdoVR1UH1UXENQgWEm1qlnJ/jPkNbUFQ6kHYgb+einfs5eKvD9Ew/xxbu2gmK3sz1
	 XM6rHBfJ5VdQcHrjdhjavSQAtEY8e4iPqD6inMqubZ6GK4TayOAu66oWE9eR/ZJ5Et
	 8rdWWRsKaFyh+F15/s/ixNRWf25AYkhKhKYXHvOuLJuOBAgkMvqg4+N1qvUPh9S2NB
	 QNIrwlN6EyrVlmX9b5Lxs1BHWgd2cI/mF1gNDo0OLwo23WxQ7ahyTXH/C4pITYaMWh
	 nuXyw8OsXnONQ==
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5a995ab70d1so9935097e87.3
        for <linux-rdma@vger.kernel.org>; Fri, 22 May 2026 10:05:59 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ8zK3fktH2my7034o3mjZLwzxGDKtLBBL/ao5Z8m3hITUhM1man512drM4KzsYqbm0osjfxSuTpGrlg@vger.kernel.org
X-Gm-Message-State: AOJu0YyNzNPamsoOFSfMYlrwrB5pJO6DKRbq6HZAqloYMv7SdqYxibrq
	bLPZGFFV4ZiAORFDaOJtwnYABJ+fx2pY0PksQot05xzDWR99RsKJB2uQZgeRBBv1TTKnXylna3T
	nJ6nQEo2yS5CnC7rFJF0TDLMqPwtI+To=
X-Received: by 2002:a05:6512:3b2c:b0:5aa:b6a:6027 with SMTP id
 2adb3069b0e04-5aa323e952emr1451843e87.44.1779469557331; Fri, 22 May 2026
 10:05:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260521133315.work.845-kees@kernel.org> <20260521133326.2465264-10-kees@kernel.org>
In-Reply-To: <20260521133326.2465264-10-kees@kernel.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 22 May 2026 19:05:43 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gzCFu8Simqco8QZPU3-jmUSxhK_zsx4FqCrgLXQ5-UvQ@mail.gmail.com>
X-Gm-Features: AVHnY4KZueAI2elz2nGM2Tw15Bwmvwem7axKj09aFX8s8cuqasGJRNZXvEKifnM
Message-ID: <CAJZ5v0gzCFu8Simqco8QZPU3-jmUSxhK_zsx4FqCrgLXQ5-UvQ@mail.gmail.com>
Subject: Re: [PATCH 10/11] treewide: Manually convert custom kernel_param_ops
 .get callbacks
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-21161-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,iscas.ac.cn,suse.com,nod.at,cambridgegreys.com,sipsolutions.net,minyard.net,cmu.edu,redhat.com,linux.intel.com,intel.com,ursulin.net,gmail.com,ffwll.ch,acm.org,ziepe.ca,ideasonboard.com,google.com,suse.de,hansenpartnership.com,oracle.com,arm.com,linuxfoundation.org,rowland.harvard.edu,linux.alibaba.com,akamai.com,antgroup.com,orcam.me.uk,infradead.org,linux.ibm.com,alien8.de,zytor.com,atomlin.com,linux-foundation.org,canonical.com,paul-moore.com,namei.org,hallyn.com,vger.kernel.org,googlegroups.com,kvack.org,lists.ubuntu.com,lists.infradead.org,lists.sourceforge.net,nongnu.org,lists.freedesktop.org,lists.ozlabs.org,lists.one-eyed-alien.net,lists.linux.dev];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rafael@kernel.org,linux-rdma@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCPT_COUNT_GT_50(0.00)[99];
	TAGGED_RCPT(0.00)[linux-rdma];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: B3B875B7EC5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, May 21, 2026 at 3:33=E2=80=AFPM Kees Cook <kees@kernel.org> wrote:
>
> Convert struct kernel_param_ops .get callbacks from legacy "char *" to
> "struct seq_buf *".
>
> Since seq_buf_printf() will return -1 on overflow, and struct
> kernel_param_ops .get callbacks are expected to truncate without error,
> we must ignore the return value from seq_buf_print() and always return 0
> (as the length is calculated in the common dispatcher code).
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
>  include/linux/dynamic_debug.h            |  8 ++-
>  arch/um/drivers/vfio_kern.c              |  3 +-
>  arch/um/drivers/virtio_uml.c             | 12 ++--
>  drivers/acpi/button.c                    | 19 ++++--
>  drivers/acpi/sysfs.c                     | 83 +++++++++++-------------
>  drivers/char/ipmi/ipmi_watchdog.c        | 33 ++++------
>  drivers/firmware/qemu_fw_cfg.c           | 34 +++++-----
>  drivers/gpu/drm/i915/i915_mitigations.c  | 26 ++++----
>  drivers/infiniband/ulp/srp/ib_srp.c      |  7 +-
>  drivers/media/usb/uvc/uvc_driver.c       |  8 ++-
>  drivers/pci/pcie/aspm.c                  | 17 +++--
>  drivers/scsi/fcoe/fcoe_transport.c       | 22 +++----
>  drivers/thermal/intel/intel_powerclamp.c | 14 ++--
>  drivers/tty/hvc/hvc_iucv.c               | 18 ++---
>  drivers/usb/storage/usb.c                | 20 +++---
>  drivers/virtio/virtio_mmio.c             | 21 +++---
>  lib/dynamic_debug.c                      | 10 ++-
>  17 files changed, 178 insertions(+), 177 deletions(-)
>
> diff --git a/include/linux/dynamic_debug.h b/include/linux/dynamic_debug.=
h
> index 05743900a116..999a25671b6a 100644
> --- a/include/linux/dynamic_debug.h
> +++ b/include/linux/dynamic_debug.h
> @@ -334,8 +334,10 @@ void __dynamic_ibdev_dbg(struct _ddebug *descriptor,
>  extern int ddebug_dyndbg_module_param_cb(char *param, char *val,
>                                         const char *modname);
>  struct kernel_param;
> +struct seq_buf;
>  int param_set_dyndbg_classes(const char *instr, const struct kernel_para=
m *kp);
> -int param_get_dyndbg_classes(char *buffer, const struct kernel_param *kp=
);
> +int param_get_dyndbg_classes(struct seq_buf *buffer,
> +                            const struct kernel_param *kp);
>
>  #else
>
> @@ -352,9 +354,11 @@ static inline int ddebug_dyndbg_module_param_cb(char=
 *param, char *val,
>  }
>
>  struct kernel_param;
> +struct seq_buf;
>  static inline int param_set_dyndbg_classes(const char *instr, const stru=
ct kernel_param *kp)
>  { return 0; }
> -static inline int param_get_dyndbg_classes(char *buffer, const struct ke=
rnel_param *kp)
> +static inline int param_get_dyndbg_classes(struct seq_buf *buffer,
> +                                          const struct kernel_param *kp)
>  { return 0; }
>
>  #endif
> diff --git a/arch/um/drivers/vfio_kern.c b/arch/um/drivers/vfio_kern.c
> index fb7988dc5482..7c1119d0d9c1 100644
> --- a/arch/um/drivers/vfio_kern.c
> +++ b/arch/um/drivers/vfio_kern.c
> @@ -623,7 +623,8 @@ static int uml_vfio_cmdline_set(const char *device, c=
onst struct kernel_param *k
>         return 0;
>  }
>
> -static int uml_vfio_cmdline_get(char *buffer, const struct kernel_param =
*kp)
> +static int uml_vfio_cmdline_get(struct seq_buf *buffer,
> +                               const struct kernel_param *kp)
>  {
>         return 0;
>  }
> diff --git a/arch/um/drivers/virtio_uml.c b/arch/um/drivers/virtio_uml.c
> index f9ae745f4586..cea806540625 100644
> --- a/arch/um/drivers/virtio_uml.c
> +++ b/arch/um/drivers/virtio_uml.c
> @@ -1379,23 +1379,21 @@ static int vu_cmdline_get_device(struct device *d=
ev, void *data)
>  {
>         struct platform_device *pdev =3D to_platform_device(dev);
>         struct virtio_uml_platform_data *pdata =3D pdev->dev.platform_dat=
a;
> -       char *buffer =3D data;
> -       unsigned int len =3D strlen(buffer);
> +       struct seq_buf *s =3D data;
>
> -       snprintf(buffer + len, PAGE_SIZE - len, "%s:%d:%d\n",
> -                pdata->socket_path, pdata->virtio_device_id, pdev->id);
> +       seq_buf_printf(s, "%s:%d:%d\n",
> +                      pdata->socket_path, pdata->virtio_device_id, pdev-=
>id);
>         return 0;
>  }
>
> -static int vu_cmdline_get(char *buffer, const struct kernel_param *kp)
> +static int vu_cmdline_get(struct seq_buf *buffer, const struct kernel_pa=
ram *kp)
>  {
>         guard(mutex)(&vu_cmdline_lock);
>
> -       buffer[0] =3D '\0';
>         if (vu_cmdline_parent_registered)
>                 device_for_each_child(&vu_cmdline_parent, buffer,
>                                       vu_cmdline_get_device);
> -       return strlen(buffer) + 1;
> +       return 0;
>  }
>
>  static DEFINE_KERNEL_PARAM_OPS(vu_cmdline_param_ops, vu_cmdline_set,
> diff --git a/drivers/acpi/button.c b/drivers/acpi/button.c
> index dc064a388c23..31c624bebc65 100644
> --- a/drivers/acpi/button.c
> +++ b/drivers/acpi/button.c
> @@ -715,19 +715,24 @@ static int param_set_lid_init_state(const char *val=
,
>         return 0;
>  }
>
> -static int param_get_lid_init_state(char *buf, const struct kernel_param=
 *kp)
> +static int param_get_lid_init_state(struct seq_buf *buf,
> +                                   const struct kernel_param *kp)
>  {
> -       int i, c =3D 0;
> +       int i;
>
> -       for (i =3D 0; i < ARRAY_SIZE(lid_init_state_str); i++)
> +       for (i =3D 0; i < ARRAY_SIZE(lid_init_state_str); i++) {
>                 if (i =3D=3D lid_init_state)
> -                       c +=3D sprintf(buf + c, "[%s] ", lid_init_state_s=
tr[i]);
> +                       seq_buf_printf(buf, "[%s] ", lid_init_state_str[i=
]);
>                 else
> -                       c +=3D sprintf(buf + c, "%s ", lid_init_state_str=
[i]);
> +                       seq_buf_printf(buf, "%s ", lid_init_state_str[i])=
;
> +       }
>
> -       buf[c - 1] =3D '\n'; /* Replace the final space with a newline */
> +       /* Replace the final space with a newline. */
> +       if (!seq_buf_has_overflowed(buf) && buf->len > 0 &&
> +           buf->buffer[buf->len - 1] =3D=3D ' ')
> +               buf->buffer[buf->len - 1] =3D '\n';
>
> -       return c;
> +       return 0;
>  }
>
>  module_param_call(lid_init_state,
> diff --git a/drivers/acpi/sysfs.c b/drivers/acpi/sysfs.c
> index 5247ed7e05cc..dff7cc7da8bf 100644
> --- a/drivers/acpi/sysfs.c
> +++ b/drivers/acpi/sysfs.c
> @@ -89,53 +89,49 @@ static const struct acpi_dlevel acpi_debug_levels[] =
=3D {
>         ACPI_DEBUG_INIT(ACPI_LV_EVENTS),
>  };
>
> -static int param_get_debug_layer(char *buffer, const struct kernel_param=
 *kp)
> +static int param_get_debug_layer(struct seq_buf *buffer,
> +                                const struct kernel_param *kp)
>  {
> -       int result =3D 0;
>         int i;
>
> -       result =3D sprintf(buffer, "%-25s\tHex        SET\n", "Descriptio=
n");
> +       seq_buf_printf(buffer, "%-25s\tHex        SET\n", "Description");
>
>         for (i =3D 0; i < ARRAY_SIZE(acpi_debug_layers); i++) {
> -               result +=3D sprintf(buffer + result, "%-25s\t0x%08lX [%c]=
\n",
> -                                 acpi_debug_layers[i].name,
> -                                 acpi_debug_layers[i].value,
> -                                 (acpi_dbg_layer & acpi_debug_layers[i].=
value)
> -                                 ? '*' : ' ');
> +               seq_buf_printf(buffer, "%-25s\t0x%08lX [%c]\n",
> +                              acpi_debug_layers[i].name,
> +                              acpi_debug_layers[i].value,
> +                              (acpi_dbg_layer & acpi_debug_layers[i].val=
ue)
> +                              ? '*' : ' ');
>         }
> -       result +=3D
> -           sprintf(buffer + result, "%-25s\t0x%08X [%c]\n", "ACPI_ALL_DR=
IVERS",
> -                   ACPI_ALL_DRIVERS,
> -                   (acpi_dbg_layer & ACPI_ALL_DRIVERS) =3D=3D
> -                   ACPI_ALL_DRIVERS ? '*' : (acpi_dbg_layer & ACPI_ALL_D=
RIVERS)
> -                   =3D=3D 0 ? ' ' : '-');
> -       result +=3D
> -           sprintf(buffer + result,
> -                   "--\ndebug_layer =3D 0x%08X ( * =3D enabled)\n",
> -                   acpi_dbg_layer);
> +       seq_buf_printf(buffer, "%-25s\t0x%08X [%c]\n", "ACPI_ALL_DRIVERS"=
,
> +                      ACPI_ALL_DRIVERS,
> +                      (acpi_dbg_layer & ACPI_ALL_DRIVERS) =3D=3D ACPI_AL=
L_DRIVERS
> +                      ? '*' : (acpi_dbg_layer & ACPI_ALL_DRIVERS) =3D=3D=
 0
> +                      ? ' ' : '-');
> +       seq_buf_printf(buffer, "--\ndebug_layer =3D 0x%08X ( * =3D enable=
d)\n",
> +                      acpi_dbg_layer);
>
> -       return result;
> +       return 0;
>  }
>
> -static int param_get_debug_level(char *buffer, const struct kernel_param=
 *kp)
> +static int param_get_debug_level(struct seq_buf *buffer,
> +                                const struct kernel_param *kp)
>  {
> -       int result =3D 0;
>         int i;
>
> -       result =3D sprintf(buffer, "%-25s\tHex        SET\n", "Descriptio=
n");
> +       seq_buf_printf(buffer, "%-25s\tHex        SET\n", "Description");
>
>         for (i =3D 0; i < ARRAY_SIZE(acpi_debug_levels); i++) {
> -               result +=3D sprintf(buffer + result, "%-25s\t0x%08lX [%c]=
\n",
> -                                 acpi_debug_levels[i].name,
> -                                 acpi_debug_levels[i].value,
> -                                 (acpi_dbg_level & acpi_debug_levels[i].=
value)
> -                                 ? '*' : ' ');
> +               seq_buf_printf(buffer, "%-25s\t0x%08lX [%c]\n",
> +                              acpi_debug_levels[i].name,
> +                              acpi_debug_levels[i].value,
> +                              (acpi_dbg_level & acpi_debug_levels[i].val=
ue)
> +                              ? '*' : ' ');
>         }
> -       result +=3D
> -           sprintf(buffer + result, "--\ndebug_level =3D 0x%08X (* =3D e=
nabled)\n",
> -                   acpi_dbg_level);
> +       seq_buf_printf(buffer, "--\ndebug_level =3D 0x%08X (* =3D enabled=
)\n",
> +                      acpi_dbg_level);
>
> -       return result;
> +       return 0;
>  }
>
>  static DEFINE_KERNEL_PARAM_OPS(param_ops_debug_layer, param_set_uint,
> @@ -247,16 +243,18 @@ static int param_set_trace_state(const char *val,
>         return 0;
>  }
>
> -static int param_get_trace_state(char *buffer, const struct kernel_param=
 *kp)
> +static int param_get_trace_state(struct seq_buf *buffer,
> +                                const struct kernel_param *kp)
>  {
>         if (!(acpi_gbl_trace_flags & ACPI_TRACE_ENABLED))
> -               return sprintf(buffer, "disable\n");
> -       if (!acpi_gbl_trace_method_name)
> -               return sprintf(buffer, "enable\n");
> -       if (acpi_gbl_trace_flags & ACPI_TRACE_ONESHOT)
> -               return sprintf(buffer, "method-once\n");
> +               seq_buf_printf(buffer, "disable\n");
> +       else if (!acpi_gbl_trace_method_name)
> +               seq_buf_printf(buffer, "enable\n");
> +       else if (acpi_gbl_trace_flags & ACPI_TRACE_ONESHOT)
> +               seq_buf_printf(buffer, "method-once\n");
>         else
> -               return sprintf(buffer, "method\n");
> +               seq_buf_printf(buffer, "method\n");
> +       return 0;
>  }
>
>  module_param_call(trace_state, param_set_trace_state, param_get_trace_st=
ate,
> @@ -272,14 +270,11 @@ MODULE_PARM_DESC(aml_debug_output,
>                  "To enable/disable the ACPI Debug Object output.");
>
>  /* /sys/module/acpi/parameters/acpica_version */
> -static int param_get_acpica_version(char *buffer,
> +static int param_get_acpica_version(struct seq_buf *buffer,
>                                     const struct kernel_param *kp)
>  {
> -       int result;
> -
> -       result =3D sprintf(buffer, "%x\n", ACPI_CA_VERSION);
> -
> -       return result;
> +       seq_buf_printf(buffer, "%x\n", ACPI_CA_VERSION);
> +       return 0;
>  }
>
>  module_param_call(acpica_version, NULL, param_get_acpica_version, NULL, =
0444);
> diff --git a/drivers/char/ipmi/ipmi_watchdog.c b/drivers/char/ipmi/ipmi_w=
atchdog.c
> index 91a99417d204..2bfec85ef331 100644
> --- a/drivers/char/ipmi/ipmi_watchdog.c
> +++ b/drivers/char/ipmi/ipmi_watchdog.c
> @@ -197,11 +197,11 @@ static DEFINE_KERNEL_PARAM_OPS(param_ops_timeout, s=
et_param_timeout,
>                                param_get_int);
>  #define param_check_timeout param_check_int
>
> -typedef int (*action_fn)(const char *intval, char *outval);
> +typedef int (*action_fn)(const char *intval, struct seq_buf *outval);
>
> -static int action_op(const char *inval, char *outval);
> -static int preaction_op(const char *inval, char *outval);
> -static int preop_op(const char *inval, char *outval);
> +static int action_op(const char *inval, struct seq_buf *outval);
> +static int preaction_op(const char *inval, struct seq_buf *outval);
> +static int preop_op(const char *inval, struct seq_buf *outval);
>  static void check_parms(void);
>
>  static int set_param_str(const char *val, const struct kernel_param *kp)
> @@ -227,20 +227,11 @@ static int set_param_str(const char *val, const str=
uct kernel_param *kp)
>         return rv;
>  }
>
> -static int get_param_str(char *buffer, const struct kernel_param *kp)
> +static int get_param_str(struct seq_buf *buffer, const struct kernel_par=
am *kp)
>  {
>         action_fn fn =3D (action_fn) kp->arg;
> -       int rv, len;
>
> -       rv =3D fn(NULL, buffer);
> -       if (rv)
> -               return rv;
> -
> -       len =3D strlen(buffer);
> -       buffer[len++] =3D '\n';
> -       buffer[len] =3D 0;
> -
> -       return len;
> +       return fn(NULL, buffer);
>  }
>
>
> @@ -1154,12 +1145,12 @@ static int action_op_set_val(const char *inval)
>         return 0;
>  }
>
> -static int action_op(const char *inval, char *outval)
> +static int action_op(const char *inval, struct seq_buf *outval)
>  {
>         int rv;
>
>         if (outval)
> -               strcpy(outval, action);
> +               seq_buf_printf(outval, "%s\n", action);
>
>         if (!inval)
>                 return 0;
> @@ -1186,12 +1177,12 @@ static int preaction_op_set_val(const char *inval=
)
>         return 0;
>  }
>
> -static int preaction_op(const char *inval, char *outval)
> +static int preaction_op(const char *inval, struct seq_buf *outval)
>  {
>         int rv;
>
>         if (outval)
> -               strcpy(outval, preaction);
> +               seq_buf_printf(outval, "%s\n", preaction);
>
>         if (!inval)
>                 return 0;
> @@ -1214,12 +1205,12 @@ static int preop_op_set_val(const char *inval)
>         return 0;
>  }
>
> -static int preop_op(const char *inval, char *outval)
> +static int preop_op(const char *inval, struct seq_buf *outval)
>  {
>         int rv;
>
>         if (outval)
> -               strcpy(outval, preop);
> +               seq_buf_printf(outval, "%s\n", preop);
>
>         if (!inval)
>                 return 0;
> diff --git a/drivers/firmware/qemu_fw_cfg.c b/drivers/firmware/qemu_fw_cf=
g.c
> index c87a5449ba8c..4ebc1e327849 100644
> --- a/drivers/firmware/qemu_fw_cfg.c
> +++ b/drivers/firmware/qemu_fw_cfg.c
> @@ -860,7 +860,8 @@ static int fw_cfg_cmdline_set(const char *arg, const =
struct kernel_param *kp)
>         return PTR_ERR_OR_ZERO(fw_cfg_cmdline_dev);
>  }
>
> -static int fw_cfg_cmdline_get(char *buf, const struct kernel_param *kp)
> +static int fw_cfg_cmdline_get(struct seq_buf *buf,
> +                             const struct kernel_param *kp)
>  {
>         /* stay silent if device was not configured via the command
>          * line, or if the parameter name (ioport/mmio) doesn't match
> @@ -873,22 +874,25 @@ static int fw_cfg_cmdline_get(char *buf, const stru=
ct kernel_param *kp)
>
>         switch (fw_cfg_cmdline_dev->num_resources) {
>         case 1:
> -               return snprintf(buf, PAGE_SIZE, PH_ADDR_PR_1_FMT,
> -                               resource_size(&fw_cfg_cmdline_dev->resour=
ce[0]),
> -                               fw_cfg_cmdline_dev->resource[0].start);
> +               seq_buf_printf(buf, PH_ADDR_PR_1_FMT,
> +                              resource_size(&fw_cfg_cmdline_dev->resourc=
e[0]),
> +                              fw_cfg_cmdline_dev->resource[0].start);
> +               return 0;
>         case 3:
> -               return snprintf(buf, PAGE_SIZE, PH_ADDR_PR_3_FMT,
> -                               resource_size(&fw_cfg_cmdline_dev->resour=
ce[0]),
> -                               fw_cfg_cmdline_dev->resource[0].start,
> -                               fw_cfg_cmdline_dev->resource[1].start,
> -                               fw_cfg_cmdline_dev->resource[2].start);
> +               seq_buf_printf(buf, PH_ADDR_PR_3_FMT,
> +                              resource_size(&fw_cfg_cmdline_dev->resourc=
e[0]),
> +                              fw_cfg_cmdline_dev->resource[0].start,
> +                              fw_cfg_cmdline_dev->resource[1].start,
> +                              fw_cfg_cmdline_dev->resource[2].start);
> +               return 0;
>         case 4:
> -               return snprintf(buf, PAGE_SIZE, PH_ADDR_PR_4_FMT,
> -                               resource_size(&fw_cfg_cmdline_dev->resour=
ce[0]),
> -                               fw_cfg_cmdline_dev->resource[0].start,
> -                               fw_cfg_cmdline_dev->resource[1].start,
> -                               fw_cfg_cmdline_dev->resource[2].start,
> -                               fw_cfg_cmdline_dev->resource[3].start);
> +               seq_buf_printf(buf, PH_ADDR_PR_4_FMT,
> +                              resource_size(&fw_cfg_cmdline_dev->resourc=
e[0]),
> +                              fw_cfg_cmdline_dev->resource[0].start,
> +                              fw_cfg_cmdline_dev->resource[1].start,
> +                              fw_cfg_cmdline_dev->resource[2].start,
> +                              fw_cfg_cmdline_dev->resource[3].start);
> +               return 0;
>         }
>
>         /* Should never get here */
> diff --git a/drivers/gpu/drm/i915/i915_mitigations.c b/drivers/gpu/drm/i9=
15/i915_mitigations.c
> index 6061eae84e9c..99cb38f355b6 100644
> --- a/drivers/gpu/drm/i915/i915_mitigations.c
> +++ b/drivers/gpu/drm/i915/i915_mitigations.c
> @@ -95,33 +95,37 @@ static int mitigations_set(const char *val, const str=
uct kernel_param *kp)
>         return 0;
>  }
>
> -static int mitigations_get(char *buffer, const struct kernel_param *kp)
> +static int mitigations_get(struct seq_buf *buffer,
> +                          const struct kernel_param *kp)
>  {
>         unsigned long local =3D READ_ONCE(mitigations);
> -       int count, i;
>         bool enable;
> +       int i;
>
> -       if (!local)
> -               return scnprintf(buffer, PAGE_SIZE, "%s\n", "off");
> +       if (!local) {
> +               seq_buf_printf(buffer, "%s\n", "off");
> +               return 0;
> +       }
>
>         if (local & BIT(BITS_PER_LONG - 1)) {
> -               count =3D scnprintf(buffer, PAGE_SIZE, "%s,", "auto");
> +               seq_buf_printf(buffer, "%s,", "auto");
>                 enable =3D false;
>         } else {
>                 enable =3D true;
> -               count =3D 0;
>         }
>
>         for (i =3D 0; i < ARRAY_SIZE(names); i++) {
>                 if ((local & BIT(i)) !=3D enable)
>                         continue;
> -
> -               count +=3D scnprintf(buffer + count, PAGE_SIZE - count,
> -                                  "%s%s,", enable ? "" : "!", names[i]);
> +               seq_buf_printf(buffer, "%s%s,", enable ? "" : "!", names[=
i]);
>         }
>
> -       buffer[count - 1] =3D '\n';
> -       return count;
> +       /* Replace the trailing comma with a newline. */
> +       if (!seq_buf_has_overflowed(buffer) && buffer->len > 0 &&
> +           buffer->buffer[buffer->len - 1] =3D=3D ',')
> +               buffer->buffer[buffer->len - 1] =3D '\n';
> +
> +       return 0;
>  }
>
>  static DEFINE_KERNEL_PARAM_OPS(ops, mitigations_set, mitigations_get);
> diff --git a/drivers/infiniband/ulp/srp/ib_srp.c b/drivers/infiniband/ulp=
/srp/ib_srp.c
> index a81515f52a4f..4f53e939eec1 100644
> --- a/drivers/infiniband/ulp/srp/ib_srp.c
> +++ b/drivers/infiniband/ulp/srp/ib_srp.c
> @@ -161,14 +161,15 @@ static struct ib_client srp_client =3D {
>
>  static struct ib_sa_client srp_sa_client;
>
> -static int srp_tmo_get(char *buffer, const struct kernel_param *kp)
> +static int srp_tmo_get(struct seq_buf *buffer, const struct kernel_param=
 *kp)
>  {
>         int tmo =3D *(int *)kp->arg;
>
>         if (tmo >=3D 0)
> -               return sysfs_emit(buffer, "%d\n", tmo);
> +               seq_buf_printf(buffer, "%d\n", tmo);
>         else
> -               return sysfs_emit(buffer, "off\n");
> +               seq_buf_printf(buffer, "off\n");
> +       return 0;
>  }
>
>  static int srp_tmo_set(const char *val, const struct kernel_param *kp)
> diff --git a/drivers/media/usb/uvc/uvc_driver.c b/drivers/media/usb/uvc/u=
vc_driver.c
> index 2338cab7fef9..1c5c40ce852d 100644
> --- a/drivers/media/usb/uvc/uvc_driver.c
> +++ b/drivers/media/usb/uvc/uvc_driver.c
> @@ -2451,12 +2451,14 @@ static int uvc_reset_resume(struct usb_interface =
*intf)
>   * Module parameters
>   */
>
> -static int uvc_clock_param_get(char *buffer, const struct kernel_param *=
kp)
> +static int uvc_clock_param_get(struct seq_buf *buffer,
> +                              const struct kernel_param *kp)
>  {
>         if (uvc_clock_param =3D=3D CLOCK_MONOTONIC)
> -               return sprintf(buffer, "CLOCK_MONOTONIC");
> +               seq_buf_printf(buffer, "CLOCK_MONOTONIC");
>         else
> -               return sprintf(buffer, "CLOCK_REALTIME");
> +               seq_buf_printf(buffer, "CLOCK_REALTIME");
> +       return 0;
>  }
>
>  static int uvc_clock_param_set(const char *val, const struct kernel_para=
m *kp)
> diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
> index 925373b98dff..af2dd668fe4d 100644
> --- a/drivers/pci/pcie/aspm.c
> +++ b/drivers/pci/pcie/aspm.c
> @@ -1572,16 +1572,19 @@ static int pcie_aspm_set_policy(const char *val,
>         return 0;
>  }
>
> -static int pcie_aspm_get_policy(char *buffer, const struct kernel_param =
*kp)
> +static int pcie_aspm_get_policy(struct seq_buf *buffer,
> +                               const struct kernel_param *kp)
>  {
> -       int i, cnt =3D 0;
> -       for (i =3D 0; i < ARRAY_SIZE(policy_str); i++)
> +       int i;
> +
> +       for (i =3D 0; i < ARRAY_SIZE(policy_str); i++) {
>                 if (i =3D=3D aspm_policy)
> -                       cnt +=3D sprintf(buffer + cnt, "[%s] ", policy_st=
r[i]);
> +                       seq_buf_printf(buffer, "[%s] ", policy_str[i]);
>                 else
> -                       cnt +=3D sprintf(buffer + cnt, "%s ", policy_str[=
i]);
> -       cnt +=3D sprintf(buffer + cnt, "\n");
> -       return cnt;
> +                       seq_buf_printf(buffer, "%s ", policy_str[i]);
> +       }
> +       seq_buf_putc(buffer, '\n');
> +       return 0;
>  }
>
>  module_param_call(policy, pcie_aspm_set_policy, pcie_aspm_get_policy,
> diff --git a/drivers/scsi/fcoe/fcoe_transport.c b/drivers/scsi/fcoe/fcoe_=
transport.c
> index 88d85fc9a52a..aa10514ec46e 100644
> --- a/drivers/scsi/fcoe/fcoe_transport.c
> +++ b/drivers/scsi/fcoe/fcoe_transport.c
> @@ -23,7 +23,8 @@ MODULE_LICENSE("GPL v2");
>
>  static int fcoe_transport_create(const char *, const struct kernel_param=
 *);
>  static int fcoe_transport_destroy(const char *, const struct kernel_para=
m *);
> -static int fcoe_transport_show(char *buffer, const struct kernel_param *=
kp);
> +static int fcoe_transport_show(struct seq_buf *buffer,
> +                              const struct kernel_param *kp);
>  static struct fcoe_transport *fcoe_transport_lookup(struct net_device *d=
evice);
>  static struct fcoe_transport *fcoe_netdev_map_lookup(struct net_device *=
device);
>  static int fcoe_transport_enable(const char *, const struct kernel_param=
 *);
> @@ -595,22 +596,21 @@ int fcoe_transport_detach(struct fcoe_transport *ft=
)
>  }
>  EXPORT_SYMBOL(fcoe_transport_detach);
>
> -static int fcoe_transport_show(char *buffer, const struct kernel_param *=
kp)
> +static int fcoe_transport_show(struct seq_buf *buffer,
> +                              const struct kernel_param *kp)
>  {
> -       int i, j;
>         struct fcoe_transport *ft =3D NULL;
>
> -       i =3D j =3D sprintf(buffer, "Attached FCoE transports:");
> +       seq_buf_printf(buffer, "Attached FCoE transports:");
>         mutex_lock(&ft_mutex);
> -       list_for_each_entry(ft, &fcoe_transports, list) {
> -               if (i >=3D PAGE_SIZE - IFNAMSIZ)
> -                       break;
> -               i +=3D snprintf(&buffer[i], IFNAMSIZ, "%s ", ft->name);
> +       if (list_empty(&fcoe_transports)) {
> +               seq_buf_printf(buffer, "none");
> +       } else {
> +               list_for_each_entry(ft, &fcoe_transports, list)
> +                       seq_buf_printf(buffer, "%s ", ft->name);
>         }
>         mutex_unlock(&ft_mutex);
> -       if (i =3D=3D j)
> -               i +=3D snprintf(&buffer[i], IFNAMSIZ, "none");
> -       return i;
> +       return 0;
>  }
>
>  static int __init fcoe_transport_init(void)
> diff --git a/drivers/thermal/intel/intel_powerclamp.c b/drivers/thermal/i=
ntel/intel_powerclamp.c
> index 98fbc6892714..50ec1a0ff1ab 100644
> --- a/drivers/thermal/intel/intel_powerclamp.c
> +++ b/drivers/thermal/intel/intel_powerclamp.c
> @@ -101,15 +101,13 @@ static int duration_set(const char *arg, const stru=
ct kernel_param *kp)
>         return ret;
>  }
>
> -static int duration_get(char *buf, const struct kernel_param *kp)
> +static int duration_get(struct seq_buf *buf, const struct kernel_param *=
kp)
>  {
> -       int ret;
> -
>         mutex_lock(&powerclamp_lock);
> -       ret =3D sysfs_emit(buf, "%d\n", duration / 1000);
> +       seq_buf_printf(buf, "%d\n", duration / 1000);
>         mutex_unlock(&powerclamp_lock);
>
> -       return ret;
> +       return 0;
>  }
>
>  static DEFINE_KERNEL_PARAM_OPS(duration_ops, duration_set, duration_get)=
;
> @@ -192,12 +190,14 @@ static int cpumask_set(const char *arg, const struc=
t kernel_param *kp)
>         return ret;
>  }
>
> -static int cpumask_get(char *buf, const struct kernel_param *kp)
> +static int cpumask_get(struct seq_buf *buf, const struct kernel_param *k=
p)
>  {
>         if (!cpumask_available(idle_injection_cpu_mask))
>                 return -ENODEV;
>
> -       return cpumap_print_to_pagebuf(false, buf, idle_injection_cpu_mas=
k);
> +       seq_buf_printf(buf, "%*pb\n", nr_cpu_ids,
> +                      cpumask_bits(idle_injection_cpu_mask));
> +       return 0;
>  }
>
>  static DEFINE_KERNEL_PARAM_OPS(cpumask_ops, cpumask_set, cpumask_get);
> diff --git a/drivers/tty/hvc/hvc_iucv.c b/drivers/tty/hvc/hvc_iucv.c
> index 29612a4a32cb..b27c1dfbd249 100644
> --- a/drivers/tty/hvc/hvc_iucv.c
> +++ b/drivers/tty/hvc/hvc_iucv.c
> @@ -1256,36 +1256,32 @@ static int param_set_vmidfilter(const char *val, =
const struct kernel_param *kp)
>
>  /**
>   * param_get_vmidfilter() - Get z/VM user ID filter
> - * @buffer:    Buffer to store z/VM user ID filter,
> - *             (buffer size assumption PAGE_SIZE)
> + * @buffer:    seq_buf to store z/VM user ID filter
>   * @kp:                Kernel parameter pointing to the hvc_iucv_filter =
array
>   *
>   * The function stores the filter as a comma-separated list of z/VM user=
 IDs
>   * in @buffer. Typically, sysfs routines call this function for attr sho=
w.
>   */
> -static int param_get_vmidfilter(char *buffer, const struct kernel_param =
*kp)
> +static int param_get_vmidfilter(struct seq_buf *buffer,
> +                               const struct kernel_param *kp)
>  {
> -       int rc;
>         size_t index, len;
>         void *start, *end;
>
>         if (!machine_is_vm() || !hvc_iucv_devices)
>                 return -ENODEV;
>
> -       rc =3D 0;
>         read_lock_bh(&hvc_iucv_filter_lock);
>         for (index =3D 0; index < hvc_iucv_filter_size; index++) {
>                 start =3D hvc_iucv_filter + (8 * index);
>                 end   =3D memchr(start, ' ', 8);
>                 len   =3D (end) ? end - start : 8;
> -               memcpy(buffer + rc, start, len);
> -               rc +=3D len;
> -               buffer[rc++] =3D ',';
> +               if (index)
> +                       seq_buf_putc(buffer, ',');
> +               seq_buf_printf(buffer, "%.*s", (int)len, (char *)start);
>         }
>         read_unlock_bh(&hvc_iucv_filter_lock);
> -       if (rc)
> -               buffer[--rc] =3D '\0';    /* replace last comma and updat=
e rc */
> -       return rc;
> +       return 0;
>  }
>
>  #define param_check_vmidfilter(name, p) __param_check(name, p, void)
> diff --git a/drivers/usb/storage/usb.c b/drivers/usb/storage/usb.c
> index 71dd623b95c9..637e1b8f622f 100644
> --- a/drivers/usb/storage/usb.c
> +++ b/drivers/usb/storage/usb.c
> @@ -115,27 +115,22 @@ static int parse_delay_str(const char *str, int nde=
cimals, const char *suffix,
>   * @val: The integer value to format, scaled by 10^(@ndecimals).
>   * @ndecimals: Number of decimal to scale down.
>   * @suffix: Suffix string to format.
> - * @str: Where to store the formatted string.
> - * @size: The size of buffer for @str.
> + * @s: Where to store the formatted string.
>   *
>   * Format an integer value in @val scale down by 10^(@ndecimals) without=
 @suffix
>   * if @val is divisible by 10^(@ndecimals).
>   * Otherwise format a value in @val just as it is with @suffix
> - *
> - * Returns the number of characters written into @str.
>   */
> -static int format_delay_ms(unsigned int val, int ndecimals, const char *=
suffix,
> -                       char *str, int size)
> +static void format_delay_ms(unsigned int val, int ndecimals, const char =
*suffix,
> +                           struct seq_buf *s)
>  {
>         u64 delay_ms =3D val;
>         unsigned int rem =3D do_div(delay_ms, int_pow(10, ndecimals));
> -       int ret;
>
>         if (rem)
> -               ret =3D scnprintf(str, size, "%u%s\n", val, suffix);
> +               seq_buf_printf(s, "%u%s\n", val, suffix);
>         else
> -               ret =3D scnprintf(str, size, "%u\n", (unsigned int)delay_=
ms);
> -       return ret;
> +               seq_buf_printf(s, "%u\n", (unsigned int)delay_ms);
>  }
>
>  static int delay_use_set(const char *s, const struct kernel_param *kp)
> @@ -151,11 +146,12 @@ static int delay_use_set(const char *s, const struc=
t kernel_param *kp)
>         return 0;
>  }
>
> -static int delay_use_get(char *s, const struct kernel_param *kp)
> +static int delay_use_get(struct seq_buf *s, const struct kernel_param *k=
p)
>  {
>         unsigned int delay_ms =3D *((unsigned int *)kp->arg);
>
> -       return format_delay_ms(delay_ms, 3, "ms", s, PAGE_SIZE);
> +       format_delay_ms(delay_ms, 3, "ms", s);
> +       return 0;
>  }
>
>  static DEFINE_KERNEL_PARAM_OPS(delay_use_ops, delay_use_set, delay_use_g=
et);
> diff --git a/drivers/virtio/virtio_mmio.c b/drivers/virtio/virtio_mmio.c
> index f6df9c76ee81..81a7455e4643 100644
> --- a/drivers/virtio/virtio_mmio.c
> +++ b/drivers/virtio/virtio_mmio.c
> @@ -728,24 +728,21 @@ static int vm_cmdline_set(const char *device,
>
>  static int vm_cmdline_get_device(struct device *dev, void *data)
>  {
> -       char *buffer =3D data;
> -       unsigned int len =3D strlen(buffer);
> +       struct seq_buf *s =3D data;
>         struct platform_device *pdev =3D to_platform_device(dev);
>
> -       snprintf(buffer + len, PAGE_SIZE - len, "0x%llx@0x%llx:%llu:%d\n"=
,
> -                       pdev->resource[0].end - pdev->resource[0].start +=
 1ULL,
> -                       (unsigned long long)pdev->resource[0].start,
> -                       (unsigned long long)pdev->resource[1].start,
> -                       pdev->id);
> +       seq_buf_printf(s, "0x%llx@0x%llx:%llu:%d\n",
> +                      pdev->resource[0].end - pdev->resource[0].start + =
1ULL,
> +                      (unsigned long long)pdev->resource[0].start,
> +                      (unsigned long long)pdev->resource[1].start,
> +                      pdev->id);
>         return 0;
>  }
>
> -static int vm_cmdline_get(char *buffer, const struct kernel_param *kp)
> +static int vm_cmdline_get(struct seq_buf *s, const struct kernel_param *=
kp)
>  {
> -       buffer[0] =3D '\0';
> -       device_for_each_child(&vm_cmdline_parent, buffer,
> -                       vm_cmdline_get_device);
> -       return strlen(buffer) + 1;
> +       device_for_each_child(&vm_cmdline_parent, s, vm_cmdline_get_devic=
e);
> +       return 0;
>  }
>
>  static DEFINE_KERNEL_PARAM_OPS(vm_cmdline_param_ops, vm_cmdline_set,
> diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
> index cf0405ba0dbd..123f061c2fb2 100644
> --- a/lib/dynamic_debug.c
> +++ b/lib/dynamic_debug.c
> @@ -17,6 +17,7 @@
>  #include <linux/module.h>
>  #include <linux/moduleparam.h>
>  #include <linux/kallsyms.h>
> +#include <linux/seq_buf.h>
>  #include <linux/types.h>
>  #include <linux/mutex.h>
>  #include <linux/proc_fs.h>
> @@ -787,7 +788,8 @@ EXPORT_SYMBOL(param_set_dyndbg_classes);
>   * altered by direct >control.  Displays 0x for DISJOINT, 0-N for
>   * LEVEL Returns: #chars written or <0 on error
>   */
> -int param_get_dyndbg_classes(char *buffer, const struct kernel_param *kp=
)
> +int param_get_dyndbg_classes(struct seq_buf *buffer,
> +                            const struct kernel_param *kp)
>  {
>         const struct ddebug_class_param *dcp =3D kp->arg;
>         const struct ddebug_class_map *map =3D dcp->map;
> @@ -796,11 +798,13 @@ int param_get_dyndbg_classes(char *buffer, const st=
ruct kernel_param *kp)
>
>         case DD_CLASS_TYPE_DISJOINT_NAMES:
>         case DD_CLASS_TYPE_DISJOINT_BITS:
> -               return scnprintf(buffer, PAGE_SIZE, "0x%lx\n", *dcp->bits=
);
> +               seq_buf_printf(buffer, "0x%lx\n", *dcp->bits);
> +               return 0;
>
>         case DD_CLASS_TYPE_LEVEL_NAMES:
>         case DD_CLASS_TYPE_LEVEL_NUM:
> -               return scnprintf(buffer, PAGE_SIZE, "%d\n", *dcp->lvl);
> +               seq_buf_printf(buffer, "%d\n", *dcp->lvl);
> +               return 0;
>         default:
>                 return -1;
>         }
> --
> 2.34.1
>

