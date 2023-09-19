Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0330B7A5E49
	for <lists+linux-rdma@lfdr.de>; Tue, 19 Sep 2023 11:40:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231274AbjISJkb (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 19 Sep 2023 05:40:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231527AbjISJk2 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 19 Sep 2023 05:40:28 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74753123;
        Tue, 19 Sep 2023 02:40:22 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A781C433C8;
        Tue, 19 Sep 2023 09:40:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695116422;
        bh=1W+RHNKneW2lSWYUJv9c0K/rO7LlJrAh0C1ermQDmPM=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=dYfspwzi29ZpE8TGLJJHwniJ0FECLJuib/RKR7Hy666KEaxriDEmslxjOEAfCnaxI
         zSYA1GYxhamjWYym4bPvYUC0Q0AZo6m+HoSLT1vcJjZcDW9mztF0XmpOJr0ar/TGGH
         skHEsbWaGdLXm2gwctjZTyLoOgoEw3OhJeFZUzUki9nbOk0NtDtswAy1g5dQUW3QY0
         2+0yN5bMzBMWMB3PI326g1n40jKV6fIHlDperqFcYLJok93eqXMNMp6qVEZTvF5TcW
         fVAHGI3usWzY5c+WiaPLfbomx7S8Rb0WLMGN7I+YIJv+FDRW0oRn1JRaxRSakGuBrR
         8QyCyIZvKiVnQ==
From:   Kalle Valo <kvalo@kernel.org>
To:     Ilpo =?utf-8?Q?J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     linux-pci@vger.kernel.org, Bjorn Helgaas <helgaas@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Lukas Wunner <lukas@wunner.de>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
        linux-kernel@vger.kernel.org,
        Jeff Johnson <quic_jjohnson@quicinc.com>,
        ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        ath10k@lists.infradead.org, ath12k@lists.infradead.org,
        intel-wired-lan@lists.osuosl.org,
        linux-arm-kernel@lists.infradead.org,
        linux-bluetooth@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-rdma@vger.kernel.org,
        netdev@vger.kernel.org
Subject: Re: [PATCH v2 10/13] wifi: ath11k: Use pci_disable/enable_link_state()
References: <20230918131103.24119-1-ilpo.jarvinen@linux.intel.com>
        <20230918131103.24119-11-ilpo.jarvinen@linux.intel.com>
Date:   Tue, 19 Sep 2023 12:40:15 +0300
In-Reply-To: <20230918131103.24119-11-ilpo.jarvinen@linux.intel.com> ("Ilpo
        =?utf-8?Q?J=C3=A4rvinen=22's?= message of "Mon, 18 Sep 2023 16:11:00
 +0300")
Message-ID: <87il86biww.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com> writes:

> ath11k driver adjusts ASPM state itself which leaves ASPM service
> driver in PCI core unaware of the link state changes the driver
> implemented.
>
> Call pci_disable_link_state() and pci_enable_link_state() instead of
> adjusting ASPMC field in LNKCTL directly in the driver and let PCI core
> handle the ASPM state management.
>
> Signed-off-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>

Acked-by: Kalle Valo <kvalo@kernel.org>

--=20
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatc=
hes
