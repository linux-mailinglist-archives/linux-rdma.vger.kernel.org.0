Return-Path: <linux-rdma+bounces-3872-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EB7E59319D3
	for <lists+linux-rdma@lfdr.de>; Mon, 15 Jul 2024 19:50:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 74C621F21E44
	for <lists+linux-rdma@lfdr.de>; Mon, 15 Jul 2024 17:50:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 904D150269;
	Mon, 15 Jul 2024 17:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nPf3uUwk"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com [209.85.222.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE64B22318;
	Mon, 15 Jul 2024 17:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721065821; cv=none; b=JfRrp6nTF4a/KIm7669BE0/AbRZagrgm3qNNW7XfwyyrrlE+tZR9Q9IWBVOpGqvZaNG9jaC7B5IO1oYZhQ17tqaehJVQjEaBxCdT6gdz3pC7M1dazlmqDxyNFJ6uV63GwS13DY0gwYrJS7YAYKF9eve0syFMj7Y/+eJxGNjliP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721065821; c=relaxed/simple;
	bh=4+i1UsL97O1JksI3ZE8/xZjUcQ+JJkVk0QoBSx0+CDY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=diM0HTuVpubLEeGCPE7xSBzUjClDiLnh9e0f7PuJ9hKqXqJ++2aoRGahkPG70MFrukzHI/X3WeSgVr3Msg2rp4jLlZutGPlHXnxG9lqszVCnjZ5+VVJLvb7aKdHkB+jWpXrlDX+lV4e2kLmsUC+/S18bBZPVhcYPiNpP1Yu7wbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nPf3uUwk; arc=none smtp.client-ip=209.85.222.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f51.google.com with SMTP id a1e0cc1a2514c-8100eb38a99so1267323241.2;
        Mon, 15 Jul 2024 10:50:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721065818; x=1721670618; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ERxQCYashp1sXDomDBYo1CjjiKALhd05RJix5zIQ6dQ=;
        b=nPf3uUwkHT76rwxMGL1dpUirip6Ua/Bsy9F4r3ADXyUSqm+Euoa1qzGWelg4itgU7o
         1JCUa1/fAzgYihModhQDaWk8iOhcsvJtMQz9pdgeT4KZxWGUx7gYQpVAwyC1ERQf7roH
         773RTCCr1SayqCipWg1UQZubslzFVAKygOs81IqUIcD+fSpVMGgshrlgKsKwnfmMOYlA
         i3BVLIQLRFx2IpTGXZW9G1PIU3di0zfP/0eclZs8SOPnvEpXh9D9dMxfzIwAT4Qje9pV
         8UNcxKtRXcLpL0oka7pUsigNvvpzNidTleqL2QPihV6kiqrqnRGj9QcyEvJcIloLStsE
         /j8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721065818; x=1721670618;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ERxQCYashp1sXDomDBYo1CjjiKALhd05RJix5zIQ6dQ=;
        b=Zc8uuZd7e8K3Tj9bL0UYjnnnkK+kx+aX0Lw45y0IZ7H3klS99j9KlkS7cYyUb2/lHi
         x+C9ZADd+RmgAPHmJDdr8P+1SIsLy48eGH/qQAZYMLAlcukXpBP149ZoEvudbIQlzfDN
         Gf1nBbe9EZLvviIQqUQh0iAVSFm+XbLo5MncPC2jAsmwrgURitchoyEDQLSFYcLkRKU+
         BPiKC6GFn4iMMhg5wMdqAe38fSvNMIygKQxk6nkh+/OqlyKMcALFyNOgwsLuJoCR2Xl5
         +ej/yBPWPARLyOuhPSaB9ppELzNm05qFGPfG9OTJg/srmTjW5ERqh/6Q5K6ycGfLBU9Z
         m8dQ==
X-Forwarded-Encrypted: i=1; AJvYcCVRneKzmhM0t3W09fqhs57qZqh2g5iEZaCn5UvBTZVSTJ5Pn4Ejf8cNSn8HFfQZ6a7FkJBeNfjtba8bEYlvr0qC+/oHC/EnVIgDg10lFOE3pGd1Gptyywh9ejfV11G8FDRvws8rl34iZYi7vyq/E6kvGZI4ZPwITMcTrhMZiQDFGw==
X-Gm-Message-State: AOJu0YwkqTwgUQrXn8g/S1QwlnDK1ESqsbWdWBTpSNc+Cx35UI29PeY9
	LQRrHCNJkR0biUDCa33RiqPwObXxDdNrI5NsBi2ueyw6GSGmWsObcZSQEx1L2qj58+KgNEoDY08
	4waYU0KklTtkaIJSc4p4sWtdyBl8=
