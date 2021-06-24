Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3777F3B33B6
	for <lists+linux-rdma@lfdr.de>; Thu, 24 Jun 2021 18:15:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229884AbhFXQRd (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 24 Jun 2021 12:17:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:53405 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229796AbhFXQRc (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 24 Jun 2021 12:17:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624551313;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LfvmV+T2Wa7crMF2XTjjbjPZJO3tZTgNFMxtYVD+sIQ=;
        b=T98GJqVBxEl7cu7diR8cFz7/da2vz0qm5QccZDtwaUFcmdLnZs7BE67WcMIHlH2Bytbuqo
        76VsmS7MI/betOfUB0PCh6BM92Cx2/hMRKbaQeQd7rt4HbUfSHQmDUpPqM1pwGN7zTD7LJ
        gYVsO4gfH7stS8CRB8h8Rnnil8cZRjs=
Received: from mail-yb1-f199.google.com (mail-yb1-f199.google.com
 [209.85.219.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-245-uS_HE5kBPImhtWgqXx0naw-1; Thu, 24 Jun 2021 12:14:53 -0400
X-MC-Unique: uS_HE5kBPImhtWgqXx0naw-1
Received: by mail-yb1-f199.google.com with SMTP id a4-20020a25f5040000b029054df41d5cceso30101ybe.18
        for <linux-rdma@vger.kernel.org>; Thu, 24 Jun 2021 09:14:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LfvmV+T2Wa7crMF2XTjjbjPZJO3tZTgNFMxtYVD+sIQ=;
        b=eTTk6FNc6fnKovYFhlY5DPBtibiALTX3RAdu8FVok9suYCOlIjgCPXUVFHCQPQ8TBQ
         BQP/4FCG2iIO7HUmbbfZUidONiKdxQdG1OGqKLgeVnG4sbeNAjhqfIdsbUkofM2D8END
         2mX6G6ERVIGwcZ9pQTAB2GetWOD+HnehU73oXvFicpwhLxpmDLTiN0sktU/bsH94ME10
         gN1lSKOE8qUYoYAqk00TdB9C7AQXfnhuySCgwsHkn4ckMYHw702Y+2J2gFnOSxetNdbw
         dS3efFmRdbA8tnzAmaYrYhlCio9AC2iq3cElMotVaoBwPgVyEDJeOg5VG+2lLFo6Ot1z
         9EEg==
X-Gm-Message-State: AOAM532EHuZJ7aNr2Oocy42SXHYfrc7OshXM9oebxRG+dlGXv467Okb/
        Z6igK4R2jTesqustyJYmvKfpCm89J8ClU4DT+2TAOAul7Qla563nbsVszA/H7ZwD9M3OAagctml
        3zHqgZIF919EUeWurXpaS+ln5dt5QOGWqvryj9g==
X-Received: by 2002:a25:d44f:: with SMTP id m76mr6043145ybf.198.1624551293303;
        Thu, 24 Jun 2021 09:14:53 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyMNcdYCX1QZmZq62f1moLJxumIV0BcdcQYOU46uw4GOrUTffvwjZf9CwVJS7OhiIWaEKYG39RDgBUapSr2FoY=
X-Received: by 2002:a25:d44f:: with SMTP id m76mr6043119ybf.198.1624551293115;
 Thu, 24 Jun 2021 09:14:53 -0700 (PDT)
MIME-Version: 1.0
References: <CAHj4cs8cT23z+h2i+g6o3OQqEhWnHS88JO4jNoQo0Nww-sdkYg@mail.gmail.com>
 <3c86dc88-97d9-5a71-20e1-a90279f47db5@grimberg.me> <CAHj4cs_3eLZd=vxRRrnBU2W4H38mqttcy0ZdSw6uw4KvbJWgeQ@mail.gmail.com>
 <CAHj4cs_VZ7C7ciKy-q51a+Gc=uce0GDKRHNmUdoGOd7KSvURpA@mail.gmail.com> <84208be5-a7a9-5261-398c-fa9bda3efbe3@grimberg.me>
In-Reply-To: <84208be5-a7a9-5261-398c-fa9bda3efbe3@grimberg.me>
From:   Yi Zhang <yi.zhang@redhat.com>
Date:   Fri, 25 Jun 2021 00:14:42 +0800
Message-ID: <CAHj4cs8dgNNE5qcX3Y4ykuTYU8z_kea6=q64Pn_2vsdodgOJZQ@mail.gmail.com>
Subject: Re: [bug report] NVMe/IB: reset_controller need more than 1min
To:     Sagi Grimberg <sagi@grimberg.me>
Cc:     linux-nvme@lists.infradead.org, linux-rdma@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Jun 24, 2021 at 5:32 AM Sagi Grimberg <sagi@grimberg.me> wrote:
>
>
> > Hello
> >
> > Gentle ping here, this issue still exists on latest 5.13-rc7
> >
> > # time nvme reset /dev/nvme0
> >
> > real 0m12.636s
> > user 0m0.002s
> > sys 0m0.005s
> > # time nvme reset /dev/nvme0
> >
> > real 0m12.641s
> > user 0m0.000s
> > sys 0m0.007s
>
> Strange that even normal resets take so long...
> What device are you using?

Hi Sagi

Here is the device info:
Mellanox Technologies MT27700 Family [ConnectX-4]

>
> > # time nvme reset /dev/nvme0
> >
> > real 1m16.133s
> > user 0m0.000s
> > sys 0m0.007s
>
> There seems to be a spurious command timeout here, but maybe this
> is due to the fact that the queues take so long to connect and
> the target expires the keep-alive timer.
>
> Does this patch help?

The issue still exists, let me know if you need more testing for it. :)


> --
> diff --git a/drivers/nvme/target/fabrics-cmd.c
> b/drivers/nvme/target/fabrics-cmd.c
> index 7d0f3523fdab..f4a7db1ab3e5 100644
> --- a/drivers/nvme/target/fabrics-cmd.c
> +++ b/drivers/nvme/target/fabrics-cmd.c
> @@ -142,6 +142,14 @@ static u16 nvmet_install_queue(struct nvmet_ctrl
> *ctrl, struct nvmet_req *req)
>                  }
>          }
>
> +       /*
> +        * Controller establishment flow may take some time, and the
> host may not
> +        * send us keep-alive during this period, hence reset the
> +        * traffic based keep-alive timer so we don't trigger a
> +        * controller teardown as a result of a keep-alive expiration.
> +        */
> +       ctrl->reset_tbkas = true;
> +
>          return 0;
>
>   err:
> --
>
> >> target:
> >> [  934.306016] nvmet: creating controller 1 for subsystem testnqn for
> >> NQN nqn.2014-08.org.nvmexpress:uuid:4c4c4544-0056-4c10-8058-b7c04f383432.
> >> [  944.875021] nvmet: ctrl 1 keep-alive timer (5 seconds) expired!
> >> [  944.900051] nvmet: ctrl 1 fatal error occurred!
> >> [ 1005.628340] nvmet: creating controller 1 for subsystem testnqn for
> >> NQN nqn.2014-08.org.nvmexpress:uuid:4c4c4544-0056-4c10-8058-b7c04f383432.
> >>
> >> client:
> >> [  857.264029] nvme nvme0: resetting controller
> >> [  864.115369] nvme nvme0: creating 40 I/O queues.
> >> [  867.996746] nvme nvme0: mapped 40/0/0 default/read/poll queues.
> >> [  868.001673] nvme nvme0: resetting controller
> >> [  935.396789] nvme nvme0: I/O 9 QID 0 timeout
> >> [  935.402036] nvme nvme0: Property Set error: 881, offset 0x14
> >> [  935.438080] nvme nvme0: creating 40 I/O queues.
> >> [  939.332125] nvme nvme0: mapped 40/0/0 default/read/poll queues.
>


-- 
Best Regards,
  Yi Zhang

