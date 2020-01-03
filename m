Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6BE2112F1F8
	for <lists+linux-rdma@lfdr.de>; Fri,  3 Jan 2020 01:03:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725945AbgACADH (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 2 Jan 2020 19:03:07 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:44561 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725872AbgACADH (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 2 Jan 2020 19:03:07 -0500
Received: by mail-pl1-f196.google.com with SMTP id az3so18397705plb.11;
        Thu, 02 Jan 2020 16:03:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=kQYT9vzc9GleDX35KjavFeofTBfL9ojiLY8c2Nl6ELE=;
        b=X5K3LbbYSWA3ZhEjqTDIXExCfUehM+0UckWMne7XyrviSlkFFmDUaeni4iLurdLfyc
         REtl2ASyyEnXW915+T0u2Bq0b+aJeOIEITyOO9sF82yLyUhKKS7DVowPsoZ/kJ8Ll21u
         7T1hYDdQrPTCwapUxVBpik/+vdLMsT12FXiENMVrau0WvPi2SSE0vb0G7Rqqp8b2rjSG
         6T21JE5PnSt0fOnZoFXmlow4ypwjQ4F7exYkov2wBusGjIzRA/GfzpzuFmEQgkK4yD5k
         PNllptT4GK/qxkQhpuMUWoFT383W0kT2BtA+lJUMTviRnLfC4LpZTKXfL5x2VEmB7feC
         OMvg==
X-Gm-Message-State: APjAAAU2Y4lNy69KdMht0nkgh9ao601+Vm1UQ76aS1tFWD+ftHnRTdYA
        ry7JzlUcVH15bBaVMDpaDsw=
X-Google-Smtp-Source: APXvYqxPHldaGH9ykKiZi+UJarbfU5FmjDtHL1Lg4oSxQmnjT/pU4oabFUpU2xSwEPwkm0ArgFnsww==
X-Received: by 2002:a17:90a:d34c:: with SMTP id i12mr23014476pjx.18.1578009786519;
        Thu, 02 Jan 2020 16:03:06 -0800 (PST)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id e9sm62942751pgn.49.2020.01.02.16.03.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Jan 2020 16:03:05 -0800 (PST)
Subject: Re: [PATCH v6 18/25] rnbd: client: sysfs interface functions
To:     Jack Wang <jinpuwang@gmail.com>, linux-block@vger.kernel.org,
        linux-rdma@vger.kernel.org
Cc:     axboe@kernel.dk, hch@infradead.org, sagi@grimberg.me,
        leon@kernel.org, dledford@redhat.com, danil.kipnis@cloud.ionos.com,
        jinpu.wang@cloud.ionos.com, rpenyaev@suse.de
References: <20191230102942.18395-1-jinpuwang@gmail.com>
 <20191230102942.18395-19-jinpuwang@gmail.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <e0816733-89c0-87a5-bc86-6013a6c96df2@acm.org>
Date:   Thu, 2 Jan 2020 16:03:04 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191230102942.18395-19-jinpuwang@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 12/30/19 2:29 AM, Jack Wang wrote:
> +static const match_table_t rnbd_opt_tokens = {
> +	{	RNBD_OPT_PATH,		"path=%s"		},
> +	{	RNBD_OPT_DEV_PATH,	"device_path=%s"	},
> +	{	RNBD_OPT_ACCESS_MODE,	"access_mode=%s"	},
> +	{	RNBD_OPT_SESSNAME,	"sessname=%s"		},
> +	{	RNBD_OPT_ERR,		NULL			},
> +};


Please follow the example of other kernel code and change 
"{<tab>...<tab>}" into "{ ... }".

> +/* remove new line from string */
> +static void strip(char *s)
> +{
> +	char *p = s;
> +
> +	while (*s != '\0') {
> +		if (*s != '\n')
> +			*p++ = *s++;
> +		else
> +			++s;
> +	}
> +	*p = '\0';
> +}

Does this function change a multiline string into a single line? I'm not 
sure that is how sysfs input should be processed ... Is this perhaps 
what you want?

static inline void kill_final_newline(char *str)
{
	char *newline = strrchr(str, '\n');

	if (newline && !newline[1])
		*newline = 0;
}

> +static struct kobj_attribute rnbd_clt_map_device_attr =
> +	__ATTR(map_device, 0644,
> +	       rnbd_clt_map_device_show, rnbd_clt_map_device_store);

Could __ATTR_RW() have been used here?

Thanks,

Bart.
