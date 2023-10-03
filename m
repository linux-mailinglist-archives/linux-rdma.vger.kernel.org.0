Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB6827B74FD
	for <lists+linux-rdma@lfdr.de>; Wed,  4 Oct 2023 01:33:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232371AbjJCXd7 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 3 Oct 2023 19:33:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231189AbjJCXd6 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 3 Oct 2023 19:33:58 -0400
Received: from omta038.useast.a.cloudfilter.net (omta038.useast.a.cloudfilter.net [44.202.169.37])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD7CDC6
        for <linux-rdma@vger.kernel.org>; Tue,  3 Oct 2023 16:33:54 -0700 (PDT)
Received: from eig-obgw-5008a.ext.cloudfilter.net ([10.0.29.246])
        by cmsmtp with ESMTP
        id nlgiqLWcbqBU3notmq36KS; Tue, 03 Oct 2023 23:33:54 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with ESMTPS
        id notlq4kVU2F81notlqgAtF; Tue, 03 Oct 2023 23:33:53 +0000
X-Authority-Analysis: v=2.4 cv=a7wjSGeF c=1 sm=1 tr=0 ts=651ca4e1
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=Dx1Zrv+1i3YEdDUMOX3koA==:17
 a=OWjo9vPv0XrRhIrVQ50Ab3nP57M=:19 a=dLZJa+xiwSxG16/P+YVxDGlgEgI=:19
 a=IkcTkHD0fZMA:10 a=bhdUkHdE2iEA:10 a=wYkD_t78qR0A:10 a=Ikd4Dj_1AAAA:8
 a=VwQbUJbxAAAA:8 a=J1Y8HTJGAAAA:8 a=1XWaLZrsAAAA:8 a=20KFwNOVAAAA:8
 a=NEAV23lmAAAA:8 a=cm27Pg_UAAAA:8 a=YSKGN3ub9cUXa_79IdMA:9 a=QEXdDO2ut3YA:10
 a=AjGcO6oz07-iQ99wixmX:22 a=y1Q9-5lHfBjTkpIzbSAN:22 a=xmb-EsYY8bH0VWELuYED:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=YH/AzHDtLtkSEGt7f3Aw5RIuOoFUwUUQWzrJUM+SNVg=; b=FJwdy7+XrdhVMaIBv+J5fhB78l
        V8yT1VCXDuhn0PacsFLb2Q91XIFt1AS6ShKoVNS7wn3fyMT8FBAkLDvnwjL1YcYcDaO+IX2pjhO5L
        h7ovVuHJ+m9KiWfooJbQr2PuzxqoFJvWzJxvPbk9d0q/rVzoZAuN0sfm2YBjrxl6HUXvUNZTmhBNY
        jBBwkuf2vEAWjhUoKjEe2Sr919q5kjzzH8snes0a/VBTfMpmI/VFaV0Q4oFlzJaQJB+S65CEZy14g
        jquaqYm6ddGHx2EZQ+iZD59gkYcvIUjt1yXeUTQiK8K6UP4Cp0udpddc98Yukv2jgB2wyyEtoI6NL
        NGu2VvaA==;
Received: from 94-238-9-39.abo.bbox.fr ([94.238.9.39]:44052 helo=[192.168.1.98])
        by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.96)
        (envelope-from <gustavo@embeddedor.com>)
        id 1qnotk-001PAI-0m;
        Tue, 03 Oct 2023 18:33:52 -0500
Message-ID: <dc9bfbe3-ada2-0549-e56e-975aecfd22b8@embeddedor.com>
Date:   Wed, 4 Oct 2023 01:33:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] net/mlx5: Annotate struct mlx5_flow_handle with
 __counted_by
Content-Language: en-US
To:     Kees Cook <keescook@chromium.org>,
        Saeed Mahameed <saeedm@nvidia.com>
Cc:     Leon Romanovsky <leon@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-rdma@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org, llvm@lists.linux.dev
References: <20231003231730.work.166-kees@kernel.org>
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <20231003231730.work.166-kees@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 94.238.9.39
X-Source-L: No
X-Exim-ID: 1qnotk-001PAI-0m
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 94-238-9-39.abo.bbox.fr ([192.168.1.98]) [94.238.9.39]:44052
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 24
X-Org:  HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfCB9DRYN7fADfPePJpHtLK2D96S3SeCsZgUSMwrNb/oeIxlYoiDhwVNpk9UpB+pNLspWixEd5KJMTfgk64eMzJbyhfJuTY5NBn7UNDf/1hyI54IH5pSO
 4ym251VEartOR76tZz1LFxk6Ryhvxsfxyqt+Yu9zqN5IGbrSaQlkKaDtrwvONh7EIaKMT8HMeEiWI1CCcgDz90acamEVyGnz4i5In0soxJjbNmLv1skoGfvu
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



On 10/4/23 01:17, Kees Cook wrote:
> Prepare for the coming implementation by GCC and Clang of the __counted_by
> attribute. Flexible array members annotated with __counted_by can have
> their accesses bounds-checked at run-time via CONFIG_UBSAN_BOUNDS (for
> array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
> functions).
> 
> As found with Coccinelle[1], add __counted_by for struct mlx5_flow_handle.
> 
> Cc: Saeed Mahameed <saeedm@nvidia.com>
> Cc: Leon Romanovsky <leon@kernel.org>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Eric Dumazet <edumazet@google.com>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Paolo Abeni <pabeni@redhat.com>
> Cc: netdev@vger.kernel.org
> Cc: linux-rdma@vger.kernel.org
> Link: https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci [1]
> Signed-off-by: Kees Cook <keescook@chromium.org>

Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Thanks
--
Gustavo

> ---
>   drivers/net/ethernet/mellanox/mlx5/core/fs_core.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/fs_core.h b/drivers/net/ethernet/mellanox/mlx5/core/fs_core.h
> index 4aed1768b85f..78eb6b7097e1 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/fs_core.h
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/fs_core.h
> @@ -181,7 +181,7 @@ struct mlx5_flow_rule {
>   
>   struct mlx5_flow_handle {
>   	int num_rules;
> -	struct mlx5_flow_rule *rule[];
> +	struct mlx5_flow_rule *rule[] __counted_by(num_rules);
>   };
>   
>   /* Type of children is mlx5_flow_group */