X-Google-Smtp-Source: AGHT+IHKfckH9egHQidXByx58hTCytqVIN7acGBSHE2qTxXBij6F29KNRiJ+g4pQoQbZW58b4wWt7Ews7b39sGYS90c=
X-Received: by 2002:a05:6122:3127:b0:4ec:f6f2:f1cd with SMTP id
 71dfb90a1353d-4f4cd2c2e14mr813292e0c.9.1721065818535; Mon, 15 Jul 2024
 10:50:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240621050525.3720069-1-allen.lkml@gmail.com>
 <20240621050525.3720069-14-allen.lkml@gmail.com> <ba3b8f5907c071e40be68758f2a11662008713e8.camel@redhat.com>
 <CAOMdWSKKyqaJB2Psgcy9piUv3LTDBHhbo_g404fSmqQrVSyr7Q@mail.gmail.com> <7348f2c9f594dd494732c481c0e35638ae064988.camel@redhat.com>
In-Reply-To: <7348f2c9f594dd494732c481c0e35638ae064988.camel@redhat.com>
From: Allen <allen.lkml@gmail.com>
Date: Mon, 15 Jul 2024 10:50:06 -0700
Message-ID: <CAOMdWSKU_Ezk-15whDnNQKK_is2UtBOY59_4fPfKZE0-K+cB6w@mail.gmail.com>
Subject: Re: [PATCH 13/15] net: jme: Convert tasklet API to new bottom half
 workqueue mechanism
To: Paolo Abeni <pabeni@redhat.com>
Cc: kuba@kernel.org, Guo-Fu Tseng <cooldavid@cooldavid.org>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, jes@trained-monkey.org, 
	kda@linux-powerpc.org, cai.huoqing@linux.dev, dougmill@linux.ibm.com, 
	npiggin@gmail.com, christophe.leroy@csgroup.eu, aneesh.kumar@kernel.org, 
	naveen.n.rao@linux.ibm.com, nnac123@linux.ibm.com, tlfalcon@linux.ibm.com, 
	marcin.s.wojtas@gmail.com, mlindner@marvell.com, stephen@networkplumber.org, 
	nbd@nbd.name, sean.wang@mediatek.com, Mark-MC.Lee@mediatek.com, 
	lorenzo@kernel.org, matthias.bgg@gmail.com, 
	angelogioacchino.delregno@collabora.com, borisp@nvidia.com, 
	bryan.whitehead@microchip.com, UNGLinuxDriver@microchip.com, 
	louis.peens@corigine.com, richardcochran@gmail.com, 
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-acenic@sunsite.dk, linux-net-drivers@amd.com, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> > > > @@ -1326,22 +1326,22 @@ static void jme_link_change_work(struct work_struct *work)
> > > >               jme_start_shutdown_timer(jme);
> > > >       }
> > > >
> > > > -     goto out_enable_tasklet;
> > > > +     goto out_enable_bh_work;
> > > >
> > > >  err_out_free_rx_resources:
> > > >       jme_free_rx_resources(jme);
> > > > -out_enable_tasklet:
> > > > -     tasklet_enable(&jme->txclean_task);
> > > > -     tasklet_enable(&jme->rxclean_task);
> > > > -     tasklet_enable(&jme->rxempty_task);
> > > > +out_enable_bh_work:
> > > > +     enable_and_queue_work(system_bh_wq, &jme->txclean_bh_work);
> > > > +     enable_and_queue_work(system_bh_wq, &jme->rxclean_bh_work);
> > > > +     enable_and_queue_work(system_bh_wq, &jme->rxempty_bh_work);
> > >
> > > This will unconditionally schedule the rxempty_bh_work and is AFAICS a
> > > different behavior WRT prior this patch.
> > >
> > > In turn the rxempty_bh_work() will emit (almost unconditionally) the
> > > 'RX Queue Full!' message, so the change should be visibile to the user.
> > >
> > > I think you should queue the work only if it was queued at cancel time.
> > > You likely need additional status to do that.
> > >
> >
> >  Thank you for taking the time out to review. Now that it's been a week, I was
> > preparing to send out version 3. Before I do that, I want to make sure if this
> > the below approach is acceptable.
>
> I _think_ the following does not track the  rxempty_bh_work 'queued'
> status fully/correctly.
>
> > @@ -1282,9 +1282,9 @@ static void jme_link_change_work(struct work_struct *work)
> >                 jme_stop_shutdown_timer(jme);
> >
> >         jme_stop_pcc_timer(jme);
> > -       tasklet_disable(&jme->txclean_task);
> > -       tasklet_disable(&jme->rxclean_task);
> > -       tasklet_disable(&jme->rxempty_task);
> > +       disable_work_sync(&jme->txclean_bh_work);
> > +       disable_work_sync(&jme->rxclean_bh_work);
> > +       disable_work_sync(&jme->rxempty_bh_work);
>
> I think the above should be:
>
>           jme->rxempty_bh_work_queued = disable_work_sync(&jme->rxempty_bh_work);
>
> [...]
> > @@ -1326,22 +1326,23 @@ static void jme_link_change_work(struct
> > work_struct *work)
> >                 jme_start_shutdown_timer(jme);
> >         }
> >
> > -       goto out_enable_tasklet;
> > +       goto out_enable_bh_work;
> >
> >  err_out_free_rx_resources:
> >         jme_free_rx_resources(jme);
> > -out_enable_tasklet:
> > -       tasklet_enable(&jme->txclean_task);
> > -       tasklet_enable(&jme->rxclean_task);
> > -       tasklet_enable(&jme->rxempty_task);
> > +out_enable_bh_work:
> > +       enable_and_queue_work(system_bh_wq, &jme->txclean_bh_work);
> > +       enable_and_queue_work(system_bh_wq, &jme->rxclean_bh_work);
> > +       if (jme->rxempty_bh_work_queued)
> > +               enable_and_queue_work(system_bh_wq, &jme->rxempty_bh_work);
>
> Missing:
>
>           else
>                 enable_work(system_bh_wq, &jme->rxempty_bh_work);
>
> [...]
> > @@ -3180,9 +3182,9 @@ jme_suspend(struct device *dev)
> >         netif_stop_queue(netdev);
> >         jme_stop_irq(jme);
> >
> > -       tasklet_disable(&jme->txclean_task);
> > -       tasklet_disable(&jme->rxclean_task);
> > -       tasklet_disable(&jme->rxempty_task);
> > +       disable_work_sync(&jme->txclean_bh_work);
> > +       disable_work_sync(&jme->rxclean_bh_work);
> > +       disable_work_sync(&jme->rxempty_bh_work);
>
> should be:
>
>           jme->rxempty_bh_work_queued = disable_work_sync(&jme->rxempty_bh_work);
>
>
> >
> > @@ -3198,9 +3200,10 @@ jme_suspend(struct device *dev)
> >                 jme->phylink = 0;
> >         }
> >
> > -       tasklet_enable(&jme->txclean_task);
> > -       tasklet_enable(&jme->rxclean_task);
> > -       tasklet_enable(&jme->rxempty_task);
> > +       enable_and_queue_work(system_bh_wq, &jme->txclean_bh_work);
> > +       enable_and_queue_work(system_bh_wq, &jme->rxclean_bh_work);
> > +       jme->rxempty_bh_work_queued = true;
> > +       enable_and_queue_work(system_bh_wq, &jme->rxempty_bh_work);
>
> should be:
>
>         if (jme->rxempty_bh_work_queued)
>                 enable_and_queue_work(system_bh_wq, &jme->rxempty_bh_work);
>         else
>                 enable_work(system_bh_wq, &jme->rxempty_bh_work);
>
> I think the above ones are the only places where you need to touch
> 'rxempty_bh_work_queued'.
>
>
> [...]
> >   Do we need a flag for rxclean and txclean too?
>
> Functionally speaking I don't think it will be necessary, as
> rxclean_bh_work() and txclean_bh_work() don't emit warnings on spurious
> invocation.
>
> Thanks,
>
> Paolo
>

Thank you very much. Will send out v3 later today with these changes.
Note, it will be as follows, enable_work() does not have workqueue type.

+  if (jme->rxempty_bh_work_queued)
+                 enable_and_queue_work(system_bh_wq, &jme->rxempty_bh_work);
+         else
-                 enable_work(system_bh_wq, &jme->rxempty_bh_work);
+                enable_work(&jme->rxempty_bh_work);

Thanks,
Allen
>


-- 
       - Allen

